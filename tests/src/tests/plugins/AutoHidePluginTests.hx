package tests.plugins;

#if openfl
import openfl.display.Shape;
#elseif flash
import flash.display.Shape;
#end
import com.gskinner.motion.GTween;
import com.gskinner.motion.plugins.AutoHidePlugin;
import utest.Assert;
import utest.Test;

class AutoHidePluginTests extends Test {

	private var tween:GTween;

	public function setupClass():Void
	{
		AutoHidePlugin.install();
	}

	public function teardownClass():Void
	{
		// other tests might be affected by this plugin's properties
		// so disable the plugin by default when we're done testing it
		AutoHidePlugin.enabled = false;
	}
	
	public function teardown():Void
	{
		if (tween != null)
		{
			tween.paused = true;
			tween = null;
		}
	}

	public function testVisibleProperty():Void
	{
		#if (flash || openfl)
		var shape = new Shape();
		#else
		var shape = {alpha: 1.0, visible: true};
		#end
		tween = new GTween(shape, 0.5, {alpha:0}, null, {AutoHideEnabled: true});

		Assert.equals(1, shape.alpha);
		Assert.isTrue(shape.visible);

		tween.position = 0.5 * tween.duration;
		Assert.equals(0.5, shape.alpha);
		Assert.isTrue(shape.visible);

		tween.position = tween.duration;
		Assert.equals(0.0, shape.alpha);
		Assert.isFalse(shape.visible);
	}

	public function testWithDefaultAutoHideEnabled():Void
	{
		#if (flash || openfl)
		var shape = new Shape();
		#else
		var shape = {alpha: 1.0, visible: true};
		#end
		tween = new GTween(shape, 0.5, {alpha:0});

		Assert.equals(1, shape.alpha);
		Assert.isTrue(shape.visible);

		tween.position = 0.5 * tween.duration;
		Assert.equals(0.5, shape.alpha);
		Assert.isTrue(shape.visible);

		tween.position = tween.duration;
		Assert.equals(0.0, shape.alpha);
		Assert.isFalse(shape.visible);
	}

	public function testWithAutoHideEnabledSetToFalse():Void
	{
		#if (flash || openfl)
		var shape = new Shape();
		#else
		var shape = {alpha: 1.0, visible: true};
		#end
		tween = new GTween(shape, 0.5, {alpha:0}, null, {AutoHideEnabled: false});

		Assert.equals(1, shape.alpha);
		Assert.isTrue(shape.visible);

		tween.position = 0.5 * tween.duration;
		Assert.equals(0.5, shape.alpha);
		Assert.isTrue(shape.visible);

		tween.position = tween.duration;
		Assert.equals(0.0, shape.alpha);
		Assert.isTrue(shape.visible);
	}
}