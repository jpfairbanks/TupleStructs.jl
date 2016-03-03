module TupleStructs
export tostruct

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
