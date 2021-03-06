package remoting;

import js.Node;

import org.transition9.util.Assert;

import remoting.buildInterfaceSupport.BuiltRemotingService;
import remoting.buildInterfaceSupport.RemotingManager;

using Lambda;

using StringTools;

/**
 * Serialization tests
 */
class RemotingTest 
{
	public function new() 
	{
	}
	
	@Before
	public function setup (cb :Void->Void) :Void
	{
		cb();
	}
	
	@After
	public function tearDown (cb :Void->Void) :Void
	{
		cb();
	}
	
	/**
	  * Make sure the interface has all the methods in the remoting
	  * class with a @remote metadata label.
	  */
	@Test
	public function testBuildingRemotingInterface():Void
	{
		var meta = haxe.rtti.Meta.getFields(RemotingManager);
		Assert.isNotNull(meta);
		var totalRemotingFields = 0;
		for (fieldName in Type.getInstanceFields(RemotingManager)) {
			if (Reflect.hasField(meta, fieldName) && Reflect.hasField(Reflect.field(meta, fieldName), "remote")) {
				Assert.isTrue(Type.getInstanceFields(BuiltRemotingService).has(fieldName));
				totalRemotingFields++;
			}
		}
		Assert.isTrue(totalRemotingFields == 2);
	}
}
