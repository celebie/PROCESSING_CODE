/* --------------------------------------------------------------------------
 * SimpleOpenNI User3d Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect 2 library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / Zhdk / http://iad.zhdk.ch/
 * date:  12/12/2012 (m/d/y)
 * ----------------------------------------------------------------------------
 */
 
import SimpleOpenNI.*;


SimpleOpenNI context;
float        zoomF =0.5f;
float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
                                   // the data from openni comes upside down
float        rotY = radians(0);
boolean      autoCalib=true;

PVector      bodyCenter = new PVector();
PVector      bodyDir = new PVector();
PVector      com = new PVector();                                   
PVector      com2d = new PVector();                                   
// color[]       userClr = new color[]{ color(255,0,0),
//                                      color(0,255,0),
//                                      color(0,0,255),
//                                      color(255,255,0),
//                                      color(255,0,255),
//                                      color(0,255,255)
//                                    };
int[] userList;
// int[]   depthMap;
int[]   userMap;
int     steps   = 4;  // to speed up the drawing, draw every third point
int     index;
PVector realWorldPoint;



PImage imgTexture = new PImage();
ArrayList<PVector> joints = new ArrayList<PVector>();

void setup()
{
  size(displayWidth-210,displayHeight-210,P3D);  // strange, get drawing error in the cameraFrustum if i use P3D, in opengl there is no problem
  context = new SimpleOpenNI(this);
  if(context.isInit() == false)
  {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     exit();
     return;  
  }

  // disable mirror
  context.setMirror(true);

  // enable depthMap generation 
  context.enableDepth();

  // enable skeleton generation for all joints
  context.enableUser();

  smooth();  
  perspective(radians(45),
              float(width)/float(height),
              10,150000);
 }

void draw()
{
  // update the cam
  context.update();
  // depthMap = context.depthMap();
  userMap = context.userMap();

  imgTexture = context.depthImage();

  // set the scene pos
  translate(width/2, height/2, 0);
  rotateX(rotX);
  rotateY(rotY);
  scale(zoomF);
  
  
 
  translate(0,0,-1000);  // set the rotation center of the scene 1000 infront of the camera
  
  // draw the skeleton if it's available
  userList = context.getUsers();
  for(int i=0;i<userList.length;i++)
  {
    
    if(context.isTrackingSkeleton(userList[i]))
    {
      drawSkeleton(userList[i]);
    }
    
    // draw the center of mass
    if(context.getCoM(userList[i],com))
    {
      if(com.x>0)
      {    

        sphereDetail(
            (int) map(com.x, 0, width, 3, 21),
            (int) map(com.y, 0, height, 3, 21)
          );


        stroke(com.x,com.y,com.z);//frameCount%255);
        fill(com.x%255,com.y%255,com.z%255);

        pushMatrix();
          translate(com.x, com.y, com.z);
          sphere(42);
        popMatrix();
      }
    }
  }    
 
    


    
    strokeWeight(TWO_PI);
    stroke(com.x, com.y, com.z);
    fill(com.x%255,com.y%255,com.z%255,50);
    curveTightness( map(com.x, 0, width, -5, 5) );

    beginShape();//QUAD_STRIP);  //   POINTS, LINES, TRIANGLES, TRIANGLE_FAN, TRIANGLE_STRIP, QUADS, or QUAD_STRIP
    
    for(PVector pt : joints ){
      stroke( (color) imgTexture.get((int)pt.x, (int)pt.y));
      curveVertex(pt.x, pt.y, pt.z);
    }
    endShape();


    noStroke();
    noFill(); 
    textureWrap(REPEAT);
    
    tint(com.x, com.y, com.z, 100);

    beginShape(QUADS);//QUAD_STRIP);  //   POINTS, LINES, TRIANGLES, TRIANGLE_FAN, TRIANGLE_STRIP, QUADS, or QUAD_STRIP
    
    texture(imgTexture);
    
    for(PVector pt : joints ){
      vertex(pt.x, pt.y, pt.z, pt.x, pt.y);
    }
    endShape();
    joints.clear();


    // draw the user pointcloud
    if(frameCount%30==0)
    {
      beginShape(POINTS);
      for(int y=0;y < context.depthHeight();y+=steps)
      {
        strokeWeight(random(TWO_PI));

        for(int x=0;x < context.depthWidth();x+=steps)
        {
          index = x + y * context.depthWidth();
          

          if(userMap[index] > 0)
          { 
            // draw the projected point
            realWorldPoint = context.depthMapRealWorld()[index];

            // stroke(realWorldPoint.x%255,realWorldPoint.y%255,realWorldPoint.z%255);
            stroke(frameCount%255);
            point(realWorldPoint.x,realWorldPoint.y,realWorldPoint.z);

          }
        } 
      } 
      endShape();
    }

    if(com.x>0){    
      sphereDetail(
          (int) map(com.x, 0, width, 3, 21),
          (int) map(com.y, 0, height, 3, 21)
        );


        strokeWeight(TWO_PI);
        stroke(frameCount%255);
        fill(frameCount%255,frameCount%255,frameCount%255, 100);

        pushMatrix();
          translate(com.x, com.y, com.z);
          sphere(42);
        popMatrix();
        pushMatrix();
          translate(com.y, com.x, com.z);
          sphere(42);
        popMatrix();
      }


}

// draw the skeleton with the selected joints
void drawSkeleton(int userId)
{
  // strokeWeight(3);

  // to get the 3d joint data
  // drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);

  // drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  // drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  // drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);

  // drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  // drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  // drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

  // drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  // drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);

  // drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  // drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  // drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);

  // drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  // drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  // drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);  
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_HEAD ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_NECK ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_TORSO ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE ));


