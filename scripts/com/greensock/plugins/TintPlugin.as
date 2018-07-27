package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import com.greensock.core.PropTween;
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import flash.geom.Transform;
   
   public class TintPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1.0;
      
      protected static var _props:Array = ["redMultiplier","greenMultiplier","blueMultiplier","alphaMultiplier","redOffset","greenOffset","blueOffset","alphaOffset"];
       
      
      protected var _transform:Transform;
      
      public function TintPlugin()
      {
         super();
         this.propName = "tint";
         this.overwriteProps = ["tint"];
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         if(!(param1 is DisplayObject))
         {
            return false;
         }
         var _loc5_:ColorTransform = new ColorTransform();
         if(param2 != null && param3.vars.removeTint != true)
         {
            _loc5_.color = uint(param2);
         }
         _transform = DisplayObject(param1).transform;
         var _loc4_:ColorTransform = _transform.colorTransform;
         _loc5_.alphaMultiplier = _loc4_.alphaMultiplier;
         _loc5_.alphaOffset = _loc4_.alphaOffset;
         init(_loc4_,_loc5_);
         return true;
      }
      
      public function init(param1:ColorTransform, param2:ColorTransform) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = _props.length;
         var _loc3_:int = _tweens.length;
         while(true)
         {
            _loc5_--;
            if(!_loc5_)
            {
               break;
            }
            _loc4_ = _props[_loc5_];
            if(param1[_loc4_] != param2[_loc4_])
            {
               _loc3_++;
               _tweens[_loc3_] = new PropTween(param1,_loc4_,param1[_loc4_],param2[_loc4_] - param1[_loc4_],"tint",false);
            }
         }
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         if(_transform)
         {
            _loc3_ = _transform.colorTransform;
            _loc4_ = _tweens.length;
            while(true)
            {
               _loc4_--;
               if(_loc4_ <= -1)
               {
                  break;
               }
               _loc2_ = _tweens[_loc4_];
               _loc3_[_loc2_.property] = _loc2_.start + _loc2_.change * param1;
            }
            _transform.colorTransform = _loc3_;
         }
      }
   }
}
