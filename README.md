# em-emitter

### Global event emitter and receiver for sending events across objects inside the Eventmachine reactor.

You can use em-emitter to communicate with other objects in the Eventmachine reactor by subscribing to events and emitting them with encapsulated pieces of data.

The filtering allows for Ruby hashes to be used and for objects to have fine grained control over what events they want to receive.

The global emitter decouples all objects from each other and works by including the `EM::Emitter::Observable` module into any classes that wish to subscribe or emit events.

## Requirements
em-emitter has been run and tested on Ruby 1.9.3 with Eventmachine 1.0.0. You are welcome to try it on other versions of Ruby.

## Installation
To install em-emitter use ruby gems by typing:

    gem install em-emitter --pre

*Note:* This is a beta release of the first version so it is still under heavy development. Hence the need to append `--pre` to the installation command.

## Usage
TBD

## License
em-emitter is licensed under the MIT License and can be used and edited for open source or commercial projects.