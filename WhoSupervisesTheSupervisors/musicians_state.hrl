-record(state, {
          role,
          skill = good :: atom(),
          name = <<"">> :: binary()
}).

-define(DELAY, 700).
