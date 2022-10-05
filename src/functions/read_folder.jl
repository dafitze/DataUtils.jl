function read_folder(;path, header_row::Int = 1, limit = nothing, filename_to_col::Bool = true, split_filename::Bool = true, sep::String = "_")
  data = []
  files = filter(endswith(".csv"), readdir(path))

  for file in files
    tmp = CSV.read(path*"/"*file, DataFrame, header = header_row, limit = limit)
    
    if split_filename
      cols = replace(file, ".csv" => "")
      cols = split(cols, sep)
      colnumber = length(cols)
      for col in cols
        insertcols!(tmp, 1, Symbol("col_$(colnumber)") => col)
        colnumber -= 1
      end

    end

    if filename_to_col
      insertcols!(tmp, 1, :filename => file)
    end

    push!(data, tmp)
  end

  data = reduce(vcat, data)
  return data
end


