module Hygiene

using Compat, Compat.Test

import MathOptInterface
const MOI = MathOptInterface

# Dict is used in the @model macro but setting Dict in the outer scope
# should not affect it
Dict = nothing

MathOptInterface.Utilities.@model(LPModel,                      # Name of model
    (),                                                         # untyped scalar sets
    (MOI.EqualTo, MOI.GreaterThan, MOI.LessThan, MOI.Interval), #   typed scalar sets
    (MOI.Zeros, MOI.Nonnegatives, MOI.Nonpositives),            # untyped vector sets
    (),                                                         #   typed vector sets
    (MOI.SingleVariable,),                                      # untyped scalar functions
    (MOI.ScalarAffineFunction,),                                #   typed scalar functions
    (MOI.VectorOfVariables,),                                   # untyped vector functions
    (MOI.VectorAffineFunction,))                                #   typed vector functions

model = LPModel{Float64}()

@test model isa MathOptInterface.ModelLike
@test model isa MathOptInterface.Utilities.AbstractModel{Float64}

end
