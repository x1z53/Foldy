scalable_dir = join_paths('hicolor', 'scalable', 'apps')

install_data(
  join_paths(scalable_dir, ('@0@.svg').format(service_name)),
  install_dir: join_paths(get_option('datadir'), 'icons', scalable_dir)
)

symbolic_dir = join_paths('hicolor', 'symbolic', 'apps')

install_data(
  join_paths(symbolic_dir, ('@0@-symbolic.svg').format(service_name)),
  install_dir: join_paths(get_option('datadir'), 'icons', symbolic_dir)
)
