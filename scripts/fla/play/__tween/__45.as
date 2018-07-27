package fla.play.__tween
{
   import flash.utils.ByteArray;
   
   public class __45
   {
      
      private static var __76:ByteArray = new ByteArray();
       
      
      private var __B8:Array;
      
      private var __57:Array;
      
      public function __45()
      {
         __57 = new Array(8);
         __B8 = new Array(8);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            __B8[_loc1_] = int(Math.random() * 256);
            _loc1_++;
         }
      }
      
      public function get value() : Number
      {
         __76.length = 0;
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            __76[_loc1_] = __57[_loc1_] ^ __B8[_loc1_];
            _loc1_++;
         }
         return __76.readDouble();
      }
      
      public function set value(param1:Number) : void
      {
         __76.length = 0;
         __76.writeDouble(param1);
         var _loc2_:int = 0;
         while(_loc2_ < 8)
         {
            __57[_loc2_] = __76[_loc2_] ^ __B8[_loc2_];
            _loc2_++;
         }
      }
   }
}
