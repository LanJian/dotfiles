local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local conds = require("luasnip.extras.conditions")

-- Helper functions

local function random_ip()
	return table.concat({
		math.random(1, 255),
		math.random(1, 255),
		math.random(1, 255),
		math.random(1, 255),
	}, ".")
end

local function random_ipv6()
	local parts = {}
	for _ = 1, 6 do
		parts[#parts + 1] = string.format("%x", math.random(0, 65535))
	end
	return "2001:face:" .. table.concat(parts, ":")
end

local function random_path(length)
	length = length or 3
	local components = { "foo", "bar", "baz", "herp", "derp", "hoof", "doof", "hello", "world" }
	local shuffled = {}
	for _, v in ipairs(components) do
		shuffled[#shuffled + 1] = v
	end
	for idx = #shuffled, 2, -1 do
		local j = math.random(1, idx)
		shuffled[idx], shuffled[j] = shuffled[j], shuffled[idx]
	end
	local result = {}
	for idx = 1, math.min(length, #shuffled) do
		result[#result + 1] = shuffled[idx]
	end
	return "/" .. table.concat(result, "/")
end

local function filename_to_classname()
	local fn = vim.fn.expand("%:t")
	local name = fn:gsub("%..*py$", "")
	local parts = {}
	for part in name:gmatch("[^_]+") do
		parts[#parts + 1] = part:sub(1, 1):upper() .. part:sub(2)
	end
	return table.concat(parts)
end

local lb = conds.line_begin

return {
	-- class
	s("class", {
		t({ "import ir_test.util.common_info_mixin", "", "", "class " }),
		d(1, function()
			return sn(nil, { i(1, filename_to_classname()) })
		end),
		t("(ir_test.util.common_info_mixin.CommonInfoMixin):"),
		t({ "", "\t" }),
		i(2, "pass"),
		i(0),
	}, { condition = lb, show_condition = lb, desc = "make a class" }),

	-- fix
	s("fix", {
		t({ "@pytest.fixture", "def " }),
		i(1, "FIXTURE_NAME"),
		t("("),
		i(0),
		t(") -> "),
		i(2, "None"),
		t(":"),
		t({ "", "\t" }),
		i(3, "pass"),
		t({ "", "" }),
	}, { condition = lb, show_condition = lb, desc = "fixture function" }),

	-- afix
	s("afix", {
		t({ "@pytest.fixture(autouse=True)", "def " }),
		i(1, "FIXTURE_NAME"),
		t("("),
		i(0),
		t(") -> "),
		i(2, "None"),
		t(":"),
		t({ "", "\t" }),
		i(3, "pass"),
		t({ "", "" }),
	}, { condition = lb, show_condition = lb, desc = "autouse fixture function" }),

	-- async fix
	s("async fix", {
		t({ "@pytest_asyncio.fixture", "async def " }),
		i(1, "FIXTURE_NAME"),
		t("("),
		i(0),
		t(") -> "),
		i(2, "None"),
		t(":"),
		t({ "", "\t" }),
		i(3, "pass"),
		t({ "", "" }),
	}, { condition = lb, show_condition = lb, desc = "asyncio fixture function" }),

	-- before_each
	s("before_each", {
		t({ "@pytest.fixture(autouse=True)", "def before_each(mocker: pytest_mock.MockerFixture) -> None:" }),
		i(0),
		t({ "", "\t" }),
		i(1, "DO_SOMETHING"),
		t({ "", "" }),
	}, { condition = lb, show_condition = lb, desc = "before_each fixture" }),

	-- sfix
	s("sfix", {
		t({ "@pytest.fixture(scope='session')", "def " }),
		i(1, "FIXTURE_NAME"),
		t("("),
		i(0),
		t(") -> "),
		i(2, "None"),
		t(":"),
		t({ "", "\t" }),
		i(3, "pass"),
		t({ "", "" }),
	}, { condition = lb, show_condition = lb, desc = "session scoped fixture function" }),

	-- desc
	s("desc", {
		t("def describe_"),
		i(1, "SOMETHING"),
		t("() -> None:"),
		i(0),
		t({ "", "\t" }),
		i(2, "pass"),
	}, { condition = lb, show_condition = lb, desc = "describe function" }),

	-- if context
	s("if context", {
		t("def if_"),
		i(1, "SOME_CONTEXT"),
		t("() -> None:"),
		i(0),
	}, { condition = lb, show_condition = lb, desc = "if context block" }),

	-- it test
	s("it test", {
		t("def it_"),
		i(1, "DOES_SOMETHING"),
		t("() -> None:"),
		i(0),
		t({ "", "    assert False" }),
	}, { condition = lb, show_condition = lb, desc = "it test block" }),

	-- async it test
	s("async it test", {
		t({ "@pytest.mark.asyncio", "async def it_" }),
		i(1, "DOES_SOMETHING"),
		t("() -> None:"),
		i(0),
		t({ "", "    assert False" }),
	}, { condition = lb, show_condition = lb, desc = "async it test block" }),

	-- patch (.*)  --  type "patch foo.bar.Baz" then expand
	s("patch (.*)", {
		t("patched = mocker.patch('"),
		f(function(_, snip)
			return snip.captures[1]
		end),
		t("', autospec=True)"),
		t({ "", "patched.return_value = " }),
		i(1, "RETURN_VALUE"),
		t({ "", "return patched" }),
		i(0),
	}, { regTrig = true, condition = lb, show_condition = lb, desc = "patch MATCH" }),

	-- opatch
	s("opatch", {
		t("mocker.patch.object("),
		i(1, "OBJECT"),
		t(', "'),
		i(2, "FUNCTION"),
		t('", autospec=True).return_value = '),
		i(3, "RETURN_VALUE"),
		i(0),
	}, { condition = lb, show_condition = lb, desc = "patch some object" }),

	-- fpatch
	s("fpatch", {
		t("@pytest.fixture"),
		i(5),
		t({ "", "def mocked_" }),
		i(1, "NAME"),
		t("(mocker"),
		i(4),
		t("):"),
		t({ "", "\tpatched = mocker.patch('" }),
		i(2, "FUNCTION"),
		t("', autospec=True)"),
		t({ "", "\tpatched.return_value = " }),
		i(3, "RETURN_VALUE"),
		t({ "", "\treturn patched" }),
		i(0),
	}, { condition = lb, show_condition = lb, desc = "fixture patch" }),

	-- fopatch
	s("fopatch", {
		t("@pytest.fixture"),
		i(5),
		t({ "", "def mocked_" }),
		d(7, function(args)
			return sn(nil, { i(1, args[1][1]) })
		end, { 2 }),
		t("(mocker, "),
		i(1, "OBJECT"),
		i(4),
		t("):"),
		t({ "", "\tpatched = mocker.patch.object(" }),
		d(6, function(args)
			return sn(nil, { i(1, args[1][1]) })
		end, { 1 }),
		t(", '"),
		i(2, "FUNCTION"),
		t("', autospec=True)"),
		t({ "", "\tpatched.return_value = " }),
		i(3, "RETURN_VALUE"),
		t({ "", "\treturn patched" }),
		i(0),
	}, { condition = lb, show_condition = lb, desc = "fixture object patch" }),

	-- comfail
	s("comfail", {
		t({ "@pytest.fixture", "def mocked_command_returncode():", "\treturn 1" }),
		i(0),
	}, { condition = lb, show_condition = lb, desc = "mock command failure" }),

	-- comfix
	s("comfix", {
		t("mocked_command, mocked_command_instance"),
		i(0),
	}, { desc = "command fixture args" }),

	-- asscom
	s("asscom", {
		t({ "mocked_command.assert_called_once_with(", "\t" }),
		i(1),
		t(")"),
		t({ "", "mocked_command_instance.run.assert_called_once_with()" }),
		i(0),
	}, { condition = lb, show_condition = lb, desc = "mocked command assertions" }),

	-- xfail
	s("xfail", {
		t('@pytest.mark.xfail(reason="'),
		i(1, "REASON"),
		t('")'),
		i(0),
	}, { condition = lb, show_condition = lb, desc = "mark as xfail" }),

	-- todo
	s("todo", {
		t("# TODO jackhxs "),
		f(function()
			return os.date("%Y-%m-%d")
		end),
		t(": "),
		i(1, "msg"),
	}, { desc = "todo" }),

	-- dnc
	s("dnc", {
		t("# DO NOT COMMIT"),
	}, { desc = "do not commit" }),

	-- fixme
	s("fixme", {
		t("# FIXME jackhxs "),
		f(function()
			return os.date("%Y-%m-%d")
		end),
		t(": "),
		i(1, "msg"),
	}, { desc = "fixme" }),

	-- ic
	s("ic", {
		t('__import__("icecream").ic('),
		i(1),
		t(")"),
	}, { desc = "icecream debug" }),

	-- rip
	s("rip", {
		f(function()
			return random_ip()
		end),
		i(0),
	}, { desc = "random ip" }),

	-- ris
	s("ris", {
		f(function()
			return random_ipv6()
		end),
		i(0),
	}, { desc = "random ipv6" }),

	-- rap
	s("rap", {
		f(function()
			return random_path()
		end),
		i(0),
	}, { desc = "random path" }),

	-- rap<N>  (e.g. rap5 for path of length 5)
	s("rap(%d+)", {
		f(function(_, snip)
			return random_path(tonumber(snip.captures[1]))
		end),
		i(0),
	}, { regTrig = true, desc = "random path of length n" }),
}
