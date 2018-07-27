package fla.play.__cue
{
   import fla.play.__1D.__6o;
   import fla.play.__ball.LogicalBall;
   import fla.play.__ball.Position;
   import fla.play.__locale.BallLocale;
   import fla.play.__locale.__Fn;
   import fla.play.__world.World;
   import flash.display.Sprite;
   
   public class CueLine extends Sprite
   {
       
      
      private var m_cCollisionBall:LogicalBall;
      
      private var m_cGuideBall:LogicalBall;
      
      private var __33:Position;
      
      private var __6K:World;
      
      private var __Fb:Boolean = true;
      
      public function CueLine(param1:World, param2:Position)
      {
         super();
         __6K = param1;
         __33 = param2;
         m_cGuideBall = new LogicalBall(0,param1.cueBall.radius,-2);
         m_cCollisionBall = new LogicalBall(0,param1.cueBall.radius,-2);
      }
      
      public function __06(param1:Number) : void
      {
         var _loc8_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:* = null;
         var _loc6_:Number = NaN;
         graphics.clear();
         m_cGuideBall.position.init(__6K.cueBall.position.x,__6K.cueBall.position.y);
         m_cGuideBall.velocity.init(1,0);
         m_cGuideBall.velocity.setByAngle(param1);
         m_cGuideBall.setState = 1;
         var _loc7_:BallLocale = __6K.findFirstCollisionBall(m_cGuideBall,Infinity);
         if(_loc7_ != null)
         {
            m_cGuideBall.velocity.scale(_loc7_.time);
            _loc8_ = __33.getVisualXPosition(m_cGuideBall.position.x);
            _loc2_ = __33.getVisualYPosition(m_cGuideBall.position.y);
            _loc3_ = __33.getVisualXPosition(m_cGuideBall.position.x + m_cGuideBall.velocity.x);
            _loc4_ = __33.getVisualYPosition(m_cGuideBall.position.y + m_cGuideBall.velocity.y);
            graphics.lineStyle(2,16777215,0.5);
            graphics.moveTo(_loc8_,_loc2_);
            graphics.lineTo(_loc3_,_loc4_);
            graphics.drawCircle(_loc3_,_loc4_,__33.__A2(__6K.cueBall.radius));
            if(_loc7_ is __Fn && __Fb)
            {
               _loc5_ = (_loc7_ as __Fn).ballB;
               m_cGuideBall.position.init(m_cGuideBall.position.x + m_cGuideBall.velocity.x,m_cGuideBall.position.y + m_cGuideBall.velocity.y);
               m_cGuideBall.velocity.__Dz();
               m_cCollisionBall.position.init(_loc5_.position.x,_loc5_.position.y);
               m_cCollisionBall.velocity.init(0,0);
               __6o.ballBallCollision(m_cGuideBall,m_cCollisionBall);
               _loc6_ = 5 + 20 * Math.max(250 - _loc7_.time,0) / 250;
               m_cGuideBall.velocity.scale(_loc6_);
               m_cCollisionBall.velocity.scale(_loc6_);
               _loc8_ = __33.getVisualXPosition(m_cGuideBall.position.x);
               _loc2_ = __33.getVisualYPosition(m_cGuideBall.position.y);
               _loc3_ = __33.getVisualXPosition(m_cGuideBall.position.x + m_cGuideBall.velocity.x);
               _loc4_ = __33.getVisualYPosition(m_cGuideBall.position.y + m_cGuideBall.velocity.y);
               graphics.moveTo(_loc8_,_loc2_);
               graphics.lineTo(_loc3_,_loc4_);
               _loc8_ = __33.getVisualXPosition(m_cCollisionBall.position.x);
               _loc2_ = __33.getVisualYPosition(m_cCollisionBall.position.y);
               _loc3_ = __33.getVisualXPosition(m_cCollisionBall.position.x + m_cCollisionBall.velocity.x);
               _loc4_ = __33.getVisualYPosition(m_cCollisionBall.position.y + m_cCollisionBall.velocity.y);
               graphics.moveTo(_loc8_,_loc2_);
               graphics.lineTo(_loc3_,_loc4_);
            }
         }
      }
      
      public function set __6v(param1:Boolean) : void
      {
         __Fb = param1;
      }
      
      public function get __6v() : Boolean
      {
         return __Fb;
      }
   }
}
