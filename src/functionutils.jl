"""
    writecopyconstructor(mod, T; evaluate=true)

Constructs and compiles a simple copy constructor for struct type `T`. Each field
is copied if a corresponding method for `copy` exists,
and is passed unaltered otherwise. The code creating the copy
constructor is evaluated in module `mod`. If `evaluate` is false,
the expression defining the copy method is returned and is not evaluted.

Note that the `copy` methods for the fields must exist at the time
`writecopyconstructor` is called.

# Example
```julia
struct A
 a::Int
 b::String
 c::Vector
end

julia> DataUtils.writecopyconstructor(Main, A)

julia> x = A(1, "hi", [1, 2])
A(1, "hi", [1, 2])

julia> y = copy(x)
A(1, "hi", [1, 2])

julia> x.c[1] = 7;

julia> x
A(1, "hi", [7, 2])

julia> y
A(1, "hi", [1, 2])
```
"""
function writecopyconstructor(_module, T::DataType; evaluate=true)
    _writecopyconstructor(_module, T, T, evaluate)
end

function writecopyconstructor(_module, T::UnionAll; evaluate=true)
    _writecopyconstructor(_module, T, T.body, evaluate)
end

function _writecopyconstructor(_module, T, Tdata, evaluate::Bool)
    isstructtype(T) || throw(ArgumentError("writecopyconstructor expects a struct type"))
    field_names = fieldnames(T)
    field_types = Tdata.types
    type_name =  Tdata.name
    args = Any[Symbol(type_name)]
    for (_name, _type) in zip(field_names, field_types)
        arg = if hasmethod(copy, (_type,))
            :(copy(obj.$_name))
        else
            :(obj.$_name)
        end
        push!(args, arg)
    end
    rhs = Expr(:call, args...)
    expr = Meta.parse(string(:(Base.copy(obj::$type_name) = $rhs)))
    if evaluate
        @eval _module $expr
        return nothing
    else
        return expr
    end
end
