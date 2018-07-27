package com.greensock.plugins
{
   import com.greensock.TweenLite;
   
   public class ShortRotationPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1.0;
       
      
      public function ShortRotationPlugin()
      {
         super();
         this.propName = "shortRotation";
         this.overwriteProps = [];
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         if(typeof param2 == "number")
         {
            return false;
         }
         var _loc5_:* = param2.useRadians == true;
         var _loc7_:int = 0;
         var _loc6_:* = param2;
         for(var _loc4_ in param2)
         {
            if(_loc4_ != "useRadians")
            {
               initRotation(param1,_loc4_,param1[_loc4_],typeof param2[_loc4_] == "number"?Number(param2[_loc4_]):param1[_loc4_] + Number(param2[_loc4_]),_loc5_);
            }
         }
         return true;
      }
      
      public function initRotation(param1:Object, param2:String, param3:Number, param4:Number, param5:Boolean = false) : void
      {
         var _loc6_:Number = !!param5?3.14159265358979 * 2:Number(360);
         var _loc7_:Number = (param4 - param3) % _loc6_;
         if(_loc7_ != _loc7_ % (_loc6_ / 2))
         {
            _loc7_ = _loc7_ < 0?_loc7_ + _loc6_:Number(_loc7_ - _loc6_);
         }
         addTween(param1,param2,param3,param3 + _loc7_,param2);
         this.overwriteProps[this.overwriteProps.length] = param2;
      }
   }
}
