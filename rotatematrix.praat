procedure rotate_matrix: .matrix##, .size, .angle
  .return## = zero##(.size, .size)
  if .angle mod 360 = 90
    for .i to .size
      for .j to .size
         .return##[.i, .j] = .matrix##[.size - .j + 1, .i]
      endfor
    endfor
  elsif .angle mod 360 = 180
    for .i to .size
      for .j to .size
         .return##[.i, .j] = .matrix##[.size - .i + 1, .size - .j + 1]
      endfor
    endfor
  elsif .angle mod 360 = 270
    for .i to .size
      for .j to .size
         .return##[.i, .j] = .matrix##[.j, .size - .i + 1]
      endfor
    endfor
  elsif .angle mod 360 = 0
    .return## = .matrix##
  else
    exitScript: "argument of rotateMatrix must be multiple of 90"
  endif 
endproc

procedure reverse_matrix: .matrix##, .size, .by$
  .return## = zero##(.size, .size)
  if .by$ = "row"
    for .i to .size
      for .j to .size
        .return##[.i, .j] = .matrix##[.size - .i + 1, .j]
      endfor
    endfor
  elsif .by$ = "col"
    for .i to .size
      for .j to .size
        .return##[.i, .j] = .matrix##[.i, .size - .j + 1]
      endfor
    endfor
  else
    exitScript: "argument of rotateMatrix must be ""row"" or ""col"" "
  endif
endproc
