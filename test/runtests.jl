using DataUtils
using Test

@testset "countmap" begin
    d = Dict(rand(1:1000) => rand(1:5) for i in 1:10);
    cm = DataUtils.countmap(values(d))
    @test isa(cm, Dict)
end
