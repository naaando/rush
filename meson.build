project('com.github.naaando.rush', 'vala', 'c', version: '0.2.2')

gnome = import('gnome')
i18n = import('i18n')

add_project_arguments(
    '-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()),
    language: 'c'
)

subdir('libpomodoro')

asresources = gnome.compile_resources(
    'as-resources',
    'data/' + meson.project_name() + '.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

dependencies = [
    dependency('glib-2.0'),
    dependency('gobject-2.0'),
    dependency('gtk+-3.0'),
    dependency('libcanberra'),
    dependency('unity')
]

subdir('src')

executable(
    meson.project_name(),
    asresources,
    sources,
    dependencies: dependencies,
    link_with: libpomodoro,
    include_directories: include_directories('libpomodoro'),
    install: true
)

subdir('data')
subdir('po')

meson.add_install_script('meson/post_install.py')
