package
{
	import flash.filesystem.File;

	public class ConfigProperties extends Object
	{
		
		public static var skyPath:String;
		public static var savePath:String = File.documentsDirectory+"/My Games/Skyrim";
		public static var charName:String= "";
		public static var closeApp:Boolean=false;
		public static var splashTime:Number=2;
		public static var zipFiles:Boolean = false;
		
		
	}
}