function disp(plot)
  save("tmp.png", plot);
  run(`open tmp.png`);
end

