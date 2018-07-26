## Unlike `StatsBase.countmap`, `DataUtils.countmap`
## accepts an iterator `iter` that may generate more values than can
## be stored in memory.

"""
    countmap(iter; datatype=Any, dicttype=Dict)

Return an `AbstractDict` counting the number of occurences of elements
in `iter`.

Unlike `StatsBase.countmap`, `DataUtils.countmap`
does not require that one first calls `collect` on `iter` if
`iter` is not an `AbstractArray`. `DataUtils.countmap` accepts
any iterator, including one that may generate more values than can
be stored in memory.

`DataUtils.countmap` does not implement a fast, radix sort
as `StatsBase.countmap` does.
"""
function countmap(iter; datatype=Any, dicttype=Dict)
    return countmap!(dicttype{datatype,Int}(), iter)
end

"""
    countmap(iter::AbstractArray{T}; dicttype=Dict) where {T}

Equivalent to calling `countmap(iter; datatype=Any, dicttype=Dict)`,
with `datatype=T`.
"""
function countmap(a::AbstractArray{T}; dicttype=Dict) where {T}
    return countmap!(dicttype{T,Int}(), a)
end


function countmap!(cm::Dict, iter)
    for v in iter
        index = Base.ht_keyindex2!(cm, v)
        if index > 0
            @inbounds cm.vals[index] += 1
        else
            @inbounds Base._setindex!(cm, 1, v, -index)
        end
    end
    return cm
end

function countmap!(cm::AbstractDict, iter)
    for v in iter
        if haskey(cm, v)
            @inbounds cm[v] += 1
        else
            @inbounds cm[v] = 1
        end
    end
    return cm
end