// SKEL_HEAD
// SKEL_NECK
// SKEL_TORSO
// SKEL_LEFT_SHOULDER
// SKEL_LEFT_ELBOW
// SKEL_LEFT_HAND
// SKEL_RIGHT_SHOULDER
// SKEL_RIGHT_ELBOW
// SKEL_RIGHT_HAND
// SKEL_LEFT_HIP
// SKEL_LEFT_KNEE
// SKEL_LEFT_ANKLE
// SKEL_RIGHT_HIP
// SKEL_RIGHT_KNEE
// SKEL_RIGHT_ANKLE

// // present, but unsupported joint constants (maybe in the future)
// SKEL_WAIST
// SKEL_LEFT_COLLAR
// SKEL_LEFT_WRIST
// SKEL_LEFT_FINGERTIP
// SKEL_RIGHT_COLLAR
// SKEL_RIGHT_WRIST
// SKEL_RIGHT_FINGERTIP
// SKEL_LEFT_FOOT
// SKEL_RIGHT_FOOT



  // draw body direction
  getBodyDirection(userId,bodyCenter,bodyDir);
  
  bodyDir.mult(200);  // 200mm length
  bodyDir.add(bodyCenter);
  
  // stroke(255,200,200);
  // line(bodyCenter.x,bodyCenter.y,bodyCenter.z,
  //      bodyDir.x ,bodyDir.y,bodyDir.z);

  // strokeWeight(1);
  joints.add(bodyCenter);

 
}

PVector getLimb(int userId,int jointType1 )
{
  PVector jointPos1 = new PVector();
  float  confidence;
  
  // draw the joint position
  confidence = context.getJointPositionSkeleton(userId,jointType1,jointPos1);

// jointPos1.add(confidence,);

  // drawJointOrientation(userId,jointType1,jointPos1,50);
  return jointPos1;
}

void drawLimb(int userId,int jointType1,int jointType2)
{
  PVector jointPos1 = new PVector();
  PVector jointPos2 = new PVector();
  float  confidence;
  
  // draw the joint position
  confidence = context.getJointPositionSkeleton(userId,jointType1,jointPos1);
  confidence = context.getJointPositionSkeleton(userId,jointType2,jointPos2);

  stroke(255,0,0,confidence * 200 + 55);
  line(jointPos1.x,jointPos1.y,jointPos1.z,
       jointPos2.x,jointPos2.y,jointPos2.z);
  
  drawJointOrientation(userId,jointType1,jointPos1,50);
}

void drawJointOrientation(int userId,int jointType,PVector pos,float length)
{
  // draw the joint orientation  
  PMatrix3D  orientation = new PMatrix3D();
  float confidence = context.getJointOrientationSkeleton(userId,jointType,orientation);
  if(confidence < 0.001f) 
    // nothing to draw, orientation data is useless
    return;
    
  pushMatrix();
    translate(pos.x,pos.y,pos.z);
    
    // set the local coordsys
    applyMatrix(orientation);
    
    // coordsys lines are 100mm long
    // x - r
    stroke(255,0,0,confidence * 200 + 55);
    line(0,0,0,
         length,0,0);
    // y - g
    stroke(0,255,0,confidence * 200 + 55);
    line(0,0,0,
         0,length,0);
    // z - b    
    stroke(0,0,255,confidence * 200 + 55);
    line(0,0,0,
         0,0,length);
  popMatrix();
}

// -----------------------------------------------------------------
// SimpleOpenNI user events

void onNewUser(SimpleOpenNI curContext,int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  
  context.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext,int userId)
{
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext,int userId)
{
  //println("onVisibleUser - userId: " + userId);
}


void getBodyDirection(int userId,PVector centerPoint,PVector dir)
{
  PVector jointL = new PVector();
  PVector jointH = new PVector();
  PVector jointR = new PVector();
  float  confidence;
  
  // draw the joint position
  confidence = context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_SHOULDER,jointL);
  confidence = context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_HEAD,jointH);
  confidence = context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_SHOULDER,jointR);
  
  // take the neck as the center point
  confidence = context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,centerPoint);
  
  /*  // manually calc the centerPoint
  PVector shoulderDist = PVector.sub(jointL,jointR);
  centerPoint.set(PVector.mult(shoulderDist,.5));
  centerPoint.add(jointR);
  */
  
  PVector up = PVector.sub(jointH,centerPoint);
  PVector left = PVector.sub(jointR,centerPoint);
    
  dir.set(up.cross(left));
  dir.normalize();
}



////// S SAVE HANDLER /////////

void keyPressed(){
switch(key){

  case 'm':
   if(context!=null){
     context.setMirror(!context.mirror());
    }
    break;


  case 's':
    // image(hirez,0,0);
    save( fix.pdeName() + fix.getTimestamp() + ".png");
    // save( fix.pdeName() + fix.getTimestamp() + "_BIG2.tiff");
  break;

  case ESC:

   if(context!=null){
     context.close();
   }
    save( fix.pdeName() + fix.getTimestamp() + ".png");
    // save( fix.pdeName() + fix.getTimestamp() + "_BIG2.tiff");
    exit();
  break;



    case LEFT:
      rotY += 0.1f;

      break;
    case RIGHT:
      // zoom out
      rotY -= 0.1f;

      break;
    case UP:
      if(keyEvent.isShiftDown())
        zoomF += 0.01f;
      else
        rotX += 0.1f;
      break;
    case DOWN:
      if(keyEvent.isShiftDown())
      {
        zoomF -= 0.01f;
        if(zoomF < 0.01)
          zoomF = 0.01;
      }
      else
        rotX -= 0.1f;
      break;

}

}  