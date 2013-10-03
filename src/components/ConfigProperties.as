package components
{
	import flash.filesystem.File;

	public class ConfigProperties
	{
		public static const SKYPATH:String = "skyPath";
		public static const SAVEPATH:String = "savePath";
		public static const CHARNAME:String = "charName";
		public static const CLOSEAPP:String = "closeApp";
		public static const SPLASHTIME:String = "splashTime";
		public static const ZIPFILES:String = "zipFiles";
		
		public static var type:Array = ["skyPath", "savePath", "charName", "closeApp", "splashTime", "zipFiles"]
		public static var value:Array = ["", File.documentsDirectory.nativePath+"/My Games/Skyrim", "", true, 2, false]
		/*private static var _skyPath:String = "";
		private static var _savePath:String = File.documentsDirectory.nativePath+"/My Games/Skyrim";
		private static var _charName:String= "";
		private static var _closeApp:Boolean=false;
		private static var _splashTime:Number=2;
		private static var _zipFiles:Boolean = false;*/
		
		public static function get length():Number{
			
			return type.length
		}
		
		public static function getProperty(_type:String):*
		{
			var n:Number = type.indexOf(_type)
			return value[n]
		}
		
		public static function setProperty(_type:*, _value:*):void
		{
			var n:Number = type.indexOf(_type)
				value[n] = _value
		}
		
		public static function getPropertyAt(index:Number):*					  
		{
		
			return value[index]
		}
		
		public static function getTypeAt(index:Number):String					  
		{
			
			return type[index]
		}
		
		public static function setPropertyAt(index:Number, _value:*):void
		{
			
			value[index] = _value
		}
		
		/*public function set skyPath(value:String):void{
			
			_skyPath = value
		}
		
		public function get skyPath():String{
			
			return _skyPath
		}
		
		public function set savePath(value:String):void{
			
			_savePath = value
		}
		
		public function get savePath():String{
			
			return _savePath
		}*/
		
		
		
	}
}