import { useBackend } from '../backend';
import { Box, Section, Stack } from '../components';
import { Window } from '../layouts';
import { ObjectivesSection, Objective } from './common/ObjectiveSection';

type Info = {
  antag_name: string;
  objectives: Objective[];
  brothers: string;
};

const IntroSection = (_props, context) => {
  const { data } = useBackend<Info>(context);
  const { antag_name, brothers } = data;
  return (
    <Section>
      <h1 style={{ 'position': 'relative', 'top': '25%', 'left': '25%' }}>
        You are the{' '}
        <Box inline textColor="bad">
          {antag_name || 'Blood Brother'}
        </Box>
        of {brothers}!
      </h1>
    </Section>
  );
};

export const AntagInfoBrother = (_props, context) => {
  const { data } = useBackend<Info>(context);
  const { objectives } = data;
  return (
    <Window width={620} height={250} theme="syndicate">
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>
            <IntroSection />
          </Stack.Item>
          <Stack.Item>
            <ObjectivesSection objectives={objectives} />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
