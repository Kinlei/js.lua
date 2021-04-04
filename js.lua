local getmeta = getrawmetatable;
local StarterGui = game:GetService("StarterGui");
local MarketplaceService = game:GetService("MarketplaceService");
local JSLuaIcon = 6603478410;

function GetImageID(DecalID)
	local Result = game:HttpGet("https://rbxdecal.glitch.me/"..DecalID);
	return "rbxassetid://"..Result;
end;

JSLuaIcon = GetImageID(JSLuaIcon);

function SendNotification(Config)
	Config.Icon = JSLuaIcon;
	StarterGui:SetCore("SendNotification", Config);
end;

function c(Closure)
    return newcclosure(Closure);
end;

function SearchToInsensitive(Search)
    local Build = "";
    local Chars = string.split(Search, "");
    for _, Char in next, Chars do
        Build = Build.."["..string.upper(Char)..string.lower(Char).."]";
    end;
    return Build;
end;

JsLuaFunctions = {
    prototype = c(function()
        return setmetatable({}, {
            __newindex = function(t, k, v)
                rawset(JsLuaFunctions, k, (typeof(v) == "function") and c(function(...) return function(...) return v(...) end end) or c(function() return v end));
            end;
        });
    end);
    fromCharCode = c(function(i)
        return string.char(i);
    end);
	length = c(function(i)
		return string.len(i);
	end);
	toLowerCase = c(function(i)
		return string.lower(i);
	end);
	toUpperCase = c(function(i)
	    return string.upper(i);
	end);
	indexOf = c(function(i)
	   return function(v, r)
	       local s = string.find(i, v, r or 0);
	       return s;
	   end;
	end);
	lastIndexOf = c(function(i)
	    return function(v, r)
	        local t = {};
	        local f = string.find(i, v, r or 0);
	        if (f) then
	            table.insert(t, f);
	            local f2 = f;
	            repeat
	                f2 = string.find(i, v, f2 + 1);
	                table.insert(t, f2);
	            until f2 == nil;
	            return t[#t];
	        end;
	    end;
	end);
	search = c(function(i)
	    return function(v)
	        local s = string.find(i, v);
	        return s;
	    end;
	end);
	slice = c(function(i)
	    return function(v, r)
	        v = v or 1;
	        return string.sub(i, v, r or string.len(i));
	    end;
	end);
	substring = c(function(i)
	    return function(v, r)
	        v = v or 1;
	        return string.sub(i, v, r or string.len(i));
	    end;
	end);
	substr = c(function(i)
	    return function(v, r)
	        v = v or 1;
	        return string.sub(i, v, (v - 1) + (r or (string.len(i) - v)));
	    end;
	end);
	replace = c(function(i)
	    return function(v, r)
	        local insensitive = false;
	        local global = false;
	        local case = string.find(v, "/i");
	        local case2 = string.find(v, "/g");
	        local c = 0;
	        if (case) then
	            insensitive = (case == (string.len(v) - 3)) or (case == (string.len(v) - 1));
	            if (insensitive) then
	                c = c + 2;
	            end;
	        end;
	        if (case2) then
	            global = (case2 == (string.len(v) - 3)) or (case2 == (string.len(v) - 1));
	            if (global) then
	                c = c + 2;    
	            end;
	        end;
	        v = string.sub(v, 1, string.len(v) - c);
	        local o = (global and string.len(i) or 1);
	        local res;
            a = (insensitive) and (SearchToInsensitive(v)) or v;
            f = function(w)
                return r or w;
            end;
            res = string.gsub(i, a, f, o);
	        return res;
	    end;
	end);
	concat = c(function(i)
	    return function(...)
	        local nt = {i, ...};
	        return table.concat(nt, "");
	    end;
	end);
	trim = c(function(i)
	    return function()
	        local s = string.find(i, "[^%s]");
	        local r = string.sub(i, s, string.len(i));
	        for k = 1, string.len(r) do
	            local c = string.sub(r, -k);
	            if (string.match(c, "[^%s]")) then
	                r = string.sub(r, 1, string.len(r) - (k - 1));
	                break;
	            end;
	        end;
	        return r;
	    end;
	end);
	padStart = c(function(i)
	    return function(s, r)
	        s = s - (string.len(i));
	        if (s > 0) then
	            for k = 1, s do
	                i = r .. i;
	            end;
	        end;
	        return i;
	    end;
	end);
	padEnd = c(function(i)
	    return function(s, r)
	        s = s - (string.len(i));
	        if (s > 0) then
	            for k = 1, s do
	                i = i .. r;
	            end;
	        end;
	        return i;
	    end;
	end);
	charAt = c(function(i)
	    return function(p)
	        return string.sub(i, p, p);
	    end;
	end);
	charCodeAt = c(function(i)
	    return function(p)
	        return string.byte(string.sub(i, p, p));
	    end;
	end);
	endsWith = c(function(i)
	    return function(s)
	        return (string.sub(i, string.len(i) + 1 - string.len(s), string.len(i)) == s);
	    end;
	end);
	includes = c(function(i)
	    return function(s)
	        return (string.find(i, s) and true or false);
	    end;
	end);
	localeCompare = c(function(i)
	    return function(c)
	        if (i == c) then
	            return 0;
	        end;
	        local t = {i, c};
	        table.sort(t, function(a, b)
	            return a < b;
	        end);
	        local i1, i2 = table.find(t, i), table.find(t, c);
	        return (i1 < i2) and -1 or 1;
	    end;
	end);
	match = c(function(i)
	    return function(v)
	        local insensitive = false;
	        local global = false;
	        local case = string.find(v, "/i");
	        local case2 = string.find(v, "/g");
	        local c = 0;
	        if (case) then
	            insensitive = (case == (string.len(v) - 3)) or (case == (string.len(v) - 1));
	            if (insensitive) then
	                c = c + 2;
	            end;
	        end;
	        if (case2) then
	            global = (case2 == (string.len(v) - 3)) or (case2 == (string.len(v) - 1));
	            if (global) then
	                c = c + 2;    
	            end;
	        end;
	        v = string.sub(v, 1, string.len(v) - c);
	        local o = (global and string.len(i) or 1);
	        local res;
            a = (insensitive) and (SearchToInsensitive(v)) or v;
            f = function(w)
                return r;
            end;
            _, res = string.gsub(i, a, f, o);
	        return table.create(res, v);
	    end;
	end);
	startsWith = c(function(i)
	    return function(c)
	        return (string.sub(i, 1, string.len(c)) == c);
	    end;
	end);
	valueOf = c(function(i)
	    return function()
	        return i;
	    end;
	end);
};

function NewType(Type)
    local Types = {
        table = Wrap({}),
        number = 0,
        string = ""
    }
    return Types[Type];
end;

JsArrayFunctions = {
    prototype = c(function()
        return setmetatable({}, {
            __newindex = function(t, k, v)
                rawset(JsArrayFunctions, k, (typeof(v) == "function") and c(function(...) return function(...) return v(...) end end) or c(function() return v end));
            end;
        });
    end);
    length = c(function(i)
		return #i;
    end);
    push = c(function(i)
        return function(...)
            local ToInsert = {...};
            table.foreach(ToInsert, function(k, v)
                table.insert(i, v);
            end);
            return i;
        end;
    end);
    pop = c(function(i)
        return function()
            return table.remove(i);
        end;
    end);
    shift = c(function(i)
        return function()
            return table.remove(i, 1);
        end;
    end);
    unshift = c(function(i)
        return function(n)
            return table.insert(i, 1, n);
        end;
    end);
    indexOf = c(function(i)
        return function(e)
            return table.find(i, e);
        end;
    end);
    splice = c(function(i)
        return function(s, e)
            local rs = math.min(s, e);
            local re = math.max(s, e);
            local sh = 0;
            local ri = {};
            for k = rs, re, 1 do
                local di = table.remove(i, k - sh);
                table.insert(ri, di);
                sh = sh + 1;
            end;
            return ri;
        end;
    end);
    slice = c(function(i)
        return function()
            local nt = {};
            setmetatable(nt, getmeta(i));
            for k, v in next, i do
                nt[k] = v;
            end;
            return nt;
        end;
    end);
    keys = c(function(i)
        return function()
            local kt = {};
            table.foreach(i, function(k, _)
                table.insert(kt, k);
            end);
            return setmetatable(kt, getmeta(i));
        end;
    end);
    from = c(function(i)
        return function(e, f)
            if (typeof(e) == "string") then
                return setmetatable(string.split(e, ""), getmeta(i));
            else
                if (typeof(e) == "table") then
                    local nt = {};
                    table.foreach(e, function(k, v)
                        table.insert(nt, f(v));
                    end);
                    return setmetatable(nt, getmeta(i));
                end;
            end;
        end;
    end);
    isArray = c(function(i)
        return function(e)
            return (typeof(e) == "table");
        end;
    end);
    entries = c(function(i)
        return function()
            local NewIterator = {};
            local Pointer = 0;
            function NewIterator.next()
                Pointer = Pointer + 1;
                return {value = rawget(i, Pointer)};
            end;
            return NewIterator;
        end;
    end);
    every = c(function(i)
        return function(f)
            for _, v in next, i do
                if (not f(v)) then
                    return false;
                end;
            end;
            return true;
        end;
    end);
    fill = c(function(i)
        return function(v, s, e)
            local rv = v;
            local s = s or 1;
            local e = e or #i;
            local rs = math.min(s, e);
            local re = math.max(s, e);
            for k = rs, re, 1 do
                rawset(i, k, rv);
            end;
            return i;
        end;
    end);
    filter = c(function(i)
        return function(f)
            local nt = {};
            for _, v in next, i do
                if (f(v)) then
                    table.insert(nt, v);
                end;
            end;
            return setmetatable(nt, getmeta(i));
        end;
    end);
    find = c(function(i)
        return function(f)
            for _, v in next, i do
                if (f(v)) then
                    return v;
                end;
            end;
            return nil;
        end;
    end);
    findIndex = c(function(i)
        return function(f)
            for k, v in next, i do
                if (f(v)) then
                    return k;
                end;
            end;
            return -1;
        end;
    end);
    includes = c(function(i)
        return function(e)
            return table.find(i, e) and true or false;
        end;
    end);
    join = c(function(i)
        return function(s)
            return table.concat(i, s);
        end;
    end);
    map = c(function(i)
        return function(f)
            local nt = {};
            table.foreach(i, function(k, v)
                nt[k] = f(v);
            end);
            return setmetatable(nt, getmeta(i));
        end;
    end);
    reduce = c(function(i)
        return function(f, s, k)
            local a = s and NewType(s) or NewType(typeof(i[1]));
            for p, v in next, i do
                if (p >= (k or 1)) then
                    a = f(a, v);
                end;
            end;
            return a;
        end;
    end);
    reduceRight = c(function(i)
        return function(f, s, k)
            local a = s or NewType(typeof(i[#i]));
            for p = #i, 1, -1 do
                local v = i[p];
                if (p <= (k or #i)) then
                    a = f(a, v);
                end;
            end;
            return a;
        end;
    end);
    concat = c(function(i)
        return function(t)
            local nt = {unpack(i)};
            table.foreach(t, function(_, v)
                table.insert(nt, v);
            end);
            return setmetatable(nt, getmeta(i));
        end;
    end);
    reverse = c(function(i)
        return function()
            local nt = i.slice();
            for p = 1, math.floor(#i/2) do
                local k = #i - p + 1;
                nt[p], nt[k] = i[k], i[p];
            end;
            return setmetatable(nt, getmeta(i));
        end;
    end);
    some = c(function(i)
        return function(f)
            for _, v in next, i do
                if (f(v)) then
                    return true;
                end;
            end;
            return false;
        end;
    end);
    toString = c(function(i)
        return function()
            return table.concat(i, ",");
        end;
    end);
};

function SetupJsLua()
	local StringObjectTable = string;
	local GameMetaTable = getmeta(game);
	local StringMetaTable = getmeta("");
	setreadonly(StringObjectTable, false);
	setreadonly(GameMetaTable, false);
	setreadonly(StringMetaTable, false);
	getgenv().jslua = TableObjectTable;
	local OldIndex = StringMetaTable.__index;
	if (StringObjectTable) then
		for FuncName, Function in next, JsLuaFunctions do
			StringObjectTable[FuncName] = Function;
		end;
	end;
	StringMetaTable.__index = function(...)
	    local Args = {...};
	    local StringToPass = Args[1];
	    local FunctionToPass = Args[2];
	    if (checkcaller()) then
	        if (typeof(FunctionToPass) == "number") then
	            return JsLuaFunctions.charAt(StringToPass)(FunctionToPass);
	        end;
		    if (FunctionToPass) then
				local JsLuaFunction = JsLuaFunctions[FunctionToPass];
				if (JsLuaFunction) then
					return JsLuaFunction(StringToPass);
				end;
		    end;
	    end;
	    return string[FunctionToPass];
	end;
	getgenv().Wrap = function(Array)
        local Array = Array or {};
        function WrapEntireTable(t)
            Wrap(t);
            for _, v in next, t do
                if (typeof(v) == "table") then
                    WrapEntireTable(v);
                end;
            end;
        end;
        for _, v in next, Array do
            if (typeof(v) == "table") then
                WrapEntireTable(v);
            end;
        end;
        setmetatable(Array, {
            __index = function(t, k)
                if (typeof(k) == "number") then
                    return rawget(t, k);
                end;
                local JsFunction = rawget(JsArrayFunctions, k);
                if (JsFunction) then
                    return JsFunction(t);
                else
                    local NormalFunction = rawget(table, k);
                    if (NormalFunction) then
                        return function(...)
                            return NormalFunction(t, ...);
                        end;
                    else
                        return nil;
                    end;
                end;
            end;
            __tostring = function(t)
                local BuildString = "\n{\n\t";
                for k, v in next, t do
                    BuildString = BuildString..k..": ";
                    local IsString = (typeof(v) == "string");
                    local IsLastElement = (k == #t);
                    if (IsString) then
                        BuildString = BuildString..'"';
                    end;
                    BuildString = BuildString..tostring(v);
                    if (IsString) then
                        BuildString = BuildString..'"';
                    end;
                    if (not IsLastElement) then
                        BuildString = BuildString..",\n\t";
                    end;
                end;
                BuildString = BuildString.."\n}"
                return BuildString;
            end;
        })
        return Array;
    end;
end;

if (getmeta) then
	SendNotification({
		Title = "js.lua",
		Text = "Loading libraries.",
		Duration = 1
	});
	SetupJsLua();
else
	SendNotification({
		Title = "js.lua",
		Text = "Your exploit does not support metatables.",
		Duration = 1
	});
end;