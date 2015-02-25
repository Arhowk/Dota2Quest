package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import ValveLib.Globals;
	import ValveLib.ResizeManager;
	
	public class CustomUI extends MovieClip {
		
		public var gameAPI:Object;
		public var globals:Object;
		public var elementName:String;
		public var localPlayer:int;
		public var quests:Array;
		
		public function CustomUI() {
			// constructor code
			trace("WHY WHY WHY");
			ListThing.addEventListener(MouseEvent.CLICK, onMouseClickDown);
			trace("good god fuck");
		}
		public function onMouseClickDown(e:MouseEvent) {
			var q:Quest = new Quest();
			q.name = "The Hunt for Gold";
			q.players = 0xFFFF;
			var l:Line = new Line();
			l.dat = "Hunt for some gold nigga";
			var a:Array = new Array(l);
			q.lines = a;
			trace(q.compileHtml());
			ListThing.htmlText = q.compileHtml();
			trace("GGGG");
		}
		
		public function onLoaded() : void {			
			localPlayer = this.globals.Players.GetLocalPlayer();
			//make this UI visible
			visible = true;
			
			//let the client rescale the UI
			Globals.instance.resizeManager.AddListener(this);
   			this.gameAPI.SubscribeToGameEvent("quest_remove", this.onQuestRemove);
			
			//this is not needed, but it shows you your UI has loaded (needs 'scaleform_spew 1' in console)
			trace("Custom UI loaded!");
		}
		
		/////////////////
		//LISTENERS
		/////////////////
		public function onQuestAdd(args:Object) : void {
			var q:Quest = new Quest();
			q.players = args.players;
			q.name = args.name;
			quests[args.id] = q;
			if(!confirmPlayer(q)) return;
		}
		
		public function onQuestRemove(args:Object) : void {
			ListThing.htmlText += "QUEST REMOVED: " + args.id;
			quests[args.id] = null;
			trace("onQuestRemove");
			trace("Param 'id': ", args.id);
		}
		///////////////////
		//ADDED FUNCTIONS
		///////////////////
		public function confirmPlayer(q:Quest) : Boolean{
			return (q.players & (1 << localPlayer)) > 0;
		}
		public function addQuest(q:Quest) : void{
			if(quests[q.id] != null){
				trace("[QuestUI] ERROR: DOUBLE QUEST ID ALLOCATION");
				return;
			}
			quests[q.id] = q;
			updateText();
		}
		public function removeQuest(q:Quest) : void{
			if(q == null || quests[q.id] == null){
				trace("[QuestUI] ERROR: REMOVING NULL QUEST");
				return;
			}
			quests[q.id] = null;
			updateText();
		}
		public function updateText() : void{
			ListThing.htmlText = compileText();
		}
		public function compileText() : String{
			var s:String;
			var c:Boolean = true;
			for each(var b : quests){
				if(c){
					c = true;
				}else{
					s += "<br>"
				}
				s += b.compileHtml();
			}
		}
		//////////////////////
		//BOTTOMLINE UI
		/////////////////////
		//this handles the resizes - credits to Nullscope
		public function onResize(re:ResizeManager) : * {
			var rm = Globals.instance.resizeManager;
            var currentRatio:Number =  re.ScreenWidth / re.ScreenHeight;
            var divided:Number;
            var originalHeight:Number = 900;
            if(currentRatio < 1.5)
            {
                divided = currentRatio / 1.333;
            }
            else if(re.Is16by9()){
                divided = currentRatio / 1.7778;
            } else {
                divided = currentRatio / 1.6;
            }
            var correctedRatio:Number =  re.ScreenHeight / originalHeight * divided;
		}
	}
	
}
