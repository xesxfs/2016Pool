package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   
   public class ColorTransformPlugin extends TintPlugin
   {
      
      public static const API:Number = 1.0;
       
      
      public function ColorTransformPlugin()
      {
         super();
         this.propName = "colorTransform";
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         var _loc5_:* = null;
         var _loc4_:Number = NaN;
         var _loc7_:ColorTransform = new ColorTransform();
         if(param1 is DisplayObject)
         {
            _transform = DisplayObject(param1).transform;
            _loc5_ = _transform.colorTransform;
         }
         else if(param1 is ColorTransform)
         {
            _loc5_ = param1 as ColorTransform;
         }
         else
         {
            return false;
         }
         _loc7_.concat(_loc5_);
         var _loc9_:* = 0;
         var _loc8_:* = param2;
         for(var _loc6_ in param2)
         {
            if(_loc6_ == "tint" || _loc6_ == "color")
            {
               if(param2[_loc6_] != null)
               {
                  _loc7_.color = int(param2[_loc6_]);
               }
            }
            else if(!(_loc6_ == "tintAmount" || _loc6_ == "exposure" || _loc6_ == "brightness"))
            {
               _loc7_[_loc6_] = param2[_loc6_];
            }
         }
         if(!isNaN(param2.tintAmount))
         {
            _loc4_ = param2.tintAmount / (1 - (_loc7_.redMultiplier + _loc7_.greenMultiplier + _loc7_.blueMultiplier) / 3);
            _loc7_.redOffset = _loc7_.redOffset * _loc4_;
            _loc7_.greenOffset = _loc7_.greenOffset * _loc4_;
            _loc7_.blueOffset = _loc7_.blueOffset * _loc4_;
            _loc9_ = 1 - param2.tintAmount;
            _loc7_.blueMultiplier = _loc9_;
            _loc8_ = _loc9_;
            _loc7_.greenMultiplier = _loc8_;
            _loc7_.redMultiplier = _loc8_;
         }
         else if(!isNaN(param2.exposure))
         {
            _loc9_ = 255 * (param2.exposure - 1);
            _loc7_.blueOffset = _loc9_;
            _loc8_ = _loc9_;
            _loc7_.greenOffset = _loc8_;
            _loc7_.redOffset = _loc8_;
            _loc9_ = 1;
            _loc7_.blueMultiplier = _loc9_;
            _loc8_ = _loc9_;
            _loc7_.greenMultiplier = _loc8_;
            _loc7_.redMultiplier = _loc8_;
         }
         else if(!isNaN(param2.brightness))
         {
            _loc9_ = Math.max(0,(param2.brightness - 1) * 255);
            _loc7_.blueOffset = _loc9_;
            _loc8_ = _loc9_;
            _loc7_.greenOffset = _loc8_;
            _loc7_.redOffset = _loc8_;
            _loc9_ = 1 - Math.abs(param2.brightness - 1);
            _loc7_.blueMultiplier = _loc9_;
            _loc8_ = _loc9_;
            _loc7_.greenMultiplier = _loc8_;
            _loc7_.redMultiplier = _loc8_;
         }
         init(_loc5_,_loc7_);
         return true;
      }
   }
}
