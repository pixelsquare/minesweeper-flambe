package minesweeper.screen.main;

import flambe.asset.AssetPack;
import flambe.display.Font;
import flambe.display.TextSprite;
import flambe.Entity;
import flambe.input.KeyboardEvent;
import flambe.script.CallFunction;
import flambe.script.Delay;
import flambe.script.Script;
import flambe.script.Sequence;
import flambe.subsystem.StorageSystem;
import flambe.display.ImageSprite;
import flambe.System;
import flambe.input.Key;

import minesweeper.core.SceneManager;
import minesweeper.screen.GameScreen;
import minesweeper.name.AssetName;
import minesweeper.Utils;

/**
 * ...
 * @author Anthony Ganzon
 */
class MainScreen extends GameScreen
{

	private var gameTime: Int;
	private var gameBombCount: Int;
	
	private static inline var GAME_DEFAULT_TIME: Int = 300;
	
	public function new(assetPack:AssetPack, storage:StorageSystem) {
		super(assetPack, storage);
		
		this.gameTime = GAME_DEFAULT_TIME;
		this.gameBombCount = 0;
		
		//System.keyboard.down.connect(function(event: KeyboardEvent) {
			//if (event.key == Key.B) {
				//SceneManager.current.ShowGameOverScreen();
			//}
		//});
	}
	
	override public function CreateScreen(): Entity {
		screenEntity = super.CreateScreen();
		
		var background: ImageSprite = new ImageSprite(gameAsset.getTexture(AssetName.ASSET_INGAME_BG));
		screenEntity.addChild(new Entity().add(background));
		
		// Wait before starting
		var script: Script = new Script();
		script.run(new Sequence([
			new Delay(0.1),
			new CallFunction(function() {
				SceneManager.current.ShowWaitScreen();
			})
		]));
		screenEntity.add(script);
		
		var timerEntity: Entity = new Entity();
		var timerBg: ImageSprite = new ImageSprite(gameAsset.getTexture(AssetName.ASSET_TIMER_CONTAINER));
		timerBg.centerAnchor();
		timerBg.setXY(
			System.stage.width * 0.29,
			System.stage.height * 0.91
		);
		timerEntity.addChild(new Entity().add(timerBg));
		
		var timerFont: Font = new Font(gameAsset, AssetName.FONT_VANADINE_32);
		var timerText: TextSprite = new TextSprite(timerFont, Utils.ToMMSS(gameTime));
		timerText.centerAnchor();
		timerText.setXY(
			timerBg.x._ + 20,
			timerBg.y._
		);
		timerEntity.addChild(new Entity().add(timerText));
		
		screenEntity.addChild(timerEntity);
		
		var bombsEntity: Entity = new Entity();
		var bombsBg: ImageSprite = new ImageSprite(gameAsset.getTexture(AssetName.ASSET_BOMB_CONTAINER));
		bombsBg.centerAnchor();
		bombsBg.setXY(
			System.stage.width * 0.71,
			System.stage.height * 0.91
		);
		bombsEntity.addChild(new Entity().add(bombsBg));
		
		var bombsFont: Font = new Font(gameAsset, AssetName.FONT_VANADINE_32);
		var bombsText: TextSprite = new TextSprite(bombsFont, gameBombCount + "");
		bombsText.centerAnchor();
		bombsText.setXY(
			bombsBg.x._ + 20,
			bombsBg.y._
		);
		bombsEntity.addChild(new Entity().add(bombsText));
		
		screenEntity.addChild(bombsEntity);
		
		return screenEntity;
	}
	
	override public function GetScreenName(): String {
		return super.GetScreenName();
	}
}