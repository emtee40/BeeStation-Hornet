/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

export const MAX_VISIBLE_MESSAGES = 2500;
export const MAX_PERSISTED_MESSAGES = 1000;
export const MESSAGE_SAVE_INTERVAL = 10000;
export const MESSAGE_PRUNE_INTERVAL = 60000;
export const COMBINE_MAX_MESSAGES = 5;
export const COMBINE_MAX_TIME_WINDOW = 5000;
export const IMAGE_RETRY_DELAY = 250;
export const IMAGE_RETRY_LIMIT = 10;
export const IMAGE_RETRY_MESSAGE_AGE = 60000;

// Default message type
export const MESSAGE_TYPE_UNKNOWN = 'unknown';

// Internal message type
export const MESSAGE_TYPE_INTERNAL = 'internal';

// Must match the set of defines in code/__DEFINES/chat.dm
export const MESSAGE_TYPE_SYSTEM = 'system';
export const MESSAGE_TYPE_LOCALCHAT = 'localchat';
export const MESSAGE_TYPE_RADIO = 'radio';
export const MESSAGE_TYPE_INFO = 'info';
export const MESSAGE_TYPE_WARNING = 'warning';
export const MESSAGE_TYPE_DEADCHAT = 'deadchat';
export const MESSAGE_TYPE_OOC = 'ooc';
export const MESSAGE_TYPE_ADMINPM = 'adminpm';
export const MESSAGE_TYPE_MENTORPM = 'mentorpm';
export const MESSAGE_TYPE_COMBAT = 'combat';
export const MESSAGE_TYPE_ADMINCHAT = 'adminchat';
export const MESSAGE_TYPE_MENTORCHAT = 'mentorchat';
export const MESSAGE_TYPE_EVENTCHAT = 'eventchat';
export const MESSAGE_TYPE_ADMINLOG = 'adminlog';
export const MESSAGE_TYPE_MENTORLOG = 'mentorlog';
export const MESSAGE_TYPE_ATTACKLOG = 'attacklog';
export const MESSAGE_TYPE_DEBUG = 'debug';

// Metadata for each message type
export const MESSAGE_TYPES = [
  // Always-on types
  {
    type: MESSAGE_TYPE_SYSTEM,
    name: 'System Messages',
    description: 'Messages from your client, always enabled',
    selector: '.srt_system, .boldannounce',
    important: true,
  },
  // Basic types
  {
    type: MESSAGE_TYPE_LOCALCHAT,
    name: 'Local',
    description: 'In-character local messages (say, emote, etc)',
    selector: '.srt_local, .say, .emote',
  },
  {
    type: MESSAGE_TYPE_RADIO,
    name: 'Radio',
    description: 'All departments of radio messages',
    selector: '.srt_radio, .alert, .newscaster, .shadowling, .changeling',
  },
  {
    type: MESSAGE_TYPE_INFO,
    name: 'Info',
    description: 'Non-urgent messages from the game and items',
    selector: '.srt_info, .notice:not(.pm), .adminnotice, .info',
  },
  {
    type: MESSAGE_TYPE_WARNING,
    name: 'Warnings',
    description: 'Urgent messages from the game and items',
    selector: '.srt_warning, .warning:not(.pm), .critical, .userdanger, .italics',
  },
  {
    type: MESSAGE_TYPE_DEADCHAT,
    name: 'Deadchat',
    description: 'All of deadchat',
    selector: '.srt_deadchat', // DO NOT USE '.deadsay'. It's deprecated
  },
  {
    type: MESSAGE_TYPE_OOC,
    name: 'OOC',
    description: 'OOC and LOOC messages',
    selector: '.srt_ooc, .ooc, .looc, .adminooc, .adminobserverooc',
  },
  {
    type: MESSAGE_TYPE_ADMINPM,
    name: 'Admin PMs',
    description: 'Messages to/from admins (adminhelp)',
    selector: '.pm, .adminhelp',
  },
  {
    type: MESSAGE_TYPE_MENTORPM,
    name: 'Mentor PMs',
    description: 'Messages to/from mentors (mentorhelp)',
    selector: '.mentorhelp, .mentorto, .mentorfrom',
  },
  {
    type: MESSAGE_TYPE_COMBAT,
    name: 'Combat Log',
    description: 'Urist McTraitor has stabbed you with a knife!',
    selector: '.srt_combat, .danger',
  },
  {
    type: MESSAGE_TYPE_UNKNOWN,
    name: 'Unsorted',
    description: 'Everything that was not sorted',
  },
  // Admin stuff
  {
    type: MESSAGE_TYPE_ADMINCHAT,
    name: 'Admin Chat',
    description: 'ASAY messages',
    selector: '.admin_channel, .adminsay',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_MENTORCHAT,
    name: 'Mentor Chat',
    description: 'MSAY (Mentor) chat',
    selector: '.mentorsay',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_ADMINLOG,
    name: 'Admin Log',
    description: 'ADMIN LOG: Urist McAdmin has jumped to coordinates X, Y, Z',
    selector: '.adminlog',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_MENTORLOG,
    name: 'Mentor Log',
    description: "MENTOR LOG: Spacestation13mentor has started replying to Spacestation13player's mentor help.",
    selector: '.mentorlog',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_ATTACKLOG,
    name: 'Attack Log',
    description: 'Urist McTraitor has shot John Doe',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_DEBUG,
    name: 'Debug Log',
    description: 'DEBUG: SSPlanets subsystem Recover().',
    admin: true,
  },
];
