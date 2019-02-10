project ('com.github.naaando.pomodoro', 'vala', 'c')

add_global_arguments ('-DGETTEXT_PACKAGE="' + meson.project_name () + '"', language:'c')

subdir ('libpomodoro')

gnome = import ('gnome')
asresources = gnome.compile_resources(
    'as-resources', 'data/com.github.naaando.pomodoro.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

executable(
    meson.project_name(),
    asresources,
    'src/Application.vala',
    'src/Factory/ViewFactory.vala',
    'src/Interfaces/PomodoroView.vala',
    'src/Services/EventSound.vala',
    'src/View/DonePage.vala',
    'src/View/HeaderBar.vala',
    'src/View/Page.vala',
    'src/View/PomodoroWindow.vala',
    'src/View/ReportsGrid.vala',
    'src/View/RunningPage.vala',
    'src/Widgets/MultiImageToggleButton.vala',
    'src/Widgets/PomodoroLabel.vala',
    'src/Widgets/DoubleColumnContainer.vala',
    'src/Widgets/TimerLabel.vala',
    'src/Widgets/SegmentedButton.vala',
    dependencies: [
        dependency('glib-2.0'),
        dependency('gobject-2.0'),
        dependency('gtk+-3.0'),
        dependency('libcanberra'),
        dependency('unity')
    ],
    link_with: libpomodoro,
    include_directories: include_directories('libpomodoro'),
    install: true
)

subdir ('data')

# Compile gsettings schemas and rebuild desktop icons cache
meson.add_install_script('meson/post_install.py')
