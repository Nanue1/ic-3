import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface FollowInfo { 'id' : string, 'name' : string }
export interface Message { 'text' : string, 'time' : Time, 'author' : string }
export type Time = bigint;
export interface _SERVICE {
  'follow' : ActorMethod<[Principal], undefined>,
  'follows' : ActorMethod<[], Array<FollowInfo>>,
  'get_name' : ActorMethod<[], [] | [string]>,
  'post' : ActorMethod<[string, string], undefined>,
  'posts' : ActorMethod<[Time], Array<Message>>,
  'set_name' : ActorMethod<[string], undefined>,
  'timeline' : ActorMethod<[Time], Array<Message>>,
}
