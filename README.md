# Private Messaging System for RedM

This project implements a private messaging system for specific jobs (such as doctors and police officers) in RedM using the VORP framework.

https://streamable.com/ny7nhs

## Features

- **Command /msg:** Allows players to send private messages to other players in the same job (doctor or police officer).
- **Interaction Animations:** When the player opens the input to write the message, a writing animation is played.
- **Authorization System:** Only players with the "doctor" or "police" jobs can use the /msg command.

## Main Files

### 1. `cl_msg.lua`
This file contains all the client-side logic, responsible for:

- Register the `/msg` command that opens the input interface.
- Manage the NUI interface for message capture.
- Start and stop animations related to the player's interaction with the messaging system.

### 2. `sv_msg.lua`
This file contains the server-side logic responsible for:

- Check the player's work when trying to use the `/msg` command.
- Send the message to all players who have the same job.
- Configure message colors and prefixes based on the player's job (doctor or police officer).

### 3. `index.html`
HTML file that defines the message input interface. This file is loaded as part of the NUI and is displayed when the player opens the input to write the message.

### 4. `fxmanifest.lua`
Manifest file that defines the dependencies and scripts used in the resource. It is necessary for RedM to correctly recognize and load resource scripts and files.

## Installation

1. **Copy the Files:** Copy all project files to the resources folder on your RedM server.
2. **Configure `fxmanifest.lua`:** Make sure `fxmanifest.lua` is configured correctly to load the required scripts and files.
3. **Start Resource:** Add the resource to the list of resources that are started with the server (`server.cfg`).

## Usage

- **/msg:** Players who have the "doctor" or "police" job can use the `/msg` command to send private messages to other players with the same job.

## Debugging

- **Logs:** The code contains several `print` lines to aid debugging, displaying information in the console about actions performed and events triggered.
- **Common Errors:** If messages are not being displayed in the chat, check if the `msg:sendMessage` event is being correctly fired and if the NUI interface is correctly loaded.

## Contribution

Feel free to contribute improvements, suggestions or corrections to this project. To do this, fork the repository and send a pull request with your modifications.

## License

This project is open source under the MIT license.

## Author

Created by **uira182**.
