public enum Pomodoro.State {
    WORKING,
    SHORT_BREAK,
    LONG_BREAK;

    public string to_string () {
        switch (this) {
            case WORKING:
                return _("Working");
            case SHORT_BREAK:
                return _("Short break");
            case LONG_BREAK:
                return _("Long break");
            default:
                assert_not_reached ();
        }
    }
}
