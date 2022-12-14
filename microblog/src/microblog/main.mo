import Iter "mo:base/Iter";
import List "mo:base/List";
import Principal "mo:base/Principal";
import Time "mo:base/Time";
import Int "mo:base/Int";


actor {
    public type Message = {
      text: Text;
      author: Text;
      time: Time.Time;
    };
        
    private type FollowInfo = {
        name: Text;
        id : Text;
    };

    public type MicroBlog = actor{
      follow: shared(Principal) -> async();
      follows: shared query () -> async [FollowInfo];
      post: shared (Text,Text) -> async();
      posts: shared query (Time.Time) -> async [Message];
      timeline: shared (Time.Time) -> async [Message];
      get_name: shared query () -> async ?Text;
      set_name: shared (Text) -> ();
    };

    private stable var auth: ?Text = null;
    public shared func set_name(t:Text): async(){
        auth := ?t;
    };
    public query func get_name() :async ?Text {
        auth
    };

    stable var followed:List.List<Principal> = List.nil();

    public shared func follow (id:Principal): async(){
        followed :=  List.push(id,followed);
    };
    public shared func follows (): async [FollowInfo]{
        var all : List.List<FollowInfo> = List.nil();
        for(id in Iter.fromList(followed)){
            ignore do ? {
                let canister : MicroBlog = actor(Principal.toText(id));
                let n = (await canister.get_name()) !;
                let tmp : FollowInfo = {
                  name = n;
                  id = Principal.toText(id);
                };
                all := List.push<FollowInfo>(tmp, all);
            }
        };
        return List.toArray(all);
    };

    stable var messages:List.List<Message> = List.nil();
    public shared({caller}) func post (text:Text,password:Text): async(){
        assert(password == "manue1");
        let _author = switch (auth) {
          case (?a) {a};
          case (null) {""};
        };
        var msg : Message = {
          text = text;
          author = _author;
          time = Time.now();
        };
        messages := List.push(msg,messages);
    };
    
    public shared query func posts(since : Time.Time) :async [Message] {
        var since_message : List.List<Message> = List.nil();
        for (msg in Iter.fromList(messages)) {
            if (msg.time >= since) {
                since_message := List.push(msg, since_message);
            };
        };
        List.toArray(since_message)
    };

    public shared func timeline (since : Time.Time) : async [Message]{
        var all: List.List<Message> = List.nil();
        for (id in Iter.fromList(followed)){
          let canister : MicroBlog = actor(Principal.toText(id));
          let posts = await canister.posts(since);
          for (post in Iter.fromArray(posts)){
            all := List.push(post,all);
          };
        };
        List.toArray(all)
    };

};
