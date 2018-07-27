package fla.play.__CH
{
   import flash.geom.Point;
   
   public class Spots implements ISpots
   {
      
      private static const __9r:Point = new Point(63.5,0);
      
      private static const __0B:Number = 254;
      
      private static const __4g:Number = 127;
      
      private static const __0h:Point = new Point(0,0);
      
      private static const __0j:Point = new Point(-63.5,0);
       
      
      private var __F1:Array;
      
      private var __1u:Array;
      
      private var __1g:Array;
      
      private var __6c:Array;
      
      public function Spots()
      {
         __1g = [new Point(0,10.6),new Point(-9.9,-0.6),new Point(-11.2,-5.7),new Point(-9.7,-9.7),new Point(-5.7,-11.2),new Point(-0.6,-9.9),new Point(10.6,0)];
         __6c = [new Point(-7.9,0),new Point(-6.2,-5.1),new Point(-5.8,-9.2),new Point(-3.8,-11.9),new Point(0,-13.2),new Point(3.8,-11.9),new Point(5.8,-9.2),new Point(6.2,-5.1),new Point(7.9,0)];
         __1u = [new Point(-130.8,-67.3),new Point(0,-71),new Point(130.8,-67.3),new Point(130.8,67.3),new Point(0,71),new Point(-130.8,67.3)];
         super();
         __F1 = [];
         __F1.push(new Point(71.8,-76.2));
         __BE(63,-82.3,8.8,3.14159265358979 - 3.14159265358979 / 2,3.14159265358979,3,__F1);
         __F1.push(new Point(-65,-90.9));
      }
      
      public function get width() : Number
      {
         return 127;
      }
      
      public function get __1d() : Number
      {
         return 8;
      }
      
      public function get headSpot() : Point
      {
         return __0j;
      }
      
      public function get ballRunner() : Array
      {
         return __F1;
      }
      
      public function get __CF() : Point
      {
         return __9r;
      }
      
      public function get __H1() : Array
      {
         return __1g;
      }
      
      public function get __FC() : Array
      {
         return __6c;
      }
      
      public function get __6p() : Array
      {
         return __1u;
      }
      
      public function get length() : Number
      {
         return 254;
      }
      
      private function __BE(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:Array) : void
      {
         var _loc10_:int = 0;
         var _loc8_:* = param4;
         var _loc9_:Number = (param5 - param4) / param6;
         while(_loc10_ <= param6)
         {
            param7.push(new Point(param1 + Math.sin(_loc8_) * param3,param2 + Math.cos(_loc8_) * param3));
            _loc8_ = Number(_loc8_ + _loc9_);
            _loc10_++;
         }
      }
      
      public function get centerSpot() : Point
      {
         return __0h;
      }
   }
}
