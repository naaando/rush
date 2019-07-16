public class PomodoroLabel : Gtk.Label {
    Gtk.StyleContext context;
    string? last_class;

    public PomodoroLabel () {
        context = get_style_context ();
    }

    public void set_pomodoro_state (Pomodoro.State pomodoro_state) {
        add_class (pomodoro_state.to_string ().down ()+"-label");

        switch (pomodoro_state) {
            case Pomodoro.State.WORKING:
                add_class ("working-label");
                label = _("Working");
                break;
            case Pomodoro.State.SHORT_BREAK:
                add_class ("shortbreak-label");
                label = _("Short break");
                break;
            case Pomodoro.State.LONG_BREAK:
                add_class ("longbreak-label");
                label = _("Long break");
                break;
        }
    }

    void add_class (string class) {
        if (last_class != null) {
            context.remove_class (last_class);
        }

        last_class = class;
        context.add_class (class);
    }
}
