########################################
## SCRIPT: WINDOWS GUI
########################################
## License: Ugur Uresin
## Github: ugururesin
## Mail: uresin.ugur@gmail.com
########################################

### USER INPUTS
wdir = "C:/Users/uuresin/Desktop/MYGIT/R-codes"
setwd(wdir)
#

## FUNCTION
inputs <- function(){
  
  ## GEOMETRY
  tt <- tktoplevel()
  tkwm.title(tt,"TITLE")
  tkwm.geometry(tt, "300x260+100+100")
  
  ### INPUTS
  ##########
  ## GETTING DATANAME
  data_headname <- tclVar("Giriniz")
  x.entry <- tkentry(tt, textvariable=data_headname, width=28, background="white")
  
  ## GETTING DATA DATE
  data_lastdate <- tclVar(as.character(Sys.Date()))
  y.entry <- tkentry(tt, textvariable=data_lastdate, width=28, background="white")

  ## GETTING ANALYSIS TYPE
  lvar <- tclVar()
  tclObj(lvar) <- c("Olcum Noktasi Azaltma", "Olcum Noktasi Tahminleme", "Hata Tahminleme")
  z.entry <- tklistbox(tt, listvariable=lvar, selectmode = "single", width=28, height=3, background="white")

  
  ### FUNCTIONS
  #############
  ## RESET
  reset <- function()
  {
    tclvalue(data_headname)<-"BOQP ADI"
    tclvalue(data_lastdate)<-"YYYY-AA-GG"
  }
  reset.but <- tkbutton(tt, text="SIFIRLA", command=reset)
  
  ## SUBMIT
  submit <- function() {
    x <- as.character(tclvalue(data_headname))
    y <- as.character(tclvalue(data_lastdate))
    z <- as.character(tclvalue(lvar))
    e <- parent.env(environment())
    e$x <- x
    e$y <- y
    e$z <- z
    tkdestroy(tt)
  }
  submit.but <- tkbutton(tt, text="TAMAM", command=submit)
  
  
  ### RETURN
  tkgrid(tklabel(tt,text="\n   Lutfen Veri Bilgilerini ve Analizi Tipini Giriniz!   \n"),columnspan=2)
  tkgrid(tklabel(tt,text="BQOP ADI   "), x.entry, pady = 10, padx =10)
  tkgrid(tklabel(tt,text="VERI TARIHI"), y.entry, pady = 10, padx =10)
  tkgrid(tklabel(tt,text="ANALIZ TIPI"), z.entry, pady = 10, padx =10)
  tkgrid(submit.but, reset.but)
  tkwait.window(tt)
  return(c(x,y,z))
}

myvals <- inputs()
myvals