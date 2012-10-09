# em-emitter

### Global event emitter and receiver for sending events across objects inside the Eventmachine reactor.

You can use em-emitter to communicate with other objects in the Eventmachine reactor by subscribing to events and emitting them with encapsulated pieces of data.

The filtering allows for Ruby hashes to be used and for objects to have fine grained control over what events they want to receive.

The global emitter decouples all objects from each other and works by including the `EM::Emitter::Observable` module into any classes that wish to subscribe or emit events.

## Requirements
TBD

## Installation
TBD

## Usage
TBD

## License
TBD