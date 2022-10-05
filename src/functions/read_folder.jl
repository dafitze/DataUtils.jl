function read_folder(;path_in, path_out = nothing, header_row::Int = 1, limit = nothing, filename_to_col::Bool = true, split_filename::Bool = true, sep::String = "_")
  data = []
  files = filter(endswith(".csv"), readdir(path_in))

  for file in files
    tmp = CSV.read(path_in*"/"*file, DataFrame, header = header_row, limit = limit)

    if filename_to_col
      if split_filename
        cols = replace(file, ".csv" => "")
        cols = split(cols, sep)
        colnumber = length(cols)
        for col in cols
          insertcols!(tmp, 1, Symbol("col_$(colnumber)") => col)
          colnumber -= 1
        end
      else
        insertcols!(tmp, 1, :filename => file)
      end
    end

    push!(data, tmp)
  end

  data = reduce(vcat, data)
  
  if !isnothing(path_out)
    CSV.write(path_out, data)
  end

  return data
end


