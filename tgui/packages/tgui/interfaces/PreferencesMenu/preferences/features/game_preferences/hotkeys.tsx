import { CheckboxInputInverse, createDropdownInput, FeatureToggle, Feature } from '../base';

export const hotkeys: FeatureToggle = {
  name: 'Classic hotkeys',
  category: 'GAMEPLAY',
  description: 'When enabled, will revert to the legacy hotkeys, using the input bar rather than popups.',
  component: CheckboxInputInverse,
};

export const zone_select: Feature<string> = {
  name: 'Bodyzone Targetting Mode',
  category: 'GAMEPLAY',
  description:
    'When set to simplified, the bodyzone system will be replaced with a grouped system where you can target legs, arms or body/head. This is useful if you do not have a numpad or want an easier to use system.',
  component: createDropdownInput(
    {
      'simplified': 'Simplified Targetting',
      'intent': 'Precise Targetting',
    },
    {
      buttons: false,
    }
  ),
};
