mydialog <- function(){
  
  xvar <- tclVar("1")
  yvar <- tclVar("2")
  zvar <- tclVar("3")
  
  tt <- tktoplevel()
  tkwm.title(tt,"MYTEST")
  x.entry <- tkentry(tt, textvariable=xvar)
  y.entry <- tkentry(tt, textvariable=yvar)
  z.entry <- tkentry(tt, textvariable=zvar)
  
  reset <- function()
  {
    tclvalue(xvar)<-""
    tclvalue(yvar)<-""
    tclvalue(zvar)<-""
  }
  
  reset.but <- tkbutton(tt, text="Reset", command=reset)
  
  submit <- function() {
    x <- as.numeric(tclvalue(xvar))
    y <- as.numeric(tclvalue(yvar))
    z <- as.numeric(tclvalue(zvar))
    print(x+y+z)
    tkmessageBox(message="Done!")
    #tkdestroy(tt)
  }
  submit.but <- tkbutton(tt, text="submit", command=submit)
  
  tkgrid(tklabel(tt,text="MYTEST"),columnspan=2)
  tkgrid(tklabel(tt,text="x variable"), x.entry)
  tkgrid(tklabel(tt,text="y variable"), y.entry)
  tkgrid(tklabel(tt,text="z variable"), z.entry)
  tkgrid(submit.but, reset.but)
  
}

mydialog()