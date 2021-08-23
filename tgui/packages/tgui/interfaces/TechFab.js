import { useBackend, useLocalState } from '../backend';
import { Stack, Collapsible, Tooltip, Icon, Box, Button, LabeledList, Input, Section, Flex, Table, NoticeBox } from '../components';
import { Window } from '../layouts';
import { Fragment } from 'inferno';
import { capitalize, createSearch } from 'common/string';
import { sendLogEntry } from 'tgui-dev-server/link/client';

export const TechFab = (props, context) => {
  return (
    <Window
      width={590}
      height={550}>
      <Window.Content>
        <Stack vertical fill>
          <TechFabTopBar />
          <TechFabHeader />
          <TechFabContent />
        </Stack>
      </Window.Content>
    </Window>
  );
};

const TechFabTopBar = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    busy,
    efficiency,
  } = data;
  const [
    search,
    setSearch,
  ] = useLocalState(context, "search", "");

  return (
    <Stack.Item>
      <Section>
        <Flex align="baseline" wrap="wrap">
          <Flex.Item mx={0.5}>
            {"Search: "}
            <Input
              align="right"
              value={search}
              onInput={(e, value) => {
                setSearch(value);
              }} />
          </Flex.Item>
          <Flex.Item mx={0.5}>
            <Button
              content="Synchronize research"
              onClick={() => act("sync_research")}
            />
          </Flex.Item>
          <Flex.Item mx={0.5} grow>
            Efficiency: {Math.floor(efficiency*100)}%
          </Flex.Item>
          <Flex.Item px={1.5} color={busy ? "red" : "green"}>
            {busy ? "Busy " : "Ready "}
            <Icon name={busy ? "spinner" : "check-circle-o"} spin={busy} />
          </Flex.Item>
        </Flex>
      </Section>
    </Stack.Item>
  );
};

const formatBigNumber = (number, digits) => {
  const unsafeDigitCount = Math.floor(Math.log10(number));
  const digitCount = isFinite(unsafeDigitCount) ? unsafeDigitCount : 0;
  const exponent = digitCount > digits
    ? Math.pow(10, digitCount-digits)
    : Math.pow(10, Math.max(0, digits-digitCount));

  if (digitCount > digits)
  {
    number = Math.floor(number/exponent);
    return number + "e+" + (digitCount-digits);
  }
  else
  {
    return Math.round(number*exponent)/exponent;
  }
};

const Material = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    material,
  } = props;

  const material_dispense_amounts = [1, 10, 50];

  return (
    <Flex.Item width="50%" my="1px">
      <Flex justify="space-between" px={1} align="baseline">
        <Flex.Item width="100%">
          {capitalize(material.name)}
        </Flex.Item>
        <Flex.Item grow>
          <Flex>
            <Flex.Item shrink px={1}>
              {formatBigNumber(material.amount, 4)}
            </Flex.Item>
            <Flex.Item >
              <Flex className="TechFab__ButtonsContainer">
                {material_dispense_amounts.map(amount =>
                  (
                    <Flex.Item key={material.id+amount}>
                      <Button
                        className="TechFab__NumberButton"
                        content={amount}
                        disabled={material.amount < amount}
                        onClick={() => act("ejectsheet", {
                          material_id: material.id,
                          amount: amount,
                        })}
                      />
                    </Flex.Item>
                  )
                )}
              </Flex>
            </Flex.Item>
          </Flex>
        </Flex.Item>
      </Flex>
    </Flex.Item>
  );
};

const Reagent = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    reagent,
  } = props;

  return (
    <Flex.Item width="50%" className="TechFab__Reagent">
      <Flex justify="space-between" align="baseline">
        <Flex.Item grow px={1}>
          {reagent.name}
        </Flex.Item>
        <Flex.Item shrink px={1}>
          {formatBigNumber(reagent.volume, 4)}
        </Flex.Item>
        <Flex.Item>
          <Button content="Purge" onClick={() => act("dispose", {
            reagent_id: reagent.id,
          })} />
        </Flex.Item>
      </Flex>
    </Flex.Item>
  );
};

const TechFabHeader = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    materials = {},
    materials_label = "0/unlimited",
    reagents = {},
    reagents_label = "",
  } = data;

  return (
    <Stack.Item>
      <Section>
        <Collapsible
          title={"Materials ("+materials_label+")"}
          disabled={materials === null}>
          <Flex wrap="wrap" align="baseline">
            {
              materials && Object.keys(materials).map(id => {
                const material = materials[id];

                return (
                  <Material key={id} material={material} />
                );
              })
            }
          </Flex>
        </Collapsible>
        <Collapsible
          title={"Reagents ("+reagents_label+")"}
          disabled={materials === null}
          buttons={<Button
            content="Purge all" 
            onClick={() => act("disposeall")}
          />}>
          <Flex wrap="wrap" align="baseline">
            {
              (reagents && Object.keys(reagents).length>0)
                ? Object.keys(reagents).map(id => {
                  const reagent = reagents[id];

                  return (
                    <Reagent key={id} reagent={reagent} />
                  );
                })
                : (
                  <Flex.Item width="100%">
                    <NoticeBox info>
                      Reagent storage empty
                    </NoticeBox>
                  </Flex.Item>
                )
            }
          </Flex>
        </Collapsible>
      </Section>
    </Stack.Item>
  );
};

