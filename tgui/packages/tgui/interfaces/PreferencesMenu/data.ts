import { BooleanLike } from 'common/react';
import { sendAct } from '../../backend';
import { Gender } from './preferences/gender';

export enum Food {
  Alcohol = 'ALCOHOL',
  Breakfast = 'BREAKFAST',
  Cloth = 'CLOTH',
  Dairy = 'DAIRY',
  Fried = 'FRIED',
  Fruit = 'FRUIT',
  Grain = 'GRAIN',
  Gross = 'GROSS',
  Junkfood = 'JUNKFOOD',
  Meat = 'MEAT',
  Pineapple = 'PINEAPPLE',
  Raw = 'RAW',
  Sugar = 'SUGAR',
  Toxic = 'TOXIC',
  Vegetables = 'VEGETABLES',
}

export enum JobPriority {
  Low = 1,
  Medium = 2,
  High = 3,
}

export type Name = {
  can_randomize: BooleanLike;
  explanation: string;
  group: string;
};

export type ServerSpeciesData = {
  name: string;
  icon: string;

  use_skintones: BooleanLike;
  sexes: BooleanLike;

  enabled_features: string[];

  liked_food: Food[];
  disliked_food: Food[];
  toxic_food: Food[];
};

export type Department = {
  head?: string;
};

export type Job = {
  description: string;
  department: string;
};

export type Quirk = {
  description: string;
  icon: string;
  name: string;
  value: number;
};

export type QuirkInfo = {
  max_positive_quirks: number;
  quirk_info: Record<string, Quirk>;
  quirk_blacklist: string[][];
};

export type LoadoutInfo = {
  categories: LoadoutCategory[];
  purchased_gear: string[];
  equipped_gear: string[];
  metacurrency_name: string;
};

export type LoadoutGear = {
  id: string;
  display_name: string;
  skirt_display_name: string | null;
  donator: BooleanLike;
  cost: number;
  allowed_roles: string[] | null;
  is_equippable: BooleanLike;
  multi_purchase: BooleanLike;
};

export type LoadoutCategory = {
  name: string;
  gear: LoadoutGear[];
};

export enum RandomSetting {
  AntagOnly = 1,
  Disabled = 2,
  Enabled = 3,
}

export enum JoblessRole {
  BeOverflow = 1,
  BeRandomJob = 2,
  ReturnToLobby = 3,
}

export enum GamePreferencesSelectedPage {
  Settings,
  Keybindings,
}

export const createSetPreference = (act: typeof sendAct, preference: string) => (value: unknown) => {
  act('set_preference', {
    preference,
    value,
  });
};

export enum Window {
  Character = 0,
  Game = 1,
  Keybindings = 2,
}

export type PreferencesMenuData = {
  character_preview_view: string;
  character_profiles: (string | null)[];

  character_preferences: {
    clothing: Record<string, string>;
    features: Record<string, string>;
    game_preferences: Record<string, unknown>;
    non_contextual: {
      body_is_always_random: RandomSetting;
      [otherKey: string]: unknown;
    };
    secondary_features: Record<string, unknown>;
    supplemental_features: Record<string, unknown>;

    names: Record<string, string>;

    misc: {
      gender: Gender;
      joblessrole: JoblessRole;
      species: string;
    };

    randomization: Record<string, RandomSetting>;
  };

  content_unlocked: BooleanLike;

  job_bans?: string[];
  job_days_left?: Record<string, number>;
  job_required_experience?: Record<
    string,
    {
      experience_type: string;
      required_playtime: number;
    }
  >;
  job_preferences: Record<string, JobPriority>;

  keybindings: Record<string, string[]>;
  overflow_role: string;
  selected_quirks: string[];

  purchased_gear: string[];
  equipped_gear: string[];
  metacurrency_balance: number;
  is_donator: BooleanLike;

  antag_bans?: string[];
  antag_days_left?: Record<string, number>;
  selected_antags: string[];

  active_slot: number;
  max_slot: number;
  name_to_use: string;
  save_in_progress: BooleanLike;

  window: Window;
};

export type ServerData = {
  jobs: {
    departments: Record<string, Department>;
    jobs: Record<string, Job>;
  };
  names: {
    types: Record<string, Name>;
  };
  quirks: QuirkInfo;
  loadout: LoadoutInfo;
  random: {
    randomizable: string[];
  };
  species: Record<string, ServerSpeciesData>;
  [otheyKey: string]: unknown;
};
