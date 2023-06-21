import { useBackend } from '../../../../backend';
import { Button, Stack } from '../../../../components';
import { PreferencesMenuData, RandomSetting } from '../../data';
import { RandomizationButton } from '../../RandomizationButton';
import { useRandomToggleState } from '../../useRandomToggleState';
import { CheckboxInput, Feature, FeatureToggle } from './base';

export const body_is_always_random: Feature<RandomSetting> = {
  name: 'Random Body',
  component: (props, context) => {
    const [randomToggle, setRandomToggle] = useRandomToggleState(context);

    return (
      <Stack>
        <Stack.Item>
          <RandomizationButton setValue={(newValue) => props.handleSetValue(newValue)} value={props.value} />
        </Stack.Item>

        {randomToggle ? (
          <>
            <Stack.Item>
              <Button
                color="green"
                onClick={() => {
                  props.act('randomize_character');
                  setRandomToggle(false);
                }}>
                Randomize
              </Button>
            </Stack.Item>

            <Stack.Item>
              <Button color="red" onClick={() => setRandomToggle(false)}>
                Cancel
              </Button>
            </Stack.Item>
          </>
        ) : (
          <Stack.Item>
            <Button onClick={() => setRandomToggle(true)}>Randomize</Button>
          </Stack.Item>
        )}
      </Stack>
    );
  },
};

export const name_is_always_random: Feature<RandomSetting> = {
  name: 'Random Name',
  component: (props, context) => {
    return <RandomizationButton setValue={(value) => props.handleSetValue(value)} value={props.value} />;
  },
};

export const random_species: Feature<RandomSetting> = {
  name: 'Random Species',
  component: (props, context) => {
    const { act, data } = useBackend<PreferencesMenuData>(context);

    const species = data.character_preferences.randomization['species'];

    return (
      <RandomizationButton
        setValue={(newValue) =>
          act('set_random_preference', {
            preference: 'species',
            value: newValue,
          })
        }
        value={species || RandomSetting.Disabled}
      />
    );
  },
};
