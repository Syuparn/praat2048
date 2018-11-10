include oop.praat
include colors.praat
include graphicalobject.praat


procedure Window: .self$, .numCellsInASide
  .cls$ = "Window"
  '.self$'.cls$ = .cls$
  '.self$'.width = 100
  '.self$'.height = 100
  #                                 x,  y
  @GraphicalBoard: ~'.self$'.board, 30, 10, .numCellsInASide
  @GraphicalScore: ~'.self$'.score, 5, 40
  #                                x,  y,   color,    fontSize, text
  @GraphicalText: ~'.self$'.logo1, 10, 90, colors.font$[2], 15, "Praat"
  @GraphicalText: ~'.self$'.logo2, 15, 80, colors.font$[2], 50, "2048"
  
  @set_method: .self$, .cls$, "update"
  
  # initialize demo
  demo Erase all
  demo Select inner viewport: 0, '.self$'.width, 0, '.self$'.height
  demo Axes: 0, '.self$'.width, 0, '.self$'.height
endproc

procedure Window.update: .self$, $, .panel$
  demo Erase all
  # expand name space
  .self.board.draw$ = '.self$'.board.draw$
  @'.self.board.draw$': ~, .panel$
  .self.logo1.draw$ = '.self$'.logo1.draw$
  @'.self.logo1.draw$': ~
  .self.logo2.draw$ = '.self$'.logo2.draw$
  @'.self.logo2.draw$': ~
  .self.score.draw$ = '.self$'.score.draw$  
  @'.self.score.draw$': ~, '.panel$'.score
endproc


procedure GraphicalBoard: .self$, .x, .y, .numCellsInASide
  .cls$ = "GraphicalBoard"
  '.self$'.cls$ = .cls$
  '.self$'.numCellsInASide = .numCellsInASide
  .aspect = 2.0
  .margin = 1
  .cellSize = 10
  
  .widthBackGround = .cellSize * .numCellsInASide + .margin
  .heightBackGround = .widthBackGround * .aspect
  @GraphicalSquare: ~'.self$'.backGround, .x - .margin, .y - .margin * .aspect, 
  ...               .widthBackGround, .heightBackGround, colors.backGround$

  for .i to .numCellsInASide
    for .j to .numCellsInASide
      .xCell = .x + (.j - 1) * .cellSize
      .yCell = .y + (.numCellsInASide - .i) * .cellSize * .aspect
      # NOTE: array ('.self$'.cells[.i, .j]) cannot be used
      # because property after [] (ex: .cells[.i, .j].hoge) is not allowed
      .cellName$ = ~'.self$'.cells'.i''.j'
      @GraphicalCell: ~'.self$'.cells'.i''.j', .xCell, .yCell,
      ...             .aspect, .cellSize, .margin
    endfor
  endfor

  @set_method: .self$, .cls$, "draw"
endproc

procedure GraphicalBoard.draw: .self$, $, .panel$
  .self.backGround.draw$ = '.self$'.backGround.draw$
  @'.self.backGround.draw$': ~
  for .i to '.self$'.numCellsInASide
    for .j to '.self$'.numCellsInASide
      .self.cell.draw$ = '.self$'.cells'.i''.j'.draw$
      # NOTE: write this in another line because "," in array is wrongly
      # treated as an argument separator
      .cellNum = '.panel$'.panels##[.i, .j]
      @'.self.cell.draw$': ~, .cellNum
    endfor
  endfor
endproc


procedure GraphicalCell: .self$, .x, .y, .aspect, .cellSize, .margin
  .cls$ = "GraphicalCell"
  '.self$'.cls$ = .cls$
  '.self$'.x = .x
  '.self$'.y = .y
  .fontSize = 30
  @GraphicalSquare: ~'.self$'.square, .x, .y,
  ...               .cellSize - .margin, (.cellSize - .margin) * .aspect,
  ...               colors.cell$[0]
  @GraphicalText: ~'.self$'.text,
  ...             .x + 0.5 * .cellSize, .y + 0.45 * .cellSize * .aspect,
  ...             colors.font$[0], .fontSize, ""
  @set_method: .self$, .cls$, "draw"
endproc

procedure GraphicalCell.draw: .self$, $, .cellNum
  '.self$'.text.text$ = if .cellNum then string$(.cellNum) else "" endif
  
  if .cellNum <= 2048
    '.self$'.square.color$ = colors.cell$[.cellNum]
    '.self$'.text.color$ = colors.font$[.cellNum]
  else
    '.self$'.square.color$ = colors.cell$["others"]
    '.self$'.text.color$ = colors.font$["others"]
  endif
  
  if .cellNum < 1000
    '.self$'.text.fontSize = 30
  else
    '.self$'.text.fontSize = 30 * 3 / (log10(.cellNum) + 1)
  endif

  .self.square.draw$ = '.self$'.square.draw$
  @'.self.square.draw$': ~
  .self.text.draw$ = '.self$'.text.draw$
  @'.self.text.draw$': ~
endproc


procedure GraphicalScore: .self$, .x, .y
  .cls$ = "GraphicalScore"
  '.self$'.cls$ = .cls$
  '.self$'.x = .x
  '.self$'.y = .y
  #                                      x, y, width, height, color
  @GraphicalSquare: ~'.self$'.backGround, .x, .y, 20, 20, colors.backGround$
  #                                      x,      y,   color,    fontSize, text
  @GraphicalText: ~'.self$'.caption, .x + 10, .y + 15, colors.font$[4], 20, "score"
  @GraphicalText: ~'.self$'.score, .x + 10, .y + 5, colors.font$[256], 30, ""
  
  @set_method: .self$, .cls$, "draw"
endproc

procedure GraphicalScore.draw: .self$, $, .score
  '.self$'.score.text$ = string$(.score)
  
  .self.backGround.draw$ = '.self$'.backGround.draw$
  @'.self.backGround.draw$': ~
  .self.caption.draw$ = '.self$'.caption.draw$
  @'.self.caption.draw$': ~
  .self.score.draw$ = '.self$'.score.draw$
  @'.self.score.draw$': ~
endproc
