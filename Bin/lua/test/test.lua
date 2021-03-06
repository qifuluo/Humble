require("init")
local humble = require("humble")

function initTask()
	humble.debugServer("0.0.0.0", 16001)
	humble.rpcServer("0.0.0.0", 16002)
	humble.httpServer("0.0.0.0", 8080)
	humble.wsServer("0.0.0.0", 16100)
    humble.rpcServer("0.0.0.0", 17000)
	
	humble.regTask("test/test1.lua", "test1", 1024 * 10)
	humble.regTask("test/test2.lua", "test2", 1024 * 10)
    humble.regTask("test/test4.lua", "test4", 1024 * 10)
end

function destroyTask()
	
end

function testUnRegTask()
	humble.unRegTask("test3")
end

function testRegTask()
	humble.regTask("test/test3.lua", "test3", 1024)
	regDelayEv(1000, testUnRegTask)
end
regDelayEv(2000, testRegTask)
