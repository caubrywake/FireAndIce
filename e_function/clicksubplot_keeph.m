
function  [val, valnum] = clicksubplot
id = 1;
while 1 == 1
    w = waitforbuttonpress;
      switch w 
          case 1 % keyboard 
              key = get(gcf,'currentcharacter'); 
              if key==27 % (the Esc key) 
                  try; delete(h); end
                  break
              end
          case 0 % mouse click 
              mousept = get(gca,'currentPoint');
              x = mousept(1,1);
              y = mousept(1,2);
              val = str2num(get(gca,'tag'))
              if exist('val')
                  id = id+1
              end 
              valnum(id)  =  val;
              try; end
              h = text(x,y,get(gca,'tag'),'vert','middle','horiz','center'); 
      end
  end
end

