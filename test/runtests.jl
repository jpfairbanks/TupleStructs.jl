"""
TestTupleStructs is necessary as a module because we define new types and want to be able to include this file multiple times without generating redefinition of constant errors.

These tests make a test file test.jld in order to ensure that the resulting types are able to be stored in JLD format.

"""
module TestTupleStructs
using Base.Test
using TupleStructs

ex = quote 
    type S1 
        a::Int64;
        b::Int 
    end
end
eval(ex)
p = S1(1,3)
@test p.a == 1
@test p.b == 3

ts = tostruct(:S, Tuple{Int, Int})
eval(ts)
q = S(1,3)
@test q.f1 == 1
@test q.f2 == 3



@show ts = tostruct(:T, Tuple{Int64, Int, ASCIIString, Tuple{Int, Float64}})
eval(ts)
@show t= T(1, 2, "hello", (3, 0.0))
@test t.f1 == 1
@test t.f2 == 2
@test t.f3 == "hello"
@test t.f4 == (3,0.0)

function isequ(t::TestTupleStructs.T, s::TestTupleStructs.T)
    return (t.f1 == s.f1) && (t.f2 == s.f2) && (t.f3 == s.f3) && (t.f4 == s.f4)
end

import Base.==

function ==(t::TestTupleStructs.S1, s::TestTupleStructs.S1)
    return (t.a == s.a) && (t.b == s.b) 
end
function ==(t::TestTupleStructs.S, s::TestTupleStructs.S)
    return (t.f1 == s.f1) && (t.f2 == s.f2) 
end

using JLD

t2 = t
q1 = q
p1 = p
@save "test.jld" t
@save "test.jld" p
@save "test.jld" q

@load "test.jld"
@test isequ(t2,t)
@test p == p1
@test q == q1


end
