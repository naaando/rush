[Compact]
private class DateTimeSerializer {
    //  Node BoxedSerializeFunc (void* boxed)
    public static Json.Node serialize (void* boxed) {
        var datetime = (DateTime) boxed;
        var node = new Json.Node (Json.NodeType.VALUE);
        node.set_string (datetime.to_string ());

        return node;
    }

    //  void* BoxedDeserializeFunc (Node node)
    public static DateTime deserialize (Json.Node node) {
        return new DateTime.from_iso8601 (node.get_string (), new TimeZone.utc ());
    }
}
