public class PomodoroWindow : Gtk.ApplicationWindow, PomodoroView {
    Gtk.Stack pages = new Gtk.Stack ();
    Pomodoro.Service? pomodoro_service;
    Page running_page;
    Page done_page;

    public PomodoroWindow.with_factory (Gtk.Application application, ViewFactory factory) {
        this (application, factory.create_running_page () as Page, factory.create_done_page () as Page);

        var header_bar = new HeaderBar ();
        set_titlebar (header_bar);
    }

    public PomodoroWindow (Gtk.Application application, Page running, Page done) {
        Object (
            application: application,
            resizable: true,
            window_position: Gtk.WindowPosition.CENTER
        );

        set_default_size (240, 450);
        running_page = running;
        done_page = done;

        pages.add (running_page);
        pages.add (done_page);
        add (pages);
    }

    public void set_pomodoro_service (Pomodoro.Service pomodoro_service) {
        this.pomodoro_service = pomodoro_service;
        pomodoro_service.start.connect (on_pomodoro_service_started);
        pomodoro_service.stop.connect (on_pomodoro_service_stopped);
    }

    void on_pomodoro_service_started () {
        pages.visible_child = running_page;
    }

    void on_pomodoro_service_stopped () {
        pages.visible_child = done_page;
        display_window ();
    }

    private void display_window () {
        //  FIXME: Using present () method looks broken https://stackoverflow.com/questions/9054462/how-do-i-raise-a-window-that-is-minimized-or-covered-with-pygobject
        //  present ();

        set_keep_above (true);
        set_keep_above (false);
    }

    public override bool delete_event (Gdk.EventAny event) {
        bool close_to_bg = Application.settings.get_boolean ("close-to-background");
        bool pomodoro_is_running = pomodoro_service != null && pomodoro_service.running;

        return  close_to_bg && pomodoro_is_running ? hide_on_delete () : false;
    }
}
