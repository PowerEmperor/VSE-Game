package VSEGame
{
	import away3d.cameras.*;
	import away3d.containers.*;
	import away3d.core.utils.Cast;
	import away3d.core.utils.Color;
	import away3d.materials.*;
	import away3d.primitives.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.ui.Keyboard;
	import flash.utils.*;
	
	import wumedia.vector.*;
	
	public class MenuLoader
	{
		////////////////////////////////////////////////////////////
		// The Main Menu Textures.
		////////////////////////////////////////////////////////////
		
		[Embed (source="data/Menu/EN_Main_Menu.png")] private var EN_MainMenu:Class;
		[Embed (source="data/Menu/EN_HowTo_Menu.png")] private var EN_HowToMenu:Class;
		[Embed (source="data/Menu/EN_Highscore_Menu.png")] private var EN_HighscoreMenu:Class;
		[Embed (source="data/Menu/EN_Options_Menu.png")] private var EN_OptionsMenu:Class;
		
		[Embed (source="data/Menu/NL_Main_Menu.png")] private var NL_MainMenu:Class;
		[Embed (source="data/Menu/NL_HowTo_Menu.png")] private var NL_HowToMenu:Class;
		[Embed (source="data/Menu/NL_Highscore_Menu.png")] private var NL_HighscoreMenu:Class;
		[Embed (source="data/Menu/NL_Options_Menu.png")] private var NL_OptionsMenu:Class;
		
		[Embed (source="data/vera.swf", mimeType="application/octet-stream")] private var mVera : Class;
		
		////////////////////////////////////////////////////////////
		// The Ingame Menu Textures
		
		[Embed (source="data/Menu/EN_IngameMenu2.png")] private var EN_IngameMenu:Class;
		[Embed (source="data/Menu/EN_HowTo_IngameMenu.png")] private var EN_HowToIngameMenu:Class;
		[Embed (source="data/Menu/EN_Highscore_IngameMenu.png")] private var EN_HighscoreIngameMenu:Class;
		[Embed (source="data/Menu/EN_Options_IngameMenu.png")] private var EN_OptionsIngameMenu:Class;
		
		[Embed (source="data/Menu/NL_IngameMenu.png")] private var NL_IngameMenu:Class;
		[Embed (source="data/Menu/NL_HowTo_IngameMenu.png")] private var NL_HowToIngameMenu:Class;
		[Embed (source="data/Menu/NL_Highscore_IngameMenu.png")] private var NL_HighscoreIngameMenu:Class;
		[Embed (source="data/Menu/NL_Options_IngameMenu.png")] private var NL_OptionsIngameMenu:Class;
		
		////////////////////////////////////////////////////////////
		//The English Planes and Material.
		////////////////////////////////////////////////////////////
		
		public var mEN_MainMenuPlane:Plane;
		public var mEN_HowToMenuPlane:Plane;
		public var mEN_HighscoreMenuPlane:Plane;
		public var mEN_OptionsMenuPlane:Plane;
		
		public var mEN_MenuMaterial:BitmapMaterial;
		public var mEN_HowToMenuMaterial:BitmapMaterial;
		public var mEN_HighscoreMenuMaterial:BitmapMaterial;
		public var mEN_OptionsMenuMaterial:BitmapMaterial;
		
		////////////////////////////////////////////////////////////
		//The Dutch Planes and Material.
		
		public var mNL_MainMenuPlane:Plane;
		public var mNL_HowToMenuPlane:Plane;
		public var mNL_HighscoreMenuPlane:Plane;
		public var mNL_OptionsMenuPlane:Plane;
		
		public var mNL_MenuMaterial:BitmapMaterial;
		public var mNL_HowToMenuMaterial:BitmapMaterial;
		public var mNL_HighscoreMenuMaterial:BitmapMaterial;
		public var mNL_OptionsMenuMaterial:BitmapMaterial;
		
		////////////////////////////////////////////////////////////
		// These are the Ingame Loads.
		//The English Ingame Planes and Material.
		////////////////////////////////////////////////////////////
		
		public var mEN_IngameMenuPlane:Plane;
		public var mEN_HowToIngameMenuPlane:Plane;
		public var mEN_HighscoreIngameMenuPlane:Plane;
		public var mEN_OptionsIngameMenuPlane:Plane;
		
		public var mEN_IngameMenuMaterial:BitmapMaterial;
		public var mEN_HowToIngameMenuMaterial:BitmapMaterial;
		public var mEN_HighscoreIngameMenuMaterial:BitmapMaterial;
		public var mEN_OptionsIngameMenuMaterial:BitmapMaterial;
		
		////////////////////////////////////////////////////////////
		//The Dutch Ingame Planes and Material.
		
		public var mNL_IngameMenuPlane:Plane;
		public var mNL_HowToIngameMenuPlane:Plane;
		public var mNL_HighscoreIngameMenuPlane:Plane;
		public var mNL_OptionsIngameMenuPlane:Plane;
		
		public var mNL_IngameMenuMaterial:BitmapMaterial;
		public var mNL_HowToIngameMenuMaterial:BitmapMaterial;
		public var mNL_HighscoreIngameMenuMaterial:BitmapMaterial;
		public var mNL_OptionsIngameMenuMaterial:BitmapMaterial;
		
		////////////////////////////////////////////////////////////
		//FONT VARS
		
		public var mFontVera:ByteArray;
		
		public var mArrow:TextField3D;
		
		public function MenuLoader()
		{
			LoadMaterial();
			LoadPlanes();
			Init();
		}
		
		public function LoadMaterial() : void
		{
			////////////////////////////////////////////////////////////
			//Cast bitmaps
			// The Main Menu Bitmaps
			////////////////////////////////////////////////////////////
			
			mEN_MenuMaterial = new BitmapMaterial(Cast.bitmap(EN_MainMenu));
			mEN_HowToMenuMaterial = new BitmapMaterial(Cast.bitmap(EN_HowToMenu));
			mEN_HighscoreMenuMaterial = new BitmapMaterial(Cast.bitmap(EN_HighscoreMenu));
			mEN_OptionsMenuMaterial = new BitmapMaterial(Cast.bitmap(EN_OptionsMenu));
			
			mNL_MenuMaterial = new BitmapMaterial(Cast.bitmap(NL_MainMenu));
			mNL_HowToMenuMaterial = new BitmapMaterial(Cast.bitmap(NL_HowToMenu));
			mNL_HighscoreMenuMaterial = new BitmapMaterial(Cast.bitmap(NL_HighscoreMenu));
			mNL_OptionsMenuMaterial = new BitmapMaterial(Cast.bitmap(NL_OptionsMenu));
			
			////////////////////////////////////////////////////////////
			//The Ingame Menu Bitmaps
			////////////////////////////////////////////////////////////
			
			mEN_IngameMenuMaterial = new BitmapMaterial(Cast.bitmap(EN_IngameMenu));
			mEN_HowToIngameMenuMaterial = new BitmapMaterial(Cast.bitmap(EN_HowToIngameMenu));
			mEN_HighscoreIngameMenuMaterial = new BitmapMaterial(Cast.bitmap(EN_HighscoreIngameMenu));
			mEN_OptionsIngameMenuMaterial = new BitmapMaterial(Cast.bitmap(EN_OptionsIngameMenu));
			
			mNL_IngameMenuMaterial = new BitmapMaterial(Cast.bitmap(NL_IngameMenu));
			mNL_HowToIngameMenuMaterial = new BitmapMaterial(Cast.bitmap(NL_HowToIngameMenu));
			mNL_HighscoreIngameMenuMaterial = new BitmapMaterial(Cast.bitmap(NL_HighscoreIngameMenu));
			mNL_OptionsIngameMenuMaterial = new BitmapMaterial(Cast.bitmap(NL_OptionsIngameMenu));	
			
			////////////////////////////////////////////////////////////
			//Create font file
			
			mFontVera = new mVera() as ByteArray;
			VectorText.extractFont(mFontVera);
		}
		
		public function LoadPlanes() : void
		{
			////////////////////////////////////////////////////////////
			//Create the Background plane and add the Texture.
			////////////////////////////////////////////////////////////
			
			////////////////////////////////////////////////////////////
			// The Main Menu Planes.
			//This is for the English Language
			
			mEN_MainMenuPlane = new Plane();
			mEN_MainMenuPlane.width = 640;
			mEN_MainMenuPlane.height = 480;
			mEN_MainMenuPlane.x = 0;
			mEN_MainMenuPlane.y = 0;
			mEN_MainMenuPlane.yUp = false;
			mEN_MainMenuPlane.material = mEN_MenuMaterial;
			mEN_MainMenuPlane.bothsides = true;
			
			mEN_HowToMenuPlane = new Plane();
			mEN_HowToMenuPlane.width = 640;
			mEN_HowToMenuPlane.height = 480;
			mEN_HowToMenuPlane.x = 0;
			mEN_HowToMenuPlane.y = 0;
			mEN_HowToMenuPlane.yUp = false;
			mEN_HowToMenuPlane.material = mEN_HowToMenuMaterial;
			mEN_HowToMenuPlane.bothsides = true;
			
			mEN_HighscoreMenuPlane = new Plane();
			mEN_HighscoreMenuPlane.width = 640;
			mEN_HighscoreMenuPlane.height = 480;
			mEN_HighscoreMenuPlane.x = 0;
			mEN_HighscoreMenuPlane.y = 0;
			mEN_HighscoreMenuPlane.yUp = false;
			mEN_HighscoreMenuPlane.material = mEN_HighscoreMenuMaterial;
			mEN_HighscoreMenuPlane.bothsides = true;
			
			mEN_OptionsMenuPlane = new Plane();
			mEN_OptionsMenuPlane.width = 640;
			mEN_OptionsMenuPlane.height = 480;
			mEN_OptionsMenuPlane.x = 0;
			mEN_OptionsMenuPlane.y = 0;
			mEN_OptionsMenuPlane.yUp = false;
			mEN_OptionsMenuPlane.material = mEN_OptionsMenuMaterial;
			mEN_OptionsMenuPlane.bothsides = true;
			
			////////////////////////////////////////////////////////////
			//This is for the Dutch Language
			
			mNL_MainMenuPlane = new Plane();
			mNL_MainMenuPlane.width = 640;
			mNL_MainMenuPlane.height = 480;
			mNL_MainMenuPlane.x = 0;
			mNL_MainMenuPlane.y = 0;
			mNL_MainMenuPlane.yUp = false;
			mNL_MainMenuPlane.material = mNL_MenuMaterial;
			mNL_MainMenuPlane.bothsides = true;
			
			mNL_HowToMenuPlane = new Plane();
			mNL_HowToMenuPlane.width = 640;
			mNL_HowToMenuPlane.height = 480;
			mNL_HowToMenuPlane.x = 0;
			mNL_HowToMenuPlane.y = 0;
			mNL_HowToMenuPlane.yUp = false;
			mNL_HowToMenuPlane.material = mNL_HowToMenuMaterial;
			mNL_HowToMenuPlane.bothsides = true;
			
			mNL_HighscoreMenuPlane = new Plane();
			mNL_HighscoreMenuPlane.width = 640;
			mNL_HighscoreMenuPlane.height = 480;
			mNL_HighscoreMenuPlane.x = 0;
			mNL_HighscoreMenuPlane.y = 0;
			mNL_HighscoreMenuPlane.yUp = false;
			mNL_HighscoreMenuPlane.material = mNL_HighscoreMenuMaterial;
			mNL_HighscoreMenuPlane.bothsides = true;
			
			mNL_OptionsMenuPlane = new Plane();
			mNL_OptionsMenuPlane.width = 640;
			mNL_OptionsMenuPlane.height = 480;
			mNL_OptionsMenuPlane.x = 0;
			mNL_OptionsMenuPlane.y = 0;
			mNL_OptionsMenuPlane.yUp = false;
			mNL_OptionsMenuPlane.material = mNL_OptionsMenuMaterial;
			mNL_OptionsMenuPlane.bothsides = true;
			
			////////////////////////////////////////////////////////////
			//The Ingame Planes.
			// The English Language
			////////////////////////////////////////////////////////////
			
			mEN_IngameMenuPlane = new Plane();
			mEN_IngameMenuPlane.width = 320;
			mEN_IngameMenuPlane.height = 360;
			mEN_IngameMenuPlane.x = 0;
			mEN_IngameMenuPlane.y = 0;
			mEN_IngameMenuPlane.yUp = false;
			mEN_IngameMenuPlane.material = mEN_IngameMenuMaterial;
			mEN_IngameMenuPlane.bothsides = true;
			
			mEN_HowToIngameMenuPlane = new Plane();
			mEN_HowToIngameMenuPlane.width = 640;
			mEN_HowToIngameMenuPlane.height = 480;
			mEN_HowToIngameMenuPlane.x = 0;
			mEN_HowToIngameMenuPlane.y = 0;
			mEN_HowToIngameMenuPlane.yUp = false;
			mEN_HowToIngameMenuPlane.material = mEN_HowToIngameMenuMaterial;
			mEN_HowToIngameMenuPlane.bothsides = true;
			
			mEN_HighscoreIngameMenuPlane = new Plane();
			mEN_HighscoreIngameMenuPlane.width = 640;
			mEN_HighscoreIngameMenuPlane.height = 480;
			mEN_HighscoreIngameMenuPlane.x = 0;
			mEN_HighscoreIngameMenuPlane.y = 0;
			mEN_HighscoreIngameMenuPlane.yUp = false;
			mEN_HighscoreIngameMenuPlane.material = mEN_HighscoreIngameMenuMaterial;
			mEN_HighscoreIngameMenuPlane.bothsides = true;
			
			mEN_OptionsIngameMenuPlane = new Plane();
			mEN_OptionsIngameMenuPlane.width = 640;
			mEN_OptionsIngameMenuPlane.height = 480;
			mEN_OptionsIngameMenuPlane.x = 0;
			mEN_OptionsIngameMenuPlane.y = 0;
			mEN_OptionsIngameMenuPlane.yUp = false;
			mEN_OptionsIngameMenuPlane.material = mEN_OptionsIngameMenuMaterial;
			mEN_OptionsIngameMenuPlane.bothsides = true;
			
			////////////////////////////////////////////////////////////
			//This is for the Dutch Language
			
			mNL_IngameMenuPlane = new Plane();
			mNL_IngameMenuPlane.width = 640;
			mNL_IngameMenuPlane.height = 480;
			mNL_IngameMenuPlane.x = 0;
			mNL_IngameMenuPlane.y = 0;
			mNL_IngameMenuPlane.yUp = false;
			mNL_IngameMenuPlane.material = mNL_IngameMenuMaterial;
			mNL_IngameMenuPlane.bothsides = true;
			
			mNL_HowToIngameMenuPlane = new Plane();
			mNL_HowToIngameMenuPlane.width = 640;
			mNL_HowToIngameMenuPlane.height = 480;
			mNL_HowToIngameMenuPlane.x = 0;
			mNL_HowToIngameMenuPlane.y = 0;
			mNL_HowToIngameMenuPlane.yUp = false;
			mNL_HowToIngameMenuPlane.material = mNL_HowToIngameMenuMaterial;
			mNL_HowToIngameMenuPlane.bothsides = true;
			
			mNL_HighscoreIngameMenuPlane = new Plane();
			mNL_HighscoreIngameMenuPlane.width = 640;
			mNL_HighscoreIngameMenuPlane.height = 480;
			mNL_HighscoreIngameMenuPlane.x = 0;
			mNL_HighscoreIngameMenuPlane.y = 0;
			mNL_HighscoreIngameMenuPlane.yUp = false;
			mNL_HighscoreIngameMenuPlane.material = mNL_HighscoreIngameMenuMaterial;
			mNL_HighscoreIngameMenuPlane.bothsides = true;
			
			mNL_OptionsIngameMenuPlane = new Plane();
			mNL_OptionsIngameMenuPlane.width = 640;
			mNL_OptionsIngameMenuPlane.height = 480;
			mNL_OptionsIngameMenuPlane.x = 0;
			mNL_OptionsIngameMenuPlane.y = 0;
			mNL_OptionsIngameMenuPlane.yUp = false;
			mNL_OptionsIngameMenuPlane.material = mNL_OptionsIngameMenuMaterial;
			mNL_OptionsIngameMenuPlane.bothsides = true;
			
			////////////////////////////////////////////////////////////
			//The Arrow key Text field
			
			mArrow = new TextField3D('Vera Sans');
			mArrow.size = 25;
			mArrow.width = 500;
			mArrow.x = -250;
			mArrow.y = 100;
			mArrow.text = "»";
			mArrow.material = new ColorMaterial(0x990E17);
		}
		
		public function Init() : void 
		{
			////////////////////////////////////////////////////////////
			//The English Planes and Material.
			////////////////////////////////////////////////////////////
			
			mEN_MainMenuPlane.visible = false;
			mEN_HowToMenuPlane.visible = false;
			mEN_HighscoreMenuPlane.visible = false;
			mEN_OptionsMenuPlane.visible = false;
			
			////////////////////////////////////////////////////////////
			//The Dutch Planes and Material.
			
			mNL_MainMenuPlane.visible = false;
			mNL_HowToMenuPlane.visible = false;
			mNL_HighscoreMenuPlane.visible = false;
			mNL_OptionsMenuPlane.visible = false;

			////////////////////////////////////////////////////////////
			// These are the Ingame Planes.
			//The English Ingame Planes and Material.
			////////////////////////////////////////////////////////////
			
			mEN_IngameMenuPlane.visible = false;
			mEN_HowToIngameMenuPlane.visible = false;
			mEN_HighscoreIngameMenuPlane.visible = false;
			mEN_OptionsIngameMenuPlane.visible = false;
			
			////////////////////////////////////////////////////////////
			//The Dutch Ingame Planes and Material.
			
			mNL_IngameMenuPlane.visible = false;
			mNL_HowToIngameMenuPlane.visible = false;
			mNL_HighscoreIngameMenuPlane.visible = false;
			mNL_OptionsIngameMenuPlane.visible = false;
		}
	}
}