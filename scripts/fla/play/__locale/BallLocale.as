package fla.play.__locale
{
   public class BallLocale
   {
       
      
      private var __AA:Number;
      
      private var __Q:Number;
      
      public function BallLocale(param1:Number, param2:Number)
      {
         super();
         __AA = param1;
         __Q = param2;
      }
      
      public function set time(param1:Number) : void
      {
         __AA = param1;
      }
      
      public function get force() : Number
      {
         return __Q;
      }
      
      public function get time() : Number
      {
         return __AA;
      }
   }
}
