require(tcltk)

my_toplevel <- function(parent=.TkRoot,title="",x=NA,y=NA){
  r <- tktoplevel(parent)
  tkwm.title(r,title)
  if( ! is.na(x) ){
    tkwm.geometry(r,sprintf("%dx%d",x,y))
  }
  return(r)
}
my_frame <- function(parent=.TkRoot,side="top"){
  r <- tkframe(parent)
  tkpack(r,side=side)
  return(r)
}
my_label <- function(parent=.TkRoot,label,side="top"){
  v <- tclVar(label)
  #  r <- tklabel(parent,text=label)
  r <- tklabel(parent,textvariable=v)
  tkpack(r,side=side)
  attr(v,"my_class")<-"my_label"
  return(v)
}
my_button <- function(parent=.TkRoot,label="",command=function(){},side="top"){
  r <- tkbutton(parent,text=label,command=command)
  tkpack(r,side=side)
  return(r)
}
my_entry <- function(parent=.TkRoot,default="",width=10,side="top"){
  v <- tclVar(default)
  r <- tkentry(parent,width=width,textvariable=v)
  tkpack(r,side=side)
  attr(v,"my_class")<-"my_entry"
  return(v) # to get value, use tclvalue
}
my_text <- function(parent=.TkRoot,text="",height=5,width=20,side="top"){
  r <- tktext(parent,height=height,width=width)
  tkinsert(r,"1.0",text)
  tkpack(r,side=side)
  tkconfigure(r,state="disabled")
  attr(r,"my_class")<-"my_text"
  return(r)
}
my_radiobutton <- function(parent=.TkRoot,label=c(),default=0,side="top"){
  v <- tclVar(default)
  for(i in 1:length(label)){
    r <- tkradiobutton(parent,text=label[i],value=i-1,variable=v)
    tkpack(r,side=side,anchor="w")
  }
  attr(v,"my_class")<-"my_radiobutton"
  return(v) # to get value, use tclvalue
}
my_checkbutton <- function(parent=.TkRoot,label="",default=0,side="top"){
  v <- tclVar(default)
  r <- tkcheckbutton(parent,text=label,variable=v,onvalue=1,offvalue=0)
  tkpack(r,side=side,anchor="w")
  attr(v,"my_class")<-"my_checkbutton"
  return(v) # to get value, use tclvalue
}
my_listbox <- function(parent=.TkRoot,label=c(),default=0,height=4,width=20,side="top"){
  f <- tkframe(parent)
  s <- tkscrollbar(f,command=function(...)tkyview(r,...))
  r <- tklistbox(f,exportselection=0,height=height,width=width,
                 yscrollcommand=function(...)tkset(s,...),
                 selectmode='single') # single,multiple,extended,browse
  tkpack(f,side=side,anchor="w")
  tkpack(r,side="left")
  tkpack(s,side="right",fill="y")
  for(i in label){tkinsert(r,'end',i)}
  if( ! is.na(default) ){
    tkselection.set(r,default)
    tksee(r,default)
  }
  attr(r,"my_class")<-"my_listbox"
  return(r) # to get value, tkcurselection()
}
my_menu <- function(parent=.TkRoot,menu=c()){
  m<-tkmenu(parent)
  for(mm in menu){
    c<-tkmenu(m,tearoff=FALSE)
    for(mmm in mm[-1]){
      if(mmm[[1]]=="-"){
        tkadd(c,"separator")
      }else{
        tkadd(c,"command",label=mmm[[1]],command=mmm[[2]])
      }
    }
    tkadd(m,"cascade",label=mm[[1]],menu=c)
  }
  tkconfigure(parent,menu=m)
}

# for my_listbox
tclvalue.tkwin <- function(x) as.integer(tkcurselection(x))
"tclvalue<-.tkwin" <- function(x,value){
  tkselection.clear(x,0,'end')
  tkselection.set(x,value)
  #  tksee(x,value)
} 

my_value <- function(x){
  switch(attr(x,"my_class"),
         "my_entry" = tclvalue(x),
         "my_radiobutton" = as.integer(tclvalue(x)),
         "my_checkbutton" = as.integer(tclvalue(x)), # or ==1,
         "my_listbox" = as.integer(tkcurselection(x)),
         tclvalue(x)
  )
}
"my_value<-" <- function(x,value){
  cls<-attr(x,"my_class")
  switch(cls,
         "my_entry" = tclvalue(x)<-value ,
         "my_radiobutton" = tclvalue(x)<-value ,
         #    "my_checkbutton" = if(value==1){tclvalue(x)<-1}else{tclvalue(x)<-0} ,
         "my_checkbutton" = tclvalue(x)<-value ,
         "my_listbox" = {
           tkselection.clear(x,0,'end')
           tkselection.set(x,value)
         },
         tclvalue(x)<-value
  )
  #  attr(x,"my_class")<-cls
  x
}


# change log
# 2008.6.16 beta version
# 2010.9.3 tclvalue.tkwin, my_set
# 2010.9.4 tclvalue<-.tkwin, remove my_set
# 2010.9.9 my_value
# 2010.9.28 my_text
# 2012.5.6 seperator for menu
# 2016.10.8 my_value for my_label
# 2016.10.29 listbox height, width