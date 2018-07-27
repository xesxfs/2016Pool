package fla.play.__EW
{
   public class __FL
   {
       
      
      public var aa:Number = 0;
      
      public var ab:Number = 0;
      
      public var ca:Number = 0;
      
      public var __Cu:Number = 0;
      
      public var bc:Number = 0;
      
      public var ac:Number = 0;
      
      public var bb:Number = 0;
      
      public var cc:Number = 0;
      
      public var ba:Number = 0;
      
      public function __FL()
      {
         super();
      }
      
      public function __50() : void
      {
         aa = 1;
         ab = 0;
         ac = 0;
         ba = 0;
         bb = 1;
         bc = 0;
         ca = 0;
         __Cu = 0;
         cc = 1;
      }
      
      public function __4R(param1:__FL) : void
      {
         aa = param1.aa;
         ab = param1.ab;
         ac = param1.ac;
         ba = param1.ba;
         bb = param1.bb;
         bc = param1.bc;
         ca = param1.ca;
         __Cu = param1.__Cu;
         cc = param1.cc;
      }
      
      public function __0J(param1:__FL) : void
      {
         var _loc9_:Number = param1.aa * aa + param1.ba * ab + param1.ca * ac;
         var _loc10_:Number = param1.ab * aa + param1.bb * ab + param1.__Cu * ac;
         var _loc2_:Number = param1.ac * aa + param1.bc * ab + param1.cc * ac;
         var _loc3_:Number = param1.aa * ba + param1.ba * bb + param1.ca * bc;
         var _loc4_:Number = param1.ab * ba + param1.bb * bb + param1.__Cu * bc;
         var _loc5_:Number = param1.ac * ba + param1.bc * bb + param1.cc * bc;
         var _loc6_:Number = param1.aa * ca + param1.ba * __Cu + param1.ca * cc;
         var _loc7_:Number = param1.ab * ca + param1.bb * __Cu + param1.__Cu * cc;
         var _loc8_:Number = param1.ac * ca + param1.bc * __Cu + param1.cc * cc;
         aa = _loc9_;
         ab = _loc10_;
         ac = _loc2_;
         ba = _loc3_;
         bb = _loc4_;
         bc = _loc5_;
         ca = _loc6_;
         __Cu = _loc7_;
         cc = _loc8_;
      }
      
      public function __1x(param1:__7O) : void
      {
         var _loc4_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = param1.x;
         _loc4_ = param1.y;
         _loc2_ = param1.z;
         param1.x = _loc3_ * aa + _loc4_ * ab + _loc2_ * ac;
         param1.y = _loc3_ * ba + _loc4_ * bb + _loc2_ * bc;
         param1.z = _loc3_ * ca + _loc4_ * __Cu + _loc2_ * cc;
      }
      
      public function __CG(param1:__7O, param2:Number) : void
      {
         var _loc8_:Number = Math.sin(param2);
         var _loc3_:Number = Math.cos(param2);
         var _loc4_:Number = 1 - _loc3_;
         var _loc5_:Number = param1.x;
         var _loc6_:Number = param1.y;
         var _loc7_:Number = param1.z;
         aa = _loc4_ * _loc5_ * _loc5_ + _loc3_;
         ab = _loc4_ * _loc5_ * _loc6_ - _loc8_ * _loc7_;
         ac = _loc4_ * _loc5_ * _loc7_ + _loc8_ * _loc6_;
         ba = _loc4_ * _loc5_ * _loc6_ + _loc8_ * _loc7_;
         bb = _loc4_ * _loc6_ * _loc6_ + _loc3_;
         bc = _loc4_ * _loc6_ * _loc7_ - _loc8_ * _loc5_;
         ca = _loc4_ * _loc5_ * _loc7_ - _loc8_ * _loc6_;
         __Cu = _loc4_ * _loc6_ * _loc7_ + _loc8_ * _loc5_;
         cc = _loc4_ * _loc7_ * _loc7_ + _loc3_;
      }
   }
}
