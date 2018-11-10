procedure vectors_are_same: .vector1#, .vector2#, .size
  .isSame = 1 ; true
  for .i to .size
    .return *= (.vector1[.i] = .vector2[.i])
  endfor
endproc


procedure matrices_are_same: .matrix1##, .matrix2##, .size
  .return = 1 ; true
  for .i to .size
    for .j to .size
      .return *= (.matrix1##[.i, .j] = .matrix2##[.i, .j])
    endfor
  endfor
endproc
