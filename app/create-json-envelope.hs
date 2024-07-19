{-# LANGUAGE OverloadedStrings #-}
import Cardano.Api (File (..), PlutusScriptV3, PlutusScriptVersion (PlutusScriptV3),
                    Script (PlutusScript), writeFileTextEnvelope)
import Cardano.Api.Shelley (PlutusScript (PlutusScriptSerialised))
import Cardano.Constitution.Config
import Cardano.Constitution.Validator.Sorted as SortedImpl (mkConstitutionCode)
import PlutusLedgerApi.Common (serialiseCompiledCode)
import System.Environment (getArgs)
import System.Exit
import Data.Aeson as Aeson

main :: IO ()
main = do
  mdefaultConfig <- Aeson.decodeFileStrict "constitutionConfig.json"
  case mdefaultConfig of
      Nothing -> die "Failed to read json constitution file at constitutionConfig.json"
      Just defaultConfig -> do
          args <- getArgs
          case args of
              [file] -> do
                  eRes <- writeFileTextEnvelope
                         (File file)
                         (Just "*BE CAREFUL* that this is compiled from a release commit of plutus and not from master")
                         (mkCompiledScript defaultConfig)
                  case eRes of
                      Left e -> die $ "enveloping error:" ++ show e
                      _ -> pure ()
              _ -> die "USAGE: create-json-envelope OUT_FILE"

mkCompiledScript :: ConstitutionConfig -> Script PlutusScriptV3
mkCompiledScript = PlutusScript PlutusScriptV3
                 . PlutusScriptSerialised
                 . serialiseCompiledCode
                 . SortedImpl.mkConstitutionCode
