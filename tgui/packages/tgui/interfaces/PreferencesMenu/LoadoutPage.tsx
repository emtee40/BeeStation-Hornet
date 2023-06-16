import { Box, Tabs, Button, Section, Stack, Flex, Table, Icon } from '../../components';
import { LoadoutGear, PreferencesMenuData } from './data';
import { useBackend, useLocalState } from '../../backend';
import { ServerPreferencesFetcher } from './ServerPreferencesFetcher';
import { CharacterPreview } from './CharacterPreview';

export const LoadoutPage = (props, context) => {
  const { act, data } = useBackend<PreferencesMenuData>(context);
  const { purchased_gear = [], equipped_gear = [], character_preferences, metacurrency_balance = 0, is_donator = false } = data;
  const jumpsuit_style = character_preferences.clothing.jumpsuit_style;
  return (
    <ServerPreferencesFetcher
      render={(serverData) => {
        if (!serverData) {
          return <Box>Loading loadout data...</Box>;
        }
        const { categories = [], metacurrency_name } = serverData.loadout;
        const [selectedCategory, setSelectedCategory] = useLocalState(context, 'category', categories[0].name);
        const [onlyPurchased, setOnlyPurchased] = useLocalState(context, 'only_purchased', false);

        let selectedCategoryObject = categories.filter((c) => c.name === selectedCategory)[0];

        const isPurchased = (gear: LoadoutGear) => purchased_gear.includes(gear.id) && !gear.multi_purchase;
        let currency_text = metacurrency_balance.toLocaleString() + ' ' + metacurrency_name + 's';

        return (
          <Stack height="100%">
            <Stack.Item>
              <Flex
                width="219px"
                mb={1}
                p={1}
                fontSize="22px"
                style={{ 'align-items': 'center' }}
                className="section-background">
                <Flex.Item>
                  <Button icon="undo" tooltip="Rotate" tooltipPosition="top" onClick={() => act('rotate')} />
                </Flex.Item>
                <Flex.Item grow textAlign="center" fontSize={Math.max(Math.min(19, 34 - currency_text.length), 13) + 'px'}>
                  {currency_text}
                </Flex.Item>
              </Flex>
              <CharacterPreview height="calc(100vh - 180px)" id={data.character_preview_view} />
            </Stack.Item>
            <Stack.Item grow height="100%">
              <Flex direction="column" height="100%">
                <Flex.Item>
                  <Tabs>
                    {categories
                      .filter((c) => c.name !== 'Donator' || is_donator)
                      .map((category) => (
                        <Tabs.Tab
                          key={category.name}
                          textAlign="center"
                          selected={selectedCategory === category.name}
                          onClick={() => setSelectedCategory(category.name)}>
                          {category.name}
                        </Tabs.Tab>
                      ))}
                    <Tabs.Tab
                      style={{ 'margin-left': 'auto' }}
                      textColor="lightgray"
                      onClick={() => setOnlyPurchased(!onlyPurchased)}>
                      <Icon name={onlyPurchased ? 'check-square-o' : 'square-o'} mr={1} />
                      Show Purchased Only
                    </Tabs.Tab>
                  </Tabs>
                </Flex.Item>
                <Flex.Item grow basis="content" height="0">
                  <Box
                    width="100%"
                    height="100%"
                    className="section-background"
                    style={{ padding: '0.66em 0.5em', 'overflow-y': 'scroll' }}>
                    <Table>
                      <Table.Row header>
                        <Table.Cell collapsing />
                        <Table.Cell>Name</Table.Cell>
                        {selectedCategory !== 'Donator' && (
                          <Table.Cell collapsing textAlign="center">
                            Cost
                          </Table.Cell>
                        )}
                        <Table.Cell style={{ 'min-width': '7rem' }} collapsing />
                      </Table.Row>
                      {selectedCategoryObject &&
                        selectedCategoryObject.gear
                          .filter((gear) => !onlyPurchased || isPurchased(gear))
                          .map((gear) => (
                            <Table.Row key={gear.id}>
                              <Table.Cell m={0} p={0}>
                                <Box
                                  inline
                                  className={`preferences_loadout32x32 loadout_gear___${gear.id}${
                                    jumpsuit_style === 'Jumpskirt' && gear.skirt_display_name ? '_skirt' : ''
                                  }`}
                                  style={{
                                    'vertical-align': 'middle',
                                    'horizontal-align': 'middle',
                                  }}
                                />
                              </Table.Cell>
                              <Table.Cell style={{ 'vertical-align': 'middle' }}>
                                {jumpsuit_style === 'Jumpskirt' && gear.skirt_display_name
                                  ? gear.skirt_display_name
                                  : gear.display_name}
                              </Table.Cell>
                              {selectedCategory !== 'Donator' && (
                                <Table.Cell collapsing textAlign="center">
                                  {gear.cost.toLocaleString()}
                                </Table.Cell>
                              )}
                              <Table.Cell textAlign="center">
                                <Button
                                  disabled={
                                    (!purchased_gear.includes(gear.id) && gear.cost > metacurrency_balance) ||
                                    (gear.donator && !is_donator) ||
                                    (isPurchased(gear) && !gear.is_equippable && !gear.multi_purchase)
                                  }
                                  tooltip={
                                    !purchased_gear.includes(gear.id) && gear.cost > metacurrency_balance
                                      ? 'Not Enough ' + metacurrency_name
                                      : null
                                  }
                                  content={
                                    isPurchased(gear)
                                      ? equipped_gear.includes(gear.id)
                                        ? 'Unequip'
                                        : !gear.is_equippable
                                          ? 'Purchased'
                                          : 'Equip'
                                      : 'Purchase'
                                  }
                                  onClick={() =>
                                    act(isPurchased(gear) ? 'equip_gear' : 'purchase_gear', {
                                      id: gear.id,
                                    })
                                  }
                                />
                              </Table.Cell>
                            </Table.Row>
                          ))}
                    </Table>
                  </Box>
                </Flex.Item>
              </Flex>
            </Stack.Item>
          </Stack>
        );
      }}
    />
  );
};
