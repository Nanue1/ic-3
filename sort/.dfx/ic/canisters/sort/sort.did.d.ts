import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface _SERVICE {
  'greet' : ActorMethod<[string], string>,
  'qsort' : ActorMethod<[Array<bigint>], Array<bigint>>,
}
