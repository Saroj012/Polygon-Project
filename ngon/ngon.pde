/*    Name:   Saroj Bishwokarma
      Partner: Sumit Koirala
      Email:  sbishwokarma@stcloudstate.edu
      Email: skoirala@stcloudstate.edu
      CSCI 450(Computer Graphics)
      Project: ngon. Draws n-sided polygons, where n is user defined    
*/

void setup(){
size(1000,800);
stroke(204,104,0);
}

pointD p;//an object of the pointD class
ArrayList<pointD> alist=new ArrayList<pointD>();//an arraylist object 
float rWidth=10.0F, rHeight=7.5F,x0,y0,xA,yA;
int maxX=width-1,maxY=height-1;
int centerX=maxX/2,centerY=maxY/2;
float pixelSize=Math.max(rWidth/maxX,rHeight/maxY);
boolean ready=true;
boolean print=false;

void mousePressed()
{
  if(mouseButton==LEFT)//when LEFT mouse click used
  {
    xA=fx(mouseX);
    yA=fy(mouseY);
    if(ready)
    {
      for(int i=alist.size()-1;i>=0;i--)
      {
         pointD part=alist.get(i);
         alist.remove(i);
      }
      x0=xA;y0=yA;
      ready=false;
    }
    float dx=xA-x0,dy=yA-y0;
    if(alist.size()>0 && dx*dx+dy*dy<4*pixelSize*pixelSize)
      ready=true;
    else
     alist.add(new pointD(xA,yA));      
  }
  else//when RIGHT mouse click is used
    print=true;//print set to true so that the required contents can be printed to screen
}

int iX(float x){return Math.round(centerX+(x/pixelSize));}
int iY(float y){return Math.round(centerY-(y/pixelSize));}
float fx(int x){return (x - centerX) * pixelSize;}
float fy(int y){return (centerY - y) * pixelSize;}

void draw()
{
  int left=iX(-rWidth/2),right=iX(rWidth/2),
      bottom=iY(-rHeight/2),top=iY(rHeight/2);
  rect(left,top,right-left,bottom-top);
  int n=alist.size();
  if(n==0)return;
  pointD a=(pointD)(alist.get(0));
  rect(iX(a.x)-2,iY(a.y)-2,4,4);
  for(int j=1;j<=n;j++)
  {
    if(j==n && !ready)break;
    pointD b=(pointD)(alist.get(j%n));
    line(iX(a.x),iY(a.y),iX(b.x),iY(b.y));
    a=b;
  } 
  if(print && mousePressed)//if print is true(set by RIGHT mouse click)
  { 
    textSize(32);
    text("Num of points "+alist.size(),mouseX,mouseY);//write text on the location of RIGHT mouse click
    print=false;//set print to false to avoid repetition
    noLoop();//draw not executed once a polygon has been drawn and the required
             //text is displayed on the screen
  }
}
