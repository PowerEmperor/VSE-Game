// ActionScript file
package VSEGame
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.xml.XMLNode;
	
	public class XMLLoader
	{
		//URL Loader, Gets the data from the internet or local content
		private var Loader:URLLoader;
		//Public var where XML data is stored
		public var XML_Data:XML;
		//Boolean flag to check if XML data is loaded
		public var Loaded:Boolean = new Boolean(false);
		//Lang id to set the lang.
		public var LanguageId:int;
		
		public function XMLLoader()
		{
			Loader = new URLLoader();
			//Load XML file
			Loader.load(new URLRequest("data/lang.xml"));
			//Add event if loader is done loading XML stuff
			Loader.addEventListener(Event.COMPLETE,Load_data);
			
		}
		
		public function Load_data(Return_data:Event):void
		{
			//Store XML data in global var
			XML_Data = new XML(Return_data.target.data);
			//Set lang id
			LanguageId = new int(0);
			//Set load flag to true
			Loaded = true;
		}
		
		//public function Set_Lang(var myLang:int):void
		//{
			//lang_id = myLang;
		//}
	}
}