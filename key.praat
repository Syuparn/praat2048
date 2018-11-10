@directionKey:

procedure directionKey:
  .right$ = backslashTrigraphsToUnicode$ ("\->")
  .left$ = backslashTrigraphsToUnicode$ ("\<-")
  .up$ = backslashTrigraphsToUnicode$ ("\^|")
  .down$ = backslashTrigraphsToUnicode$ ("\_|")
endproc
