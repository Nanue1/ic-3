import { microblog } from "../../declarations/microblog";


async function post() {
  let post_button = document.getElementById('post');
  post_button.disabled = true;
  let error = document.getElementById("error")
  error.innerText = ""
  let textarea = document.getElementById('message')
  let text = textarea.value;
  let otp = document.getElementById('otp').value;
  try {
    await microblog.post(text,otp);
    textarea.value = "";
  } catch (err) {
    console.log(err);
    error.innerText = "Post failed! " + err.message;
  }
  post_button.disabled = false;
}

var num_posts = 0;
async function load_posts() {
  let post_section = document.getElementById('posts');
  let posts = await microblog.posts(0);
  if (num_posts == posts.length) return;
  post_section.replaceChildren([])
  num_posts = posts.length
  for (let i = 0; i < posts.length; i++) {
    let post_metainfo = document.createElement("p");
    post_metainfo.innerText = posts[i].author + " post in " + timeConverter(posts[i].time);
    let post = document.createElement("p")
    post.innerText = posts[i].text;
    post_section.appendChild(post_metainfo);
    post_section.appendChild(post)
  }
}

var num_follows = 0;

async function load_follows() {
    let follows_section = document.getElementById("follows");
    let follows = await microblog.follows();
    if (num_follows === follows.length) return;
    follows_section.replaceChildren([]);
    num_follows = follows.length;
    for (var i = 0; i < follows.length; i++) {
        let post = document.createElement("p");
        post.innerText = follows[i].name + " " + follows[i].id;
        follows_section.appendChild(post);
    }
}

var num_timeline = 0;

async function load_timeline() {
    let timeline_section = document.getElementById("timeline");
    let timeline = await microblog.timeline(0);
    if (num_timeline === timeline.length) return;
    timeline_section.replaceChildren([]);
    num_timeline = timeline.length;
    for (var i = 0; i < timeline.length; i++) {
        let timeline_metainfo = document.createElement("p");
        timeline_metainfo.innerText =
            timeline[i].author + " post in " + timeConverter(timeline[i].time);
        let timeline_msg = document.createElement("p");
        timeline_msg.innerText = timeline[i].text;

        timeline_section.appendChild(timeline_metainfo);
        timeline_section.appendChild(timeline_msg);
    }
}

async function load(){
  let post_button = document.getElementById('post');
  post_button.onclick = post;
  load_posts();
  load_follows();
  load_timeline();
  setInterval(load_posts,3000);
}

window.onload = load



function timeConverter(UNIX_timestamp) {
  var a = new Date(Number(UNIX_timestamp / 1000000n));
  const humanDateFormat = a.toLocaleString();
  return humanDateFormat;
}