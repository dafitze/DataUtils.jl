module DataUtils
using CSV, DataFrames

function read_folder(path)
  data = []

  for file in readdir(path)
    tmp = CSV.read(path*"/"*file, DataFrame)
    push!(data, tmp)
  end

  data = reduce(vcat, data)
  return data
end


end # module
