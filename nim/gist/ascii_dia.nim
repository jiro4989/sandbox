import strutils, sequtils, algorithm

proc corner(text: string): seq[string] =
  for i, v in text.pairs:
    result.add(text[0..i] & " ".repeat(text.len-i))

proc diamond(text: string): seq[string] =
  let rightTop = corner(text)
  let leftTop = rightTop.mapIt(it.reversed.join)
  let rightBottom = rightTop.reversed
  let leftBottom = leftTop.reversed

  for i, v in rightTop:
    result.add(leftTop[i] & v)

  for i, v in rightBottom:
    result.add(leftBottom[i] & v)

for line in diamond("hello world"):
  echo line

# result:
#[
           hh           
          ehhe          
         lehhel         
        llehhell        
       ollehhello       
       ollehhello       
     w ollehhello w     
    ow ollehhello wo    
   row ollehhello wor   
  lrow ollehhello worl  
 dlrow ollehhello world 
 dlrow ollehhello world 
  lrow ollehhello worl  
   row ollehhello wor   
    ow ollehhello wo    
     w ollehhello w     
       ollehhello       
       ollehhello       
        llehhell        
         lehhel         
          ehhe          
           hh           
]#
