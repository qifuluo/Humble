
require("macros")
require("logicmacro")
local utile = require("utile")
local humble = require("humble")
local httpd = require("httpd")
local websock = require("websock")
local mqtt = require("mqtt")
local def = require("def")
local tcp1 = require("tcp1")
local tcp2 = require("tcp2")
local netdisp = require("netdisp")
local table = table
local string = string
local pChan = g_pChan

if not g_pBinary then
    g_pBinary = CBinary()
end
local pBinary = g_pBinary

if not g_NetDisp then
	g_NetDisp = netdisp:new("echo1")
end

--任务初始化
function initTask()
    
end

local function echo1(sock, session, pack)
	local pWBinary = httpd.Response(200, "echo1 return")
    humble.sendB(sock, session, pWBinary)
end
g_NetDisp:regNetEvent("/echo1", echo1)

--有新任务执行
function runTask()
    local varRecv = pChan:Recv()
    local evType, proto, msg = utile.unPack(varRecv)
	if evType == EnevtType.TcpRead then
		local sock,session,pack = table.unpack(msg)
		g_NetDisp:onNetEvent(proto, sock, session, pack)
	end	
end

--任务销毁
function destroyTask()

end