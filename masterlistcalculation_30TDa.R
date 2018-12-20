## calculation for number of chemical formulae per nominal mass: ensure you have enough computational power or lower settings in max C,H,O

#get index for parallel computing
args = commandArgs(trailingOnly=TRUE) 
pint=as.numeric(as.character(args[1])) 


# if no parallel computing is used set pint to integer between 1 and 15 and redo calculations 15 times with increasing 'pint'
# pint=1L # 2,3,...15

#split range into 15 parts 91*15
vf<-0:1364 
G <- t(matrix(vf, ncol = 91, byrow = TRUE))

#create list for subset
chemlistlist<-list()


#create grid for all combinations
        for (j in G[1,pint]:G[91,pint]){  
          chemlist = expand.grid(C = 1:2500, H=0:12000, O=j:j) 
          #chemlist = chemlist[chemlist$H <= 8 * (chemlist$C) & (chemlist$O) <= (2*chemlist$C),] #filter here or below
          #chemlist = chemlist[chemlist$H > 0.25 * chemlist$C,]
          
         
          #create formula
          chemlist$formula <- apply(chemlist, 1, function(x){y = which(x!=0) 
          paste(colnames(chemlist)[y], x[y], collapse = " ")})    
                
                
          ##calculate properties for filtering
          chemlist$valence = with(chemlist,C*4  + O*2 + H*1)
          
          #filter by valence
          chemlist <- chemlist[chemlist$valence %% 2 == 0,]
          #'filter by DBE'
          chemlist<-chemlist[(1+0.5*(2*chemlist$C-chemlist$H))>=0,]
          #filter by OC
          chemlist$O.C<-round(chemlist$O/chemlist$C,3)
          
          chemlist<-chemlist[chemlist$O.C<=2,]
          #filter by HC
          chemlist$H.C<-round(chemlist$H/chemlist$C,3)
          
          #chemlist<-chemlist[chemlist$H.C<=8,]
         
          #create mass
          chemlist$mass = with(chemlist, C*12 + H*1.0078250+ O*15.99491461956)
          #filter by mass
          chemlist<-chemlist[chemlist$mass<=30000,]
          chemlistlist[[j+1]]<-chemlist
          cat(format(Sys.time(), "%a %b %d %X")," ",j," ")
        }


chemlist<-do.call("rbind", chemlistlist)

#now you have the final formula list for your chosen pint (O interval)

GG<-round(chemlist$mass, digits = 0)

#count masses per nominal mass
UU<-numeric(30000)
for (i in 1:30000){
  UU[i]<-sum(GG==i)}
write.csv(UU, paste0("Masterlist_30DA_O_from",G[1,pint],"to",G[91,pint],".csv"), row.names = F)
