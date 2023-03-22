# Goal

UX wants an excellent select component that can be used for any selection like attributes(brand, colour), categories etc.
Now, it's your turn to show off your FE magic! 😮‍💨

# Procedure

Please read the following instructions carefully.

It's up to you to decide how much time to invest in this task. To come up with a complete solution, you should need around three to four hours. But it depends on whether your first approach will work – or if you invest time to improve it.

It's up to you to make UX happy. We seek somebody who can work closely with UX and build picture-perfect implementations from Figma designs. Be attentive, be creative, and be resourceful.

Copy this repo to your own Git account and add your solution. Please provide us at the end with your git repo to study your answer.

The conversation after the challenge is also meaningful. We would like to hear how you tried to solve the problem, what you have learned, and where you failed.

# Setup

To start your Phoenix server:

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

# Task

Implement the select component following the [figma file](https://www.figma.com/file/23oEDv1CsiCUCUV545ku7u/FE-Challenge?node-id=0%3A1&t=40Rm323wUS59Wc1b-1) in the file `lib/frontend_challenge_web/components/select.ex`.

You can see the select component in action in the file `lib/frontend_challenge_web/live/home.ex`. And access it on [`localhost:4000`](http://localhost:4000).

The select component is already displayed with different data.

- You should implement the select component using Tailwind (the tailwind configuration has been set up);
- The select component should be a "dead" component. The implementation of "reactivity" should be done with LiveviewJS or/and CSS state and transition;
- The value of the select component should be stored in a hidden field;
- The implementation of both sm (mobile) and md, lg (desktop) versions should be implemented as one component. Hide the parts that don't appear on the other screen sizes.
