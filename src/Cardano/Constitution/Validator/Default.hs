module Cardano.Constitution.Validator.Default
    ( module Cardano.Constitution.Validator
    , defaultValidatorsWithCodes
    , defaultValidators
    , defaultValidatorCodes
    ) where

import Cardano.Constitution.Config.Default
import Cardano.Constitution.Validator

import Data.Map.Strict qualified as M
import PlutusTx.Code
import Data.Bifunctor

defaultValidatorsWithCodes :: M.Map String (ConstitutionValidator, CompiledCode ConstitutionValidator)
defaultValidatorsWithCodes =
    -- apply the configuration
    (bimap ($ defaultConstitutionConfig) ($ defaultConstitutionConfig)) <$> validatorsWithCodes

defaultValidators :: M.Map String ConstitutionValidator
defaultValidators = fmap fst defaultValidatorsWithCodes

defaultValidatorCodes :: M.Map String (CompiledCode ConstitutionValidator)
defaultValidatorCodes = fmap snd defaultValidatorsWithCodes
