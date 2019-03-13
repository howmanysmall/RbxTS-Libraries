--[[
	Camera Plus
	http://sleitnick.github.io/CameraPlus/
	
		Version 1.0.9
		March 25, 2014
		Created by Crazyman32
		
		Release:		   April 3, 2014	 [v.1.0.5]
		Update:			   April 17, 2014	 [v.1.0.7]
		Update:			   February 24, 2015 [v.1.0.8]
		TypeScript Update: March 2, 2019 	 [v.1.0.9]
		
	
	Camera Plus is an API wrapper for the default Camera
	object in ROBLOX to give additional support for
	doing tween animations with the camera.
	
	I made this API because I got tired of always writing
	custom camera cutscene systems for every new game I
	made. It was time to set a standard for my code that
	was unified! I had a lot of fun putting this together
	and am happy to share it with you all. I hope to see
	awesome camera cutscene animations spawn from how you
	guys use this!
	
	----
	This API uses Robert Penner's easing equations for
	interpolation calculations. The licensing information
	and other necessary credit is provided within the
	"Easing" ModuleScript parented within this ModuleScript.
	----
	
	Contact me on Twitter: @CM32Roblox
	
	HOW TO USE
		Please refer to my API Reference for CameraPlus:
			http://sleitnick.github.io/CameraPlus/
--]]

-- Services & Modules
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local EasingFunctions = require(script.EasingFunctions)

local CurrentCamera = Workspace.CurrentCamera
local RenderStepped = RunService.RenderStepped
local LocalPlayer = Players.LocalPlayer
local LookAt = nil

-- Lua Functions
local CFrame_new = CFrame.new
local tick = tick

-- :: Functions
local Lerp = Vector3.new().Lerp

-- Constants
local CAMTYPE_SCRIPTABLE = Enum.CameraType.Scriptable.Value
local CAMTYPE_CUSTOM = Enum.CameraType.Custom.Value
local CLASS_NAME = "CameraPlus"

-- Script Functions
local function ReadOnly(Table)
	local NewTable = { }
	local NewMeta = { }
	NewMeta.__metatable = true
	NewMeta.__index = Table
	function NewMeta:__newindex() error("Cannot add to read-only table.", 0) end
	return setmetatable(NewTable, NewMeta)
end

local function CFrameUnpack(CFrame, LookDistance)
	local Position = CFrame.Position
	local Focus = Position + (CFrame.LookVector * (type(LookDistance) == "number" and LookDistance or 10))
	return Position, Focus
end

local function RenderWait() RenderStepped:Wait() end

local function Tween(EasingFunction, Duration, CallbackFunction)
	local StartTime = tick()
	local CurrentTime = 0
	local Ratio = 0
	local RenderStep = RenderWait -- Apparently this is faster?
	while CurrentTime < Duration do
		Ratio = EasingFunction(CurrentTime, 0, 1, Duration)
		CurrentTime = tick() - StartTime
		CallbackFunction(Ratio)
		RenderStep()
	end
	CallbackFunction(1)
end

-- Main
local CameraPlus = { }
local CameraAPI = { }
local CameraMeta = { }

CameraAPI.Ease = (function()
	local In, Out, InOut, OutIn = { }, { }, { }, { }
	for Name, Function in next, EasingFunctions do
		if not Name:find("InOut") then
			In[Name] = Function
			Out[Name] = Function
			InOut[Name] = Function
			OutIn[Name] = Function
		else
			local Type, FunctionName = Name:match("^(InOut)(.+)")
			if not Type or not FunctionName then Type, FunctionName = Name:match("^(In)(.+)") end
			if not Type or not FunctionName then Type, FunctionName = Name:match("^(Out)(.+)") end
			if not Type or not FunctionName then Type, FunctionName = Name:match("^(OutIn)(.+)") end

			if Type == "InOut" then
				InOut[FunctionName] = Function
			elseif Type == "In" then
				In[FunctionName] = Function
			elseif Type == "Out" then
				Out[FunctionName] = Function
			elseif Type == "OutIn" then
				OutIn[FunctionName] = Function
			end
		end
	end

	return ReadOnly {
		In = ReadOnly(In),
		Out = ReadOnly(Out),
		InOut = ReadOnly(InOut),
		OutIn = ReadOnly(OutIn)
	}
end)()

