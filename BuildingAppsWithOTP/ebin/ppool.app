{application, ppool,
 [{vsn, "1.0.0"},
  {modules, [ppool, ppool_serv, ppool_sup, ppool_spuer_sup, ppool_worker_sup]},
  {registered, [ppool]},
  {mod, {ppool, []}}
 ]}.
