package VSEGame
{
	import away3d.cameras.*;
	import away3d.containers.*;
	import away3d.core.utils.Cast;
	import away3d.core.utils.Color;
	import away3d.events.Loader3DEvent;
	import away3d.materials.*;
	import away3d.primitives.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.ui.Keyboard;
	import flash.utils.*;
	
	import org.osmf.events.LoaderEvent;
	
	import wumedia.vector.*;
	
	[SWF(width="500", height="400", frameRate="60")]
	
	public class TrailerLoader extends Sprite
	{
		private var _view : View3D;
		private var _Trailer : Loader3D;
		
		private var _light : PointLight;
		
		private var _camController : HoverDragController;
		private var _count : Number = 0;
		private var _subsurfaceMethod : SubsurfaceScatteringDiffuseMethod;
		private var _diffuseMethod : BasicDiffuseMethod;
		private var _material : BitmapMaterial;
		private var _fresnelMethod : FresnelSpecularMethod;
		private var _specularMethod : BasicSpecularMethod;
		
		public function TruckLoader()
		{
			_view = new View3D();
			_view.antiAlias = 4;
			this.addChild(_view);
			
			
			_light = new PointLight();
			_light.x = 15000;
			_light.z = 15000;
			_light.color = 0xffddbb;
			_view.scene.addChild(_light);
			_camController = new HoverDragController(_view.camera, stage);
			addChild(new AwayStats(_view));
			initMesh();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.RESIZE, onStageResize);
		}
		
		private function onStageResize(event : Event) : void
		{
			_view.width = stage.stageWidth;
			_view.height = stage.stageHeight;
		}
		
		private function initMesh() : void
		{
			Loader3D.enableParser(OBJParser);
			_Trailer = new Loader3d();
			_Trailer.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onResourceComplete);
			_Trailer.load(new Loader ("data/Trailer.FBX"));
			_view.scene.addChild(_Trailer); 
		}
		
		private function onResourceComplete(ev : LoaderEvent) : void
		{
			var mesh : Mesh;
			for (var i : int = 0; i < _Trailer.numChildren; ++i) 
			{
				mesh = Mesh(_Trailer.getChildAt(i));
				mesh.geometry.scale(100);
				mesh.y = -70
				mesh.material = _material
			}
		}
		
		
		
		private function onEnterFrame(ev : Event) : void
		{
			_count += .003;
			_container.rotationY += .3;
			
			_light.x = Math.sin(_count) * 150000;
			_light.y = 1000;
			_light.z = Math.cos(_count) * 150000;
			
			_view.render();
		}
	} // class
}