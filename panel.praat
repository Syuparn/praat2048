include oop.praat
include comparevectors.praat
include rotatematrix.praat


procedure Panel: .self$
  .cls$ = "Panel"
  '.self$'.cls$ = .cls$
  '.self$'.score = 0
  '.self$'.size = 4
  '.self$'.isMoved = 1 ;true (initially)
  '.self$'.panels## = zero##('.self$'.size, '.self$'.size)
  @set_method: .self$, .cls$, "generate_cell"
  @set_method: .self$, .cls$, "_merge_same_numbers_horizontally"
  @set_method: .self$, .cls$, "_move_to_left"
  @set_method: .self$, .cls$, "move_to"
endproc

procedure Panel.generate_cell: .self$, $ 
  # generate a cell "2" randomly in blank cells
  
  if not '.self$'.isMoved
    'endproc$'
  endif
  
  # make array of current space cells (candidates of cell "2")
  .candidateNum = 0
  for .row to '.self$'.size
    for .col to '.self$'.size
      if '.self$'.panels##[.row, .col] = 0
        .candidates[.candidateNum + 1] = (.row - 1) * '.self$'.size + .col - 1
        .candidateNum += 1
      endif
    endfor
  endfor
  
  # choose the position of cell "2" in candidates randomly
  .rand = ceiling(randomUniform (0, .candidateNum))
  .chosen = .candidates[.rand]
  .chosenRow = .chosen div '.self$'.size + 1
  .chosenCol = .chosen mod '.self$'.size + 1
  '.self$'.panels##[.chosenRow, .chosenCol] = 2
  '.self$'.isMoved = 0
endproc

procedure Panel._merge_same_numbers_horizontally: .self$
  # ex) row [2, 0, 0, 2] -> [4, 0, 0, 0], score += 4
  #     row [4, 4, 0, 2] -> [8, 0, 0, 2], score += 8
  #     row [4, 4, 2, 2] -> [8, 0, 4, 0], score += 12
  for .i to '.self$'.size
    for .j to '.self$'.size - 1
      .k = .j
      repeat
        .k += 1 
        if '.self$'.panels##[.i, .j] = '.self$'.panels##[.i, .k]
          '.self$'.score += '.self$'.panels##[.i, .j] * 2
          ; *= operator cannot be used with element of vector
          '.self$'.panels##[.i, .j] = '.self$'.panels##[.i, .j] * 2
          '.self$'.panels##[.i, .k] = 0
        endif
      until .k >= '.self$'.size or '.self$'.panels##[.i, .k] <> 0
    endfor
  endfor
endproc

procedure Panel._move_to_left: .self$
  .curPanels## = '.self$'.panels##
  .self._merge_same_numbers_horizontally$ = '.self$'._merge_same_numbers_horizontally$
  @'.self._merge_same_numbers_horizontally$': ~
  
  # move cells to left (fill spaces)
  for .i to '.self$'.size
    .numSpace = 0
    for .j from 2 to '.self$'.size
      if '.self$'.panels##[.i, .j - 1] = 0
        .numSpace += 1
      endif
      if '.self$'.panels##[.i, .j] <> 0 and .numSpace <> 0
        '.self$'.panels##[.i, .j - .numSpace] = '.self$'.panels##[.i, .j]
        '.self$'.panels##[.i, .j] = 0
        .numSpace -= 1
      endif
    endfor
  endfor
  @matrices_are_same: '.self$'.panels##, .curPanels##, '.self$'.size
  '.self$'.isMoved = not matrices_are_same.return
endproc

procedure Panel.move_to: .self$, $, .direction$
  .self._move_to_left$ = '.self$'._move_to_left$

  if .direction$ = "left"
    @'.self._move_to_left$': ~
  elsif .direction$ = "right"
    @reverse_matrix: '.self$'.panels##, '.self$'.size, "col"
    '.self$'.panels## = reverse_matrix.return##
    @'.self._move_to_left$': ~
    @reverse_matrix: '.self$'.panels##, '.self$'.size, "col"
    '.self$'.panels## = reverse_matrix.return##
  elsif .direction$ = "up"
    @rotate_matrix: '.self$'.panels##, '.self$'.size, 270
    '.self$'.panels## = rotate_matrix.return##
    @'.self._move_to_left$': ~
    @rotate_matrix: '.self$'.panels##, '.self$'.size, 90
    '.self$'.panels## = rotate_matrix.return##
  elsif .direction$ = "down"
    @rotate_matrix: '.self$'.panels##, '.self$'.size, 90
    '.self$'.panels## = rotate_matrix.return##
    @'.self._move_to_left$': ~
    @rotate_matrix: '.self$'.panels##, '.self$'.size, 270
    '.self$'.panels## = rotate_matrix.return##
  endif
endproc
