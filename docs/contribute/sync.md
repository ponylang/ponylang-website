# Pony Development Sync

The Pony Development Sync is a weekly meeting where Pony contributors discuss topics related to Pony, including recently added or modified issues.

## Attending the Pony Development Sync

Stay up-to-date with the schedule by [subscribing to the Development Sync calender](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics).

Each meeting is recorded and all recordings are available on [Vimeo](https://vimeo.com/channels/ponydevelopmentsync). Recordings are available dating back to 2016.

You can check out conversation related to the weekly meetings in the [sync stream](https://ponylang.zulipchat.com/#narrow/stream/190591-sync) in the [Pony Zulip](https://ponylang.zulipchat.com/).

## Running the Pony Development Sync

The Pony Development Sync takes place as a [Zoom](https://zoom.us) call. In order to run the Pony Development Sync you must have Zoom installed, and be logged in as `ponylang.main@gmail.com`. A list of issues/PRs for discussion is generated by a GitHub action on the [pony-sync-helper](https://github.com/ponylang/pony-sync-helper) and posted prior to Pony Development Sync into the [`sync`](https://ponylang.zulipchat.com/#narrow/stream/190591-sync) stream in Zulip, in a topic whose name is the date of the meeting in the format `YYYY-MM-DD` (for example May 12, 2020 would be "2020-05-12"). This GitHub action generates its list based on issues/PRs with the "discuss during sync" tag -- which is automated for [addition](https://github.com/ponylang/ponylang-website/tree/main/.github/workflows/add-discuss-during-sync.yml) and [removal](https://github.com/ponylang/ponylang-website/tree/main/.github/workflows/remove-discuss-during-sync.yml), but can also be applied manually as needed.

The generated agenda for each meeting is triggered from Zapier. Zapier has access to the ponylang.main@gmail.com calendar and triggers a "Zap" to run based on the time of the Pony Development Sync event in the calendar. The zap posts a repository dispatch event to the pony-sync-helper repo which runs a workflow build the sync tool, to generate an agenda, and to post the agenda to Zulip.

### Prerequisites

In order to run the Pony Development Sync meeting you will need:

1. [Zulip](https://zulipchat.com/) and a Zulip account
2. A 1Password account that is connected to the [Pony 1Password account](https://ponylangcoreteam.1password.com/signin)
3. [Zoom](https://zoom.us)
4. The Zoom password for the `ponylang.main@gmail.com` account, which is available in the Pony 1Password vault

Additionally, you might need:

- A GitHub account
- A GitHub personal access token for running the `pony-sync-helper` program
- The [`pony-sync-helper`](https://github.com/ponylang/pony-sync-helper) program
- Access to the Pony Development Sync recording account on [nearlyfreespeech.net](https://nearlyfreespeech.net) (for access, contact Sean T. Allen via private message on Zulip)
- A program for transferring files via `scp`

### Steps

1. If the agenda wasn't posted because of a Zapier issue, you can [run it manually](https://github.com/ponylang/pony-sync-helper/actions/workflows/manually-generate-agenda.yml). If the agenda wasn't posted because of a GitHub issue, you are probably out of luck but you can try to run the `pony-sync-helper` program locally. The program repo contains [instructions for building and running it](https://github.com/ponylang/pony-sync-helper#building).
2. Using the `ponylang.main@gmail.com` account, log into the Zoom meeting a few minutes before the official start time.
3. When you feel that there are enough people in the meeting to start, announce that you will be recording the meeting and give participants a few seconds to stop talking. Give a countdown to when you will start recording so that nobody is caught unaware.
4. Start recording the meeting in Zoom. If you have access to the Pony Development Sync recording account, you can record locally, otherwise, you should record to the cloud.
5. Begin the meeting by stating that this is the Pony Development Sync meeting, giving the date, and giving everyone in the room a chance to introduce themselves.
6. After the introduction, the meeting runner can set the agenda and proceed with the meeting.
7. When the meeting discussion has ended, stop recording and announce that you have stopped recording.

If you did a local recording of the meeting, please do the following:

1. The meeting audio will be written to disk when you leave the meeting (it takes a couple minutes). You'll be alerted by Zoom when it is ready.
2. Use `SCP` to copy the meeting recording to the `r` directory of the Pony account on [nearlyfreespeech.net](https://nearlyfreespeech.net). The file should be called `DATE.m4a`, where `DATE` is the date in `YYYY\_MM\_DD` format(for example May 12, 2020 would be `2020_05_12.m4a`).
3. Put a note in the Zulip dated topic for the sync announcing that the sync recording is available and provide the recording URL.
4. Add a comment to the "Last Week in Pony" issue (in the [ponylang/ponylang-website](https://github.com/ponylang/ponylang-website) repo) that also announces that the recording is available.

If you did a cloud recording, please do the following:

1. Inform someone who has access to the Pony Development Sync recording account that there's a cloud recording waiting for upload. Most likely this will be either Sean T. Allen or Joe Eli McIlvain. They can then handle the upload and other related tasks.
