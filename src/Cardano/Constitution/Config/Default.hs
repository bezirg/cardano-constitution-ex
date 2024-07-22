{-# LANGUAGE TemplateHaskell #-}
module Cardano.Constitution.Config.Default
    ( module Cardano.Constitution.Config
    , defaultConstitutionConfig
    ) where

import Cardano.Constitution.Config
import Data.Aeson.THReader as Aeson

-- | The default config read from "data/defaultConstitution.json"
{-# INLINABLE defaultConstitutionConfig #-}
defaultConstitutionConfig :: ConstitutionConfig
defaultConstitutionConfig = $$(Aeson.readJSONFromFile "constitutionConfig.json")
