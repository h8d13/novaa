-- `__` pragmas: per-file keyword/identifier aliases, and the rebindable marker.
-- Aliases are a pre-scan rewrite (alias -> target) applied before tokenizing.
local E = require("tests/eval")

local function eq(src, expected, label)
	local got = E.run(src)
	if got ~= expected then
		error(string.format("%s: expected %q, got %q", label, expected, got))
	end
end

-- keyword aliases: f -> fn, r -> return
eq(
	[[
  __fn     = f
  __return = r
  f int main() { r 41 + 1 }
]],
	42,
	"keyword alias f/r"
)

-- non-keyword target stays an identifier rewrite (degrades to a rename),
-- so it is safe even when the alias letter is reused as a variable name
eq(
	[[
  __int = i
  fn int main() { i n = 5; return n }
]],
	5,
	"type-name alias i -> int"
)

-- the marker itself is rebindable: __pragma = $$, then $$ is the marker
eq(
	[[
  __pragma = $$
  $$fn     = f
  $$return = r
  f int main() { r 7 }
]],
	7,
	"rebound marker $$"
)

-- `pg` is the short spelling of the rebind verb
eq(
	[[
  __pg     = $$
  $$return = r
  fn int main() { r 11 }
]],
	11,
	"pg rebinds the marker"
)

-- a single-char marker works too
eq(
	[[
  __pragma = @
  @return = r
  fn int main() { r 9 }
]],
	9,
	"single-char marker @"
)

-- a directive may carry a trailing // comment
eq(
	[[
  __fn     = f   // function
  __return = r   // return
  f int main() { r 3 }
]],
	3,
	"trailing comment on directives"
)

-- guard survives a rebound marker: an alias may not be an existing keyword
if not E.fails([[
  __pragma = $$
  $$return = if
  fn int main() { return 0 }
]]) then
	error("shadow guard did not fire under rebound marker")
end

print("ok")
