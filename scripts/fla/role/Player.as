package fla.role
{
   import com.ALIB.Utils;
   import flash.events.EventDispatcher;
   
   public class Player extends EventDispatcher
   {
      
      public static const FLAG_FIRST:int = 0;
      
      public static const FLAG_EN:int = 1;
      
      public static const FLAG_CREATE:int = 2;
       
      
      public var model:Object;
      
      public function Player()
      {
         super();
      }
      
      public function init(param1:Object) : void
      {
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         this.model = param1;
         _loc5_ = _G.fc.csv.selectObjectA("role",0);
         Utils.fillInto(_loc5_,param1);
         _loc5_ = _G.fc.csv.selectObjectA("player",0);
         Utils.fillInto(_loc5_,param1);
         if(!param1.uuid)
         {
            _loc2_ = new Date();
            _loc4_ = _loc2_.getMonth() + 1;
            _loc3_ = _loc2_.getFullYear() + "" + (_loc4_ < 10?"0" + _loc4_:_loc4_) + "" + _loc2_.getDate() + "" + _loc2_.getHours() + "" + _loc2_.getMinutes() + "" + _loc2_.getSeconds();
            param1.uuid = _G.getISO3166() + _loc3_ + Utils.getRandString(3);
         }
      }
      
      public function archived(param1:String = null) : Object
      {
         var _loc2_:Object = Utils.copyObject(model);
         return _loc2_;
      }
      
      public function getUUID() : String
      {
         return model.uuid;
      }
      
      public function getAlarmVer() : int
      {
         return model.alarmVer;
      }
      
      public function setAlarmVer(param1:int) : void
      {
         model.alarmVer = param1;
      }
      
      public function getName() : String
      {
         return model.name;
      }
      
      public function setName(param1:String) : void
      {
         model.name = param1;
      }
      
      public function getFlagAt(param1:int) : Boolean
      {
         return Boolean(model.flags & 1 << param1);
      }
      
      public function setFlag(param1:int, param2:Boolean) : int
      {
         var _loc3_:uint = 1 << param1;
         model.flags = model.flags & uint(~_loc3_);
         if(param2 == true)
         {
            model.flags = model.flags | _loc3_;
         }
         return model.flags;
      }
      
      public function getStep() : int
      {
         return model.step;
      }
      
      public function setStep(param1:int) : void
      {
         model.step = param1;
      }
      
      public function setLangField(param1:String) : void
      {
         model.langField = param1;
      }
      
      public function getLangField() : String
      {
         var _loc1_:String = model.langField;
         if(!_loc1_)
         {
            _loc1_ = Language.fetchLangFieldBy(_G.getISO_639_3166());
         }
         return _loc1_;
      }
      
      public function getNumRecord() : int
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = model.records;
         for(var _loc2_ in model.records)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      public function getRecordBy(param1:int, param2:Array) : Array
      {
         if(!(param1 in model.records))
         {
            if(param2 == null)
            {
               return param2;
            }
            model.records[param1] = param2.concat();
         }
         return model.records[param1];
      }
      
      public function getStar() : int
      {
         return _G.fc.csv.selectObjectA2("roleLevel",model.score).star;
      }
      
      public function getLevel() : int
      {
         return _G.fc.csv.selectObjectA2("roleLevel",model.score).level;
      }
      
      public function getScore() : int
      {
         return model.score;
      }
      
      public function setScore(param1:int) : void
      {
         model.score = param1;
      }
      
      public function addScore(param1:int) : void
      {
         model.score = model.score + param1;
      }
      
      public function getNumDownload() : int
      {
         return model.downloads.length;
      }
      
      public function addDownload(param1:Object) : void
      {
         model.downloads.push(param1);
      }
      
      public function delDownload(param1:int) : void
      {
         var _loc2_:int = indexOfDownload(param1);
         var _loc3_:Array = model.downloads;
         _loc3_.splice(_loc2_,1);
      }
      
      public function indexOfDownload(param1:int) : int
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:Array = model.downloads;
         _loc5_ = 0;
         _loc4_ = _loc2_.length;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _loc2_[_loc5_];
            if(_loc3_.id == param1)
            {
               return _loc5_;
            }
            _loc5_++;
         }
         return -1;
      }
   }
}
