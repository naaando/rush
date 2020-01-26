name = 'pomodoro'

dependencies =  [
    dependency('glib-2.0'),
    dependency('gio-2.0'),
    dependency('gobject-2.0'),
    dependency('gee-0.8'),
    dependency('json-glib-1.0'),
]

subdir('src')

libpomodoro = static_library(
    name,
    sources,
    dependencies: dependencies,
    install: true,
    include_directories: include_directories('.'),
)
