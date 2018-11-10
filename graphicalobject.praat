procedure GraphicalSquare: .self$, .x, .y, .width, .height, .color$
  .cls$ = "GraphicalSquare"
  '.self$'.cls$ = .cls$
  '.self$'.x = .x
  '.self$'.y = .y
  '.self$'.width = .width
  '.self$'.height = .height
  '.self$'.color$ = .color$
  @set_method: .self$, .cls$, "draw"
endproc

procedure GraphicalSquare.draw: .self$, $
  demo Paint rectangle: '.self$'.color$,
  ...                   '.self$'.x, '.self$'.x + '.self$'.width,
  ...                   '.self$'.y, '.self$'.y + '.self$'.height
endproc


procedure GraphicalText: .self$, .x, .y, .color$, .fontSize, .text$
  .cls$ = "GraphicalText"
  '.self$'.cls$ = .cls$
  '.self$'.x = .x
  '.self$'.y = .y
  '.self$'.color$ = .color$
  '.self$'.fontSize = .fontSize
  '.self$'.text$ = .text$
  @set_method: .self$, .cls$, "draw"
endproc

procedure GraphicalText.draw: .self$, $
  demo Colour: '.self$'.color$
  demo Text special: '.self$'.x, "Centre", '.self$'.y, "Half", "Helvetica",
  ...                '.self$'.fontSize, "0", '.self$'.text$
endproc
