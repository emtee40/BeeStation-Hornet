import { useBackend } from '../backend';
import { Box, Button, Dimmer, Icon, Section, Stack } from '../components';
import { NtosWindow } from '../layouts';

const NoIDDimmer = (props, context) => {
  const { act, data } = useBackend(context);
  const { owner } = data;
  return (
    <Stack>
      <Stack.Item>
        <Dimmer>
          <Stack align="baseline" vertical>
            <Stack.Item>
              <Stack ml={-2}>
                <Stack.Item>
                  <Icon
                    color="red"
                    name="address-card"
                    size={10}
                  />
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item fontSize="18px">
              Please imprint an ID to continue.
            </Stack.Item>
          </Stack>
        </Dimmer>
      </Stack.Item>
    </Stack>
  );
};

export const NtosMessenger = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    owner,
    ringer_status,
    sending_and_receiving,
    messengers = [],
    viewing_messages,
    sortByJob,
    canSpam,
    isSilicon,
    photo,
    virus_attach,
    sending_virus,
    messages = [],
    emoji_names = [],
  } = data;
  if (viewing_messages) {
    return (
      <NtosWindow width={400} height={600}>
        <NtosWindow.Content scrollable>
          <Stack vertical>
            <Section fill>
              <Button
                icon="arrow-left"
                content="Back"
                onClick={() => act('PDA_viewMessages')}
              />
              <Button
                icon="trash"
                content="Clear Messages"
                onClick={() => act('PDA_clearMessages')}
              />
            </Section>
            {messages.map(message => (
              <>
                <Section fill textAlign="left">
                  <Box italic opacity={0.5}>
                    {message.outgoing ? (
                      "(OUTGOING)"
                    ) : (
                      "(INCOMING)"
                    )}
                  </Box>
                  {message.outgoing ? (
                    <Box bold>
                      {message.target}
                    </Box>
                  ) : (
                    <Button transparent
                      content={message.name + " (" + message.job + ")"}
                      onClick={() => act('PDA_sendMessage', {
                        name: message.name,
                        job: message.job,
                        ref: message.ref,
                      })}
                    />
                  )}
                </Section>
                <Section fill mt={message.outgoing ? -0.9 : -1} mb={2}>
                  {
                    message.contents.split(":").map((part, index, arr) => {
                      if (message.emojis
                          && Object.keys(emoji_names).includes(part)) {
                        return (<span
                          key={part}
                          class={`chat16x16 emoji-${part}`} />);
                      } else {
                        // re-add colons from split()
                        // if the next element in the array is not valid emoji
                        return <span key={part}>{part}{arr.length - 1 !== index && (index + 1 >= arr.length || !message.emojis || !Object.keys(emoji_names).includes(arr[index + 1])) ? ":" : ""}</span>;
                      }
                    })
                  }
                  {!!message.photo && (
                    <Box
                      width={`${message.photo_width}px`}
                      height={`${message.photo_height}px`}
                      as="img"
                      src={message.photo}
                    />
                  )}
                </Section>
              </>
            ))}
          </Stack>
        </NtosWindow.Content>
      </NtosWindow>
    );
  }
  return (
    <NtosWindow width={400} height={600}>
      <NtosWindow.Content scrollable>
        <Stack vertical>
          <Section fill textAlign="center">
            <Box bold>
              <Icon name="address-card" mr={1} />
              SpaceMessenger V8.5.3
            </Box>
            <Box italic opacity={0.3}>
              Bringing you spy-proof communications since 2467.
            </Box>
          </Section>
        </Stack>
        <Stack vertical>
          <Section fill textAlign="center">
            <Box>
              <Button
                icon="bell"
                content={ringer_status ? 'Ringer: On' : 'Ringer: Off'}
                onClick={() => act('PDA_ringer_status')}
              />
              <Button
                icon="address-card"
                content={sending_and_receiving ? "Send / Receive: On" : "Send / Receive: Off"}
                onClick={() => act('PDA_sAndR')}
              />
              <Button
                icon="bell"
                content="Set Ringtone"
                onClick={() => act('PDA_ringSet')}
              />
              <Button
                icon="comment"
                content="View Messages"
                onClick={() => act('PDA_viewMessages')}
              />
              <Button
                icon="sort"
                content={`Sort by: ${sortByJob ? "Job" : "Name"}`}
                onClick={() => act('PDA_changeSortStyle')}
              />
              {!!isSilicon && (
                <Button
                  icon="camera"
                  content="Attach Photo"
                  onClick={() => act('PDA_selectPhoto')} />
              )}
              {!!virus_attach && (
                <Button
                  icon="bug"
                  color={sending_virus ? "bad" : null}
                  content={`Send Virus: ${sending_virus ? "Yes" : "No"}`}
                  onClick={() => act('PDA_toggleVirus')}
                />
              )}
            </Box>
          </Section>
        </Stack>
        {!!photo && (
          <Stack vertical mt={1}>
            <Section fill textAlign="center">
              <Icon name="camera" mr={1} />
              Current Photo
            </Section>
            <Section align="center">
              <Button
                onClick={() => act('PDA_clearPhoto')}>
                <Box
                  mt={1}
                  as="img"
                  src={photo ? photo : null}
                />
              </Button>
            </Section>
          </Stack>
        )}
        <Stack vertical mt={1}>
          <Section fill textAlign="center">
            <Icon name="address-card" mr={1} />
            Detected Messengers
          </Section>
        </Stack>
        <Stack vertical mt={1}>
          <Section fill>
            <Stack vertical>
              {messengers.map(messenger => (
                <Button
                  key={messenger.ref}
                  fluid
                  onClick={() => act('PDA_sendMessage', {
                    name: messenger.name,
                    job: messenger.job,
                    ref: messenger.ref,
                  })}>
                  {messenger.name} ({messenger.job})
                </Button>
              ))}
            </Stack>
            {!!canSpam && (
              <Button
                fluid
                mt={1}
                content="Send to all..."
                onClick={() => act('PDA_sendEveryone')}
              />
            )}
          </Section>
        </Stack>
        {(!owner && !isSilicon) && (
          <NoIDDimmer />
        )}
      </NtosWindow.Content>
    </NtosWindow>
  );
};
