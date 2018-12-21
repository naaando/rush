public class StyledWidget<T> : Gtk.Widget {
    public void add_class (string class) {
        get_style_context ().add_class (class);
    }
}
