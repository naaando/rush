icon_sizes = ['16', '24', '32', '48', '64', '128']

foreach i : icon_sizes
    install_data (
        join_paths ('icons', i, meson.project_name () + '.png'),
        install_dir: join_paths (get_option ('datadir'), 'icons', 'hicolor', i + 'x' + i, 'apps')
    )
    install_data (
        join_paths ('icons', i, meson.project_name () + '.png'),
        install_dir: join_paths (get_option ('datadir'), 'icons', 'hicolor', i + 'x' + i + '@2', 'apps')
    )
endforeach

install_data(
    'com.github.naaando.rush.gschema.xml',
    install_dir: join_paths(get_option('datadir'), 'glib-2.0', 'schemas')
)

install_data (
    meson.project_name () + '.desktop',
    install_dir: join_paths (get_option ('datadir'), 'applications')
)

install_data (
    meson.project_name () + '.appdata.xml',
    install_dir: join_paths (get_option ('datadir'), 'metainfo')
)
