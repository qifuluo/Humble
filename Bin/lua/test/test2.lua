require("init")
require("macros")
local ws = require("ws")
local httpd = require("httpd")
local humble = require("humble")

function initTask()
	
end

function destroyTask()
	
end

local function wsEcho2(sock, sockType, netMsg)    
	ws.binaryFrame(sock, 2000, "wsEcho2 return.")
end
regIProto(2000, wsEcho2)

--httpd �yԇ
local function echo2(sock, sockType, strMethod, tUrl, tHead, pszBody)
	print(strMethod)	
	table.print(tUrl)
	table.print(tHead)
	print(pszBody)
	
	httpd.Response(sock, 200, nil, "echo2 server return")
end
regHttpdProto("/echo2", echo2)

--rpc ����
local function Add(a, b)
	return a + b
end
regRPC("Add", Add)

local function String()
	return "only string"
end
regRPC("String", String)

g_strAttr = ""
local function SetAttr(strAttr)
    print("--------------RPC SetAttr--------------")
    print(strAttr)
	g_strAttr = strAttr
end
regRPC("SetAttr", SetAttr)
