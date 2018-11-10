include panel.praat
include drawwindow.praat
include key.praat


clearinfo
@main:


procedure main:
  .this$ = "main"
  
  @Panel: ~'.this$'.panel
  @'.panel.generate_cell$': ~
  # initialize graphic
  @Window: ~'.this$'.window, .panel.size
  @'.window.update$': ~, ~'.this$'.panel
  
  while demoWaitForInput()
    if demoKeyPressed()
      .key$ = demoKey$()
      if  .key$ = "d" or .key$ = directionKey.right$
        @'.panel.move_to$': ~, "right"
      elsif .key$ = "a" or .key$ = directionKey.left$
        @'.panel.move_to$': ~, "left"
      elsif .key$ = "w" or .key$ = directionKey.up$
        @'.panel.move_to$': ~, "up"
      elsif .key$ = "s" or .key$ = directionKey.down$
        @'.panel.move_to$': ~, "down"
      elsif .key$ = "q"
        exitScript: "thank you for playing!"
      endif
      
      if .panel.isMoved
        @'.panel.generate_cell$': ~
        @'.window.update$': ~, ~'.this$'.panel
      endif
    endif
  endwhile
endproc
