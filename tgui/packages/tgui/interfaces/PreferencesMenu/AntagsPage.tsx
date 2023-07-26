import { classes } from 'common/react';
import { useBackend, useLocalState } from '../../backend';
import { Box, Button, Flex, Section, Stack, Tooltip, Divider, Input, Icon } from '../../components';
import { PreferencesMenuData } from './data';
import { ServerPreferencesFetcher } from './ServerPreferencesFetcher';
import { AntagonistData } from './data';
import { createSearch } from 'common/string';

const AntagSelection = (
  props: {
    antagonists: AntagonistData[];
    name: string;
  },
  context
) => {
  const { act, data } = useBackend<PreferencesMenuData>(context);
  const className = 'PreferencesMenu__Antags__antagSelection';

  const enableAntagsGlobal = (antags: string[]) => {
    act('set_antags', {
      antags,
      toggled: true,
      character: false,
    });
  };

  const disableAntagsGlobal = (antags: string[]) => {
    act('set_antags', {
      antags,
      toggled: false,
      character: false,
    });
  };

  const enableAntagsCharacter = (antags: string[]) => {
    act('set_antags', {
      antags,
      toggled: true,
      character: true,
    });
  };

  const disableAntagsCharacter = (antags: string[]) => {
    act('set_antags', {
      antags,
      toggled: false,
      character: true,
    });
  };

  const isSelectedGlobal = (antag: string) => {
    return data.enabled_global?.includes(antag);
  };

  const isSelectedCharacter = (antag: string) => {
    return data.enabled_character?.includes(antag);
  };

  const antagonistKeys = props.antagonists.map((antagonist) => antagonist.path);

  return (
    <Section
      title={props.name}
      buttons={
        <>
          <Button color="good" onClick={() => enableAntagsGlobal(antagonistKeys)}>
            Enable All
          </Button>

          <Button color="bad" onClick={() => disableAntagsGlobal(antagonistKeys)}>
            Disable All
          </Button>
        </>
      }>
      <Flex className={className} align="flex-end" wrap>
        {props.antagonists.map((antagonist) => {
          const isBanned = antagonist.ban_key && data.antag_bans && data.antag_bans.indexOf(antagonist.ban_key) !== -1;
          const hoursLeft =
            (antagonist.path &&
              data.antag_living_playtime_hours_left &&
              data.antag_living_playtime_hours_left[antagonist.path]) ||
            0;

          let full_description = `${
            isBanned ? `You are banned from ${antagonist.name}.${antagonist.description || hoursLeft > 0 ? '\n' : ''}` : ''
          }${
            hoursLeft > 0
              ? `You require ${hoursLeft} more hour${
                hoursLeft !== 1 ? 's' : ''
              } of living playtime in order to play this role.${antagonist.description ? '\n' : ''}`
              : ''
          }${antagonist.description}`;
          if (!full_description.length) {
            full_description = 'No description found.';
          }

          return (
            <Flex.Item
              className={classes([
                `${className}__antagonist`,
                `${className}__antagonist--${
                  isBanned || hoursLeft > 0
                    ? 'banned'
                    : isSelectedGlobal(antagonist.path)
                      ? antagonist.per_character && !isSelectedCharacter(antagonist.path)
                        ? 'banned'
                        : 'on'
                      : 'off'
                }`,
              ])}
              key={antagonist.path}>
              {antagonist.per_character && !(isBanned || hoursLeft > 0) ? (
                <Box
                  className={classes([
                    `${className}__antagonist__per_character`,
                    `${className}__antagonist__per_character--${isSelectedCharacter(antagonist.path) ? 'on' : 'off'}`,
                  ])}>
                  <Box
                    className="antagonist-icon-parent-per-character"
                    onClick={() => {
                      if (isBanned) {
                        return;
                      }

                      if (isSelectedCharacter(antagonist.path)) {
                        disableAntagsCharacter([antagonist.path]);
                      } else {
                        enableAntagsCharacter([antagonist.path]);
                      }
                    }}>
                    <Tooltip
                      content={
                        <div>
                          Per-Character Toggle
                          <Divider />
                          This can only be disabled per-character. You cannot force a globally disabled antagonist
                          &apos;on&apos; for a specific character.
                        </div>
                      }>
                      <Box className="antagonist-icon">C</Box>
                    </Tooltip>
                  </Box>
                </Box>
              ) : null}
              <Stack align="center" vertical>
                <Stack.Item
                  style={{
                    'font-weight': 'bold',
                    'margin-top': 'auto',
                    'max-width': '100px',
                    'text-align': 'center',
                  }}>
                  {antagonist.name}
                </Stack.Item>

                <Stack.Item align="center">
                  <Tooltip
                    content={(full_description || 'No description found.').split('\n').map((text, index, values) => (
                      <div key={antagonist.path + '_desc_' + index}>
                        {text}
                        {index !== values.length - 1 && <Divider />}
                      </div>
                    ))}
                    position="bottom">
                    <Box
                      className="antagonist-icon-parent"
                      onClick={() => {
                        if (isBanned) {
                          return;
                        }

                        if (isSelectedGlobal(antagonist.path)) {
                          disableAntagsGlobal([antagonist.path]);
                        } else {
                          enableAntagsGlobal([antagonist.path]);
                        }
                      }}>
                      <Box className={classes(['antagonists96x96', antagonist.icon_path, 'antagonist-icon'])} />

                      {isBanned && <Box className="antagonist-banned-slash" />}

                      {hoursLeft > 0 && (
                        <Box className="antagonist-time-left">
                          <span className="antagonist-time-left-hours">{hoursLeft}</span>
                          <br />
                          hours left
                        </Box>
                      )}
                    </Box>
                  </Tooltip>
                </Stack.Item>
              </Stack>
            </Flex.Item>
          );
        })}
      </Flex>
    </Section>
  );
};

