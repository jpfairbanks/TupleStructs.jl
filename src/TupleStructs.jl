module TupleStructs
export tostruct

"""tostruct: creates an expression ex that when eval'ed creates type structname
The field types are taken sequentially from t.types.
The field names are generated sequentially as "fi" where i is the index into types.

A classic example from the manual:

```
    eval(tostruct(:Point, Tuple{Float64, Float64})
    p =  Point(1.5, 2.0)
    @assert p.f1 == 1.5
    @assert p.f2 == 2.0
```

Keep in mind that types cannot be recreated in the same scope.
See tests for more examples.
"""
function tostruct(structname::Symbol, t::Type)
   types = t.types
   ex = quote
       type $structname
       end
   end
   for (i,ty) in enumerate(types)
       fieldname = symbol("f$i")
       fielddef = :($fieldname::$ty)
       push!(ex.args[2].args[3].args, fielddef)
   end
   return ex
end

end
