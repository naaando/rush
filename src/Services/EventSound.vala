public class Service.EventSound : Object {
    uint32 playing_id;
    Canberra.Context context;
    Canberra.Proplist props;

    public EventSound (string id, string description) {
        Canberra.Context.create (out context);
        Canberra.Proplist.create (out props);

        props.sets (Canberra.PROP_EVENT_DESCRIPTION, description);
        props.sets (Canberra.PROP_EVENT_ID, id);
        props.sets (Canberra.PROP_CANBERRA_CACHE_CONTROL, "permanent");
        props.sets (Canberra.PROP_MEDIA_ROLE, "event");
    }

    public void play () {
        stop ();

        playing_id =  Random.next_int ();
        context.play_full (playing_id, props, null);
    }

    public void stop () {
        bool playing;
        context.playing (playing_id, out playing);
        if (playing) {
            context.cancel (playing_id);
        }
    }
}