export const AntagsPage = (_, context) => {
  let [searchText, setSearchText] = useLocalState(context, 'antag_search', '');
  let search = createSearch(searchText, (antagonist: AntagonistData) => {
    return antagonist.name;
  });
  return (
    <ServerPreferencesFetcher
      render={(serverData) => {
        if (!serverData) {
          return <Box>Loading loadout data...</Box>;
        }
        const { antagonists = [], categories = [] } = serverData.antags;
        return (
          <Box className="PreferencesMenu__Antags">
            <SearchBar
              searchText={searchText}
              setSearchText={setSearchText}
              allAntags={antagonists.map((antag) => antag.path)}
            />
            {searchText !== '' ? (
              <AntagSelection name="Search Result" antagonists={antagonists.filter(search)} />
            ) : (
              categories.map((category) => (
                <AntagSelection
                  name={category}
                  key={category}
                  antagonists={antagonists.filter((a) => a.category === category)!}
                />
              ))
            )}
          </Box>
        );
      }}
    />
  );
};

const SearchBar = ({ searchText, setSearchText, allAntags }, context) => {
  const { act } = useBackend<PreferencesMenuData>(context);
  const enableAntagsGlobal = (antags: string[]) => {
    act('set_antags', {
      antags,
      toggled: true,
      character: false,
    });
  };

  const disableAntagsGlobal = (antags: string[]) => {
    act('set_antags', {
      antags,
      toggled: false,
      character: false,
    });
  };
  return (
    <Section fill>
      <Stack>
        <Stack.Item>
          <Icon mr={1} name="search" />
          <Input width="350px" placeholder="Search roles" value={searchText} onInput={(_, value) => setSearchText(value)} />
        </Stack.Item>
        <Stack.Item grow />
        <Stack.Item>
          <Button color="good" onClick={() => enableAntagsGlobal(allAntags)}>
            Enable Everything
          </Button>

          <Button color="bad" onClick={() => disableAntagsGlobal(allAntags)}>
            Disable Everything
          </Button>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