-- One-liner functions
function CameraAPI:getPosition() return CurrentCamera.CFrame.Position end
function CameraAPI:setFOV(FOV) CurrentCamera.FieldOfView = FOV end
function CameraAPI:getFOV() return CurrentCamera.FieldOfView end
function CameraAPI:incrementFOV(Delta) CurrentCamera.FieldOfView = CurrentCamera.FieldOfView + Delta end
function CameraAPI:setRoll(Roll) CurrentCamera:SetRoll(Roll) end
function CameraAPI:getRoll() return CurrentCamera:GetRoll() end
function CameraAPI:incrementRoll(Delta) CurrentCamera:SetRoll(CurrentCamera:GetRoll() + Delta) end

CameraAPI.GetPosition = CameraAPI.getPosition
CameraAPI.SetFOV = CameraAPI.setFOV
CameraAPI.GetFOV = CameraAPI.getFOV
CameraAPI.IncrementFOV = CameraAPI.incrementFOV
CameraAPI.SetRoll = CameraAPI.setRoll
CameraAPI.GetRoll = CameraAPI.getRoll
CameraAPI.IncrementRoll = CameraAPI.incrementRoll

function CameraAPI:setPosition(Position)
	if CurrentCamera.CameraType == CAMTYPE_SCRIPTABLE then
		LookAt = LookAt or CurrentCamera.CFrame.Position + (CurrentCamera.CFrame.LookVector * 5)
		CurrentCamera.CFrame = CFrame_new(Position, LookAt)
	else
		LookAt = LookAt or CurrentCamera.Focus.Position
		CurrentCamera.CFrame = CFrame_new(Position)
		CurrentCamera.Focus = CFrame_new(LookAt)
	end
end
CameraAPI.SetPosition = CameraAPI.setPosition

function CameraAPI:setFocus(Focus)
	LookAt = Focus
	self:setPosition(self:getPosition())
end
CameraAPI.setFocus = CameraAPI.setFocus

function CameraAPI:setView(Position, Focus)
	LookAt = Focus
	self:setPosition(Position)
end
CameraAPI.SetView = CameraAPI.setView

function CameraAPI:tween(StartCFrame, EndCFrame, Duration, EasingFunction)
	CurrentCamera.CameraType = CAMTYPE_SCRIPTABLE
	local StartPosition, StartLook = CFrameUnpack(StartCFrame)
	local EndPosition, EndLook = CFrameUnpack(EndCFrame)
	local CurrentPosition, CurrentLook = StartPosition, StartLook

	local function Callback(Ratio)
		CurrentPosition = Lerp(StartPosition, EndPosition, Ratio)
		CurrentLook = Lerp(StartLook, EndLook, Ratio)
		CurrentCamera.CFrame = CFrame_new(CurrentPosition, CurrentLook)
	end

	Tween(EasingFunction, Duration, Callback)
end
CameraAPI.Tween = CameraAPI.tween

function CameraAPI:tweenTo(EndCFrame, Duration, EasingFunction)
	CurrentCamera.CameraType = CAMTYPE_SCRIPTABLE
	self:tween(CurrentCamera.CFrame, EndCFrame, Duration, EasingFunction)
end
CameraAPI.TweenTo = CameraAPI.tweenTo

function CameraAPI:tweenToPlayer(Duration, EasingFunction)
	local Humanoid, WalkSpeed = LocalPlayer.Character:FindFirstChild("Humanoid")
	if Humanoid then WalkSpeed = Humanoid.WalkSpeed Humanoid.WalkSpeed = 0 end
	local Head = LocalPlayer.Character:FindFirstChild("Head")
	local EndCFrame = CFrame_new(Head.Position - (Head.CFrame.LookVector * 10), Head.Position)
	self:tweenTo(EndCFrame, Duration, EasingFunction)
	CurrentCamera.CameraType = CAMTYPE_CUSTOM
	CurrentCamera.CameraSubject = LocalPlayer.Character
	if Humanoid then Humanoid.WalkSpeed = WalkSpeed end
end
CameraAPI.TweenToPlayer = CameraAPI.tweenToPlayer

