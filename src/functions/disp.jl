function disp(plot)
  save("tmp.png", plot);
  run(`open -g tmp.png`);
end

