var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "DataUtils",
    "title": "DataUtils",
    "category": "page",
    "text": ""
},

{
    "location": "index.html#DataUtils-1",
    "page": "DataUtils",
    "title": "DataUtils",
    "category": "section",
    "text": "Useful utilities and toolsThe source repository is https://github.com/jlapeyre/DataUtils.jl.No names are exported.If some of this code duplicates functionality available elsewhere, or if it would find a good home in a well-supported package, please open an issue at the github repository."
},

{
    "location": "index.html#Contents-1",
    "page": "DataUtils",
    "title": "Contents",
    "category": "section",
    "text": ""
},

{
    "location": "index.html#Index-1",
    "page": "DataUtils",
    "title": "Index",
    "category": "section",
    "text": ""
},

{
    "location": "index.html#DataUtils.countmap",
    "page": "DataUtils",
    "title": "DataUtils.countmap",
    "category": "function",
    "text": "countmap(iter; datatype=Any, dicttype=Dict)\n\nReturn an AbstractDict counting the number of occurences of elements in iter.\n\nUnlike StatsBase.countmap, DataUtils.countmap does not require that one first calls collect on iter if iter is not an AbstractArray. DataUtils.countmap accepts any iterator, including one that may generate more values than can be stored in memory.\n\nDataUtils.countmap does not implement a fast, radix sort as StatsBase.countmap does.\n\nExample\n\njulia> import StatsBase; import DataUtils;\n\njulia> d = Dict(rand(1:1000) => rand(1:5) for i in 1:100);\n\njulia> StatsBase.countmap(values(d))\nERROR: MethodError: no method matching countmap(::Base.ValueIterator{Dict{Int64,Int64}})\n...\n\njulia> DataUtils.countmap(values(d))\nDict{Any,Int64} with 5 entries:\n  4 => 19\n  2 => 21\n  3 => 20\n  5 => 11\n  1 => 25\n\n\n\n\n\ncountmap(iter::AbstractArray{T}; dicttype=Dict) where {T}\n\nEquivalent to calling countmap(iter; datatype=Any, dicttype=Dict), with datatype=T.\n\n\n\n\n\n"
},

{
    "location": "index.html#DataUtils.writecopyconstructor",
    "page": "DataUtils",
    "title": "DataUtils.writecopyconstructor",
    "category": "function",
    "text": "writecopyconstructor(mod, T; evaluate=true)\n\nConstructs and compiles a simple copy constructor for struct type T. Each field is copied if a corresponding method for copy exists, and is passed unaltered otherwise. The code creating the copy constructor is evaluated in module mod. If evaluate is false, the expression defining the copy method is returned and is not evaluted.\n\nNote that the copy methods for the fields must exist at the time writecopyconstructor is called.\n\nExample\n\nstruct A\n a::Int\n b::String\n c::Vector\nend\n\njulia> DataUtils.writecopyconstructor(Main, A)\n\njulia> x = A(1, \"hi\", [1, 2])\nA(1, \"hi\", [1, 2])\n\njulia> y = copy(x)\nA(1, \"hi\", [1, 2])\n\njulia> x.c[1] = 7;\n\njulia> x\nA(1, \"hi\", [7, 2])\n\njulia> y\nA(1, \"hi\", [1, 2])\n\n\n\n\n\n"
},

{
    "location": "index.html#Functions-1",
    "page": "DataUtils",
    "title": "Functions",
    "category": "section",
    "text": "DataUtils.countmap\nDataUtils.writecopyconstructor"
},

]}