function CameraAPI:tweenFOV(StartFOV, EndFOV, Duration, EasingFunction)
	local FieldOfView = StartFOV
	local DiffFOV = EndFOV - StartFOV
	local function Callback(Ratio)
		FieldOfView = StartFOV + (DiffFOV * Ratio)
		CurrentCamera.FieldOfView = FieldOfView
	end
	Tween(EasingFunction, Duration, Callback)
end
CameraAPI.TweenFOV = CameraAPI.tweenFOV

function CameraAPI:tweenToFOV(EndFOV, Duration, EasingFunction)
	self:tweenFOV(CurrentCamera.FieldOfView, EndFOV, Duration, EasingFunction)
end
CameraAPI.TweenToFOV = CameraAPI.tweenToFOV

function CameraAPI:tweenRoll(StartRoll, EndRoll, Duration, EasingFunction)
	CurrentCamera.CameraType = CAMTYPE_SCRIPTABLE
	local Roll = StartRoll
	local DiffRoll = EndRoll - StartRoll
	local function Callback(Ratio)
		Roll = StartRoll + (DiffRoll * Ratio)
		CurrentCamera:SetRoll(Roll)
	end
	Tween(EasingFunction, Duration, Callback)
end
CameraAPI.TweenRoll = CameraAPI.tweenRoll

function CameraAPI:tweenToRoll(EndRoll, Duration, EasingFunction)
	self:tweenRoll(CurrentCamera:GetRoll(), EndRoll, Duration, EasingFunction)
end
CameraAPI.TweenToRoll = CameraAPI.tweenToRoll

function CameraAPI:tweenAll(StartCFrame, EndCFrame, StartFOV, EndFOV, StartRoll, EndRoll, Duration, EasingFunction)
	CurrentCamera.CameraType = CAMTYPE_SCRIPTABLE
	local StartPosition, StartLook = CFrameUnpack(StartCFrame)
	local EndPosition, EndLook = CFrameUnpack(EndCFrame)
	local Position, Look = StartPosition, StartLook
	local FieldOfView, DiffFOV = StartFOV, EndFOV - StartFOV
	local Roll, DiffRoll = StartRoll, EndRoll - StartRoll
	
	local function Callback(Ratio)
		Position = Lerp(StartPosition, EndPosition, Ratio)
		Look = Lerp(StartLook, EndLook, Ratio)
		FieldOfView = StartFOV + (DiffFOV * Ratio)
		Roll = StartRoll + (DiffRoll * Ratio)
		CurrentCamera.CFrame = CFrame_new(Position, Look)
		CurrentCamera.FieldOfView = FieldOfView
		CurrentCamera:SetRoll(Roll)
	end
	Tween(EasingFunction, Duration, Callback)
end
CameraAPI.TweenAll = CameraAPI.tweenAll

function CameraAPI:tweenToAll(EndCFrame, EndFOV, EndRoll, Duration, EasingFunction)
	CurrentCamera.CameraType = CAMTYPE_SCRIPTABLE
	self:tweenAll(
		CurrentCamera.CFrame, EndCFrame,
		CurrentCamera.FieldOfView, EndFOV,
		CurrentCamera:GetRoll(), EndRoll,
		Duration, EasingFunction
	)
end
CameraAPI.TweenToAll = CameraAPI.tweenToAll

function CameraAPI:interpolate(EndPosition, EndFocus, Duration)
	self:tweenTo(CFrame_new(EndPosition, EndFocus), Duration, self.Ease.InOut.Sine)
end
CameraAPI.Interpolate = CameraAPI.interpolate

function CameraAPI:isA(ClassName)
	return ClassName == CLASS_NAME or CurrentCamera:IsA(ClassName)
end
CameraAPI.IsA = CameraAPI.isA

CameraMeta.__metatable = true
function CameraMeta:__eq(Other) return self == Other or CurrentCamera == Other end
function CameraMeta:__index(Index) return CameraAPI[Index] or CurrentCamera[Index] end
function CameraMeta:__newindex(Index, Value)
	if CameraAPI[Index] then
		error("Cannot change CameraPlus API.", 0)
	else
		CurrentCamera[Index] = Value
	end
end
setmetatable(CameraPlus, CameraMeta)

return ReadOnly(CameraPlus)
