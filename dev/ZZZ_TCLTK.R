## TK CREATION
tt <- tktoplevel()
tkwm.title(tt, "DCML | Ford Otosan")
tkwm.geometry(tt, "350x200+100+100") 

## SELECTION CHECK
onOK <- function()
{
  anys_selection <- tclvalue(anys_def)
  data_selection <- tclvalue(data_def)

  if (anys_selection == "Choose one" | data_selection == "Choose one")
    tkmessageBox(title="DCML | Ford Otosan", message = "Eksik Secim Yaptiniz!")
  
  if (anys_selection != "Choose one" && data_selection != "Choose one")
    tkmessageBox(title="DCML | Ford Otosan", message = "Secimler Tamamlandi!")
  
  if(anys_selection=="Olcum Noktasi Azaltma")
    if(data_source_selected=="Lokal Veri (.csv)"){
      data_headname <- data_selection
      dataname = gsub(" ","_",data_headname)
      data_dir <- paste("data/_datalocal/data_training/", data_headname, ".csv",sep="")
      raw_data <- read.csv(data_dir, sep=";", header = T)
      source("./scripts/dcml_module_dataprocessing.R")
      source("./scripts/dcml_module_modeling_stat.R")
      
    }
      
}

## BOXLIST LABELS
label1 <- tklabel(tt, text="Analiz Tipini Seciniz")
label2 <- tklabel(tt, text="Veri Seciniz")

## DEFAULT SELECTION
anys_def <- tclVar("Choose one")
data_def <- tclVar("Choose one")

## BOXLIST CONTENT
boxlist_anys <- c("Olcum Noktasi Azaltma", "Olcum Noktasi Tahmini", "Hata Tahmini")
boxlist_data <- datalist

## COMBO-BOXES
combo.1 <- ttkcombobox(tt, values=boxlist_anys, textvariable=anys_def, state="readonly") 
combo.2 <- ttkcombobox(tt, values=boxlist_data, textvariable=data_def, state="readonly") 
# If you need to do something when the user changes selection just use
# tkbind(combo.1, "<<ComboboxSelected>>", functionname)

OK.but <- tkbutton(tt, text="Baslat!", command = onOK)
tkpack(label1, combo.1)
tkpack(label2, combo.2)
tkpack(OK.but)
tkfocus(tt)