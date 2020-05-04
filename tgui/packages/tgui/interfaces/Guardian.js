import { Fragment } from 'inferno';
import { Window } from '../layouts';
import { useBackend, useLocalState } from '../backend';
import { Button, LabeledList, Section, Tabs, Input, ColorBox } from '../components';

export const Guardian = (props, context) => {
  const { act, data } = useBackend(context);
  const [tab, setTab] = useLocalState(context, 'tab', 'general');
  return (
    <Window>
      <Window.Content scrollable>
        <LabeledList>
          <LabeledList.Item
            label="Points"
            color={data.points > 0 ? 'good' : 'bad'}>
            {data.points}
          </LabeledList.Item>
        </LabeledList>
        <Tabs>
          <Tabs.Tab
            icon="list"
            selected={tab === 'general'}
            onClick={() => setTab('general')}>
            General
          </Tabs.Tab>
          <Tabs.Tab
            icon="fist-raised"
            selected={tab === 'stats'}
            onClick={() => setTab('stats')}>
            Stats
          </Tabs.Tab>
          <Tabs.Tab
            icon="fire-alt"
            selected={tab === 'major'}
            onClick={() => setTab('major')}>
            Major Ability
          </Tabs.Tab>
          <Tabs.Tab
            icon="burn"
            selected={tab === 'minor'}
            onClick={() => setTab('minor')}>
            Secondary Ability
          </Tabs.Tab>
          <Tabs.Tab
            icon="plus-square"
            selected={tab === 'create'}
            onClick={() => setTab('create')}>
            Create/Overview
          </Tabs.Tab>
        </Tabs>
        {tab === 'general' && (
          <GuardianGeneral />
        )}
        {tab === 'stats' && (
          <GuardianStats />
        )}
        {tab === 'major' && (
          <GuardianMajor />
        )}
        {tab === 'minor' && (
          <GuardianMinor />
        )}
        {tab === 'create' && (
          <GuardianCreate />
        )}
      </Window.Content>
    </Window>
  );
};

const GuardianGeneral = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <LabeledList>
      <LabeledList.Item
        label="Name">
        <Input
          value={data.guardian_name}
          placeholder={data.name}
          onChange={(e, value) => act('name', {
            name: value,
          })} />
      </LabeledList.Item>
      <LabeledList.Item
        label="Color">
        <ColorBox color={data.guardian_color || "#FFFFFF"}
          mr={1}
          onClick={() => act('color')} />
      </LabeledList.Item>
      <LabeledList.Item>
        <Button
          icon="undo"
          content="Reset All"
          onClick={() => act('reset')}
        />
      </LabeledList.Item>
      <LabeledList.Item
        label="Attack Type">
        <Button
          content="Melee"
          selected={data.melee}
          onClick={() => act('melee')} />
        <Button
          content="Ranged"
          selected={!data.melee}
          disabled={data.melee && data.points < 3}
          onClick={() => act('ranged')} />
      </LabeledList.Item>
    </LabeledList>
  );
};

const GuardianStats = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <LabeledList>
      {data.ratedskills.map(skill => (
        <LabeledList.Item
          key={skill.name}
          className="candystripe"
          label={skill.name}>
          <Button
            content="A"
            selected={skill.level === 5}
            disabled={skill.level < 5 && data.points < 4}
            onClick={() => act('set', {
              name: skill.name,
              level: 5,
            })} />
          <Button
            content="B"
            selected={skill.level === 4}
            disabled={skill.level < 4 && data.points < 3}
            onClick={() => act('set', {
              name: skill.name,
              level: 4,
            })} />
          <Button
            content="C"
            selected={skill.level === 3}
            disabled={skill.level < 3 && data.points < 2}
            onClick={() => act('set', {
              name: skill.name,
              level: 3,
            })} />
          <Button
            content="D"
            selected={skill.level === 2}
            disabled={skill.level < 2 && data.points < 1}
            onClick={() => act('set', {
              name: skill.name,
              level: 2,
            })} />
          <Button
            content="F"
            selected={skill.level === 1}
            onClick={() => act('set', {
              name: skill.name,
              level: 1,
            })} />
        </LabeledList.Item>
      ))}
    </LabeledList>
  );
};

const GuardianMajor = (props, context) => {
  const { act, data } = useBackend(context);
  return data.abilities_major.map(ability => (
    <LabeledList.Item
      key={ability.name}
      className="candystripe"
      label={ability.name}
      labelColor={ability.requiem ? "gold" : null}>
      {ability.desc}<br />
      <Button
        content={ability.cost + " points"}
        selected={ability.selected}
        disabled={!ability.selected
          && (data.points < ability.cost || !ability.available)}
        onClick={() => act('ability_major', {
          path: ability.path,
        })} />
    </LabeledList.Item>
  ));
};

const GuardianMinor = (props, context) => {
  const { act, data } = useBackend(context);
  return data.abilities_minor.map(ability => (
    <LabeledList.Item
      key={ability.name}
      className="candystripe"
      label={ability.name}>
      {ability.desc}<br />
      <Button
        content={ability.cost + " points"}
        selected={ability.selected}
        disabled={!ability.selected
          && (data.points < ability.cost
            || !ability.available)}
        onClick={() => act('ability_minor', {
          path: ability.path,
        })} />
    </LabeledList.Item>
  ));
};

const GuardianCreate = (props, context) => {
  const { act, data } = useBackend(context);
  const number2grade = {
    1: "F",
    2: "D",
    3: "C",
    4: "B",
    5: "A",
  };
  return (
    <Fragment>
      <Section
        title="Appearance">
        <LabeledList>
          <LabeledList.Item label="Name">
            {data.guardian_name || data.name}
          </LabeledList.Item>
          <LabeledList.Item label="Color">
            <ColorBox color={data.guardian_color || "#FFFFFF"}
              mr={1} />
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section
        title="Stats">
        <LabeledList>
          {data.ratedskills.map(skill => (
            <LabeledList.Item
              key={skill.name}
              className="candystripe"
              label={skill.name}>
              {number2grade[skill.level]}
            </LabeledList.Item>
          ))}
        </LabeledList>
      </Section>
      {!data.no_ability && (
        <Section
          title="Major Ability">
          <LabeledList>
            {data.abilities_major.map(ability => (
              (!!ability.selected && (
                <LabeledList.Item
                  key={ability.name}
                  label={ability.name}>
                  {ability.desc}
                </LabeledList.Item>
              ))
            ))}
          </LabeledList>
        </Section>
      )}
      <Section
        title="Minor Abilities">
        <LabeledList>
          {data.abilities_minor.map(ability => (
            (!!ability.selected && (
              <LabeledList.Item
                key={ability.name}
                className="candystripe"
                label={ability.name}>
                {ability.desc}
              </LabeledList.Item>
            ))
          ))}
        </LabeledList>
      </Section>
      <Button
        content={"Summon " + data.name}
        style={{
          width: '100%', 'text-align': 'center',
          position: 'fixed', bottom: '12px',
        }}
        onClick={() => act('spawn')} />
    </Fragment>
  );
};
