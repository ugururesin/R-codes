deneme <- "DIS DEGISKEN"

mydialog <- function(){
  
  tt <- tktoplevel()
  tkwm.title(tt,"DCML | Ford Otosan")
  tkwm.geometry(tt, "420x240+100+100") 
  
  currentDate <- as.character(Sys.Date())
  data_headname <- tclVar("Giriniz")
  data_begindate <- tclVar("2019-05-18")
  data_lastdate <- tclVar(currentDate)
  
  anys_list <- c("Olcum Noktasi Azaltma", "Olcum Noktasi Tahminleme", "Hata Tahminleme")
  anys_selected <- tclVar(anys_list)
  
  lvar <- tclVar()
  tclObj(lvar) <- anys_list
  
  
  x.entry <- tkentry(tt, textvariable=data_headname)
  y.entry <- tkentry(tt, textvariable=data_begindate)
  z.entry <- tkentry(tt, textvariable=data_lastdate)
  #w.entry <- tklistbox(tt, listvariable=tcl1, selectmode="single", width=32, height=4)
  
  w.entry <- tklistbox(tt, listvariable=lvar, selectmode = "multiple", width=32, height=4)

  
  reset <- function()
  {
    tclvalue(data_headname)<-""
    tclvalue(data_begindate)<-""
    tclvalue(data_lastdate)<-""
    tclvalue(anys_selected)<-""
  }
  
  reset.but <- tkbutton(tt, text="Reset", command=reset)
  
  submit <- function() {
    x <- as.character(tclvalue(data_headname))
    y <- as.character(tclvalue(data_begindate))
    z <- as.character(tclvalue(data_lastdate))
    w <- as.character(tclvalue(lvar))
    #tkmessageBox(message="Veriler kontrol ediliyor...")
    
    
    if(nchar(y)==10 & nchar(z)==10){
      print(x)
      print(y)
      print(z)
      print(w)
      print(deneme)
      if(w=="{Olcum Noktasi Azaltma}"){
        cat("DENEME")}
      
      if(anys_selected=="Olcum Noktasi Tahminleme"){}
      
      if(anys_selected=="Hata Tahminleme"){}
    }else{
      msg_box("DCML | Ford Otosan",
              "Model Olusturma 'Manuel Modda' Yapilamaz!\nAdmin ayarlarindan 'Otomatik Moda' geciniz!",
              "warning",
              "ok")}
    
    
    
    tkdestroy(tt)
  }
  submit.but <- tkbutton(tt, text="Tamam", command=submit)
  
  tkgrid(tklabel(tt,text="\n  DCML (Dimensional Control with Machine Learning) Sistemine Hosgeldiniz!  \nLütfen Analiz Detaylarini Giriniz\n"),columnspan=2)
  tkgrid(tklabel(tt,text="BoQP Adý"), x.entry)
  tkgrid(tklabel(tt,text="Veri Baþlangýç Tarihi"), y.entry)
  tkgrid(tklabel(tt,text="Veri Bitiþ Tarihi"), z.entry)
  tkgrid(tklabel(tt,text="Analiz Tipi"), w.entry)
  
  tkgrid(submit.but, reset.but)
  
  
  
}

mydialog()