const ConditionalTooltip = (props, context) => {
  const {
    condition,
    children,
    ...rest
  } = props;

  if (!condition || true) // TOOLTIPS DISABLED DUE TO PERFORMANCE LIMITATIONS
  // Turns out, tooltips just don't run well right now in the amounts you'd get
  // in protolathes/circuit imprinters
  // See https://github.com/tgstation/tgstation/pull/60995
  {
    return children;
  }
  
  return (
    <Tooltip {...rest}>
      {children}
    </Tooltip>
  );
};

const Recipe = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    materials,
    reagents,
    efficiency,
    stack_to_mineral,
  } = data;
  const {
    recipe,
  } = props;

  const craft_amounts = [1, 5, 10, 50];
  const substitutions = { "bluespace crystal": "bluespace_crystal" };

  let max = 50;

  const material_objects = Object.keys(recipe.materials).map(id => {
    const material = materials[id] || materials[substitutions[id]];
    const total = material.amount;
    const amountNeeded = Math.floor(recipe.materials[id]
      / (recipe.efficiency_affects ? efficiency : 1))
      /stack_to_mineral;

    const mat_max = Math.floor(total/amountNeeded);
    max = Math.min(max, mat_max);
    return (
      <Box inline key={recipe.id+id} color={mat_max < 1 ? "red" : null}>
        {amountNeeded} {material.name}
      </Box>
    );
  });

  const reagent_objects = Object.keys(recipe.reagents).map(id => {
    const reagent = reagents[id];
    const total = reagent?.volume || 0;
    const recipeReagent = recipe.reagents[id];
    const amountNeeded = Math.floor(recipeReagent.volume 
      / (recipe.efficiency_affects ? efficiency : 1));
    const mat_max = Math.floor(total/amountNeeded);
    max = Math.min(max, mat_max);
    return (
      <Box inline key={recipe.id+id} color={mat_max < 1 ? "red" : null}>
        {amountNeeded} {recipeReagent.name}
      </Box>
    );
  });

  const reducefn = (list, cur) => {
    list.push(" | ");
    list.push(cur);
    return list;
  };

  return (
    <Flex.Item className="candystripe">
      <Flex align="center">
        <ConditionalTooltip
          condition={recipe.description && recipe.description !== "Desc"}
          content={recipe.description}
          position="bottom-end">
          <Flex.Item position="relative" width="100%">
            <Box>
              {recipe.name}
            </Box>
            <Box color="lightgray">
              {
                reagent_objects
                  .reduce(reducefn, material_objects
                    .reduce(reducefn, []))
                  .slice(1)
              }
            </Box>
          </Flex.Item>
        </ConditionalTooltip>
        <Flex.Item grow>
          <Flex className="TechFab__ButtonsContainer">
            {
              craft_amounts.map(amount => {
                return (
                  <Flex.Item key={recipe.id+amount}>
                    <Button
                      className="TechFab__NumberButton"
                      content={"x"+amount}
                      disabled={amount>max}
                      onClick={() => act("build", 
                        { "design_id": recipe.id, "amount": amount }
                      )}
                    />
                  </Flex.Item>
                );
              })
            }
          </Flex>
        </Flex.Item>
      </Flex>
    </Flex.Item>
  );
};

const TechFabContent = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    categories = [],
    recipes = [],
  } = data;
  const [
    search,
    setSearch,
  ] = useLocalState(context, "search", "");
  const [
    category,
    setCategory,
  ] = useLocalState(context, "category", null);

  const testSearch = createSearch(search, recipe => {
    return recipe.name;
  });

  const recipesDisplayed = search.length > 0
    ? recipes.filter(testSearch)
    : category
      ? recipes.filter(recipe => recipe.category.includes(category))
      : null;

  if (recipesDisplayed)
  {
    return (
      <Stack.Item grow>
        <Section grow fill scrollable
          title={search.length>0 ? "Search" : category}
          buttons={(
            <Button icon="backspace" content="Back"
              onClick={() => search.length>0 
                ? setSearch("") 
                : setCategory(null)} />
          )}>
          <Flex direction="column">
            {
              recipesDisplayed.map(recipe => {
                return (
                  <Recipe key={recipe.id} recipe={recipe} />
                );
              })
            }
          </Flex>
        </Section>
      </Stack.Item>
    );
  }
  else
  {
    return (
      <Stack.Item grow>
        <Section title="Categories" grow fill scrollable>
          <Flex wrap="wrap" justify="space-between" align="center">
            {
              categories.map(category => {
                return (
                  <Flex.Item key={category} minWidth="50%" p={0.2}>
                    <Button
                      content={category}
                      width="100%"
                      onClick={() => setCategory(category)}
                    />
                  </Flex.Item>
                );
              })
            }
          </Flex>
        </Section>
      </Stack.Item>
    );
  }
};