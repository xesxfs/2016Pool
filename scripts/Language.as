package
{
   import flash.globalization.StringTools;
   import flash.system.Capabilities;
   
   public class Language
   {
      
      public static var field:String;
      
      private static var _fileds:Array;
       
      
      public function Language()
      {
         super();
      }
      
      public static function get isForeign() : Boolean
      {
         return Capabilities.language.indexOf("zh") != 0;
      }
      
      public static function init(param1:Array) : void
      {
         _fileds = param1;
      }
      
      public static function id(param1:int, param2:String = null) : String
      {
         var _loc3_:String = null;
         try
         {
            _loc3_ = _G.fc.csv.selectObjectA("langStrings",param1)[param2 || field];
         }
         catch(e:Error)
         {
            trace("Can not find language id:" + param1);
         }
         return _loc3_;
      }
      
      public static function fetchRegionNameBy(param1:String) : String
      {
         var _loc3_:Object = _G.fc.csv.selectObjectA("iso3166",param1,1);
         var _loc2_:Object = _G.fc.csv.selectObjectA("langStrings",_loc3_.id);
         return _loc2_[field];
      }
      
      public static function fetchLangFieldBy(param1:String) : String
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         _loc5_ = 0;
         _loc3_ = _fileds.length;
         _fileds.length;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _fileds[_loc5_];
            _loc6_ = _loc4_.iso_639_3166;
            if(_loc6_.indexOf(param1) != -1)
            {
               return _loc4_.field;
            }
            _loc5_++;
         }
         var _loc2_:String = param1.split("-")[0];
         _loc5_ = 0;
         _loc3_ = _fileds.length;
         _fileds.length;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _fileds[_loc5_];
            _loc6_ = _loc4_.iso_639_3166;
            if(_loc6_.indexOf(_loc2_) != -1)
            {
               return _loc4_.field;
            }
            _loc5_++;
         }
         return _fileds[0].field;
      }
      
      public static function fetchLangsBy(param1:String) : Vector.<String>
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:Vector.<String> = new Vector.<String>();
         var _loc4_:Vector.<String> = StringTools.getAvailableLocaleIDNames();
         _loc6_ = 0;
         _loc5_ = _loc4_.length;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = _loc4_[_loc6_];
            if(_loc2_.indexOf(param1) != -1)
            {
               _loc3_.push(_loc2_);
            }
            _loc6_++;
         }
         return _loc3_;
      }
      
      public static function replace(param1:String) : String
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:Array = param1.match(/\$L(\d+)/g);
         _loc6_ = 0;
         _loc5_ = _loc2_.length;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = _loc2_[_loc6_];
            _loc4_ = parseInt(_loc3_.substr(2));
            param1 = param1.replace(_loc3_,id(_loc4_));
            _loc6_++;
         }
         return param1;
      }
   }
}
