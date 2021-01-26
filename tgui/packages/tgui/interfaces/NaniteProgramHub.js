import { map } from "common/collections";
import { Fragment } from "inferno";
import { useBackend, useSharedState } from "../backend";
import {
  Box,
  Flex,
  Icon,
  Tabs,
  Button,
  Section,
  NoticeBox,
  LabeledList,
} from "../components";
import { Window } from "../layouts";

export const NaniteProgramHub = (props, context) => {
  const { act, data } = useBackend(context);
  const { detail_view, disk, has_disk, has_program, programs = {} } = data;
  const [selectedCategory, setSelectedCategory] = useSharedState(
    context,
    "category"
  );
  const programsInCategory = (programs && programs[selectedCategory]) || [];
  return (
    <Window resizable width={650} height={700}>
      <Window.Content>
        <Section
          title="Program Disk"
          grow={1}
          overflowY="scroll"
          buttons={
            <Fragment>
              <Button
                icon="eject"
                content="Eject"
                disabled={!has_disk}
                onClick={() => act("eject")}
              />
              <Button
                icon="minus-circle"
                content="Delete Program"
                disabled={!has_disk || disk.name === undefined || !has_program}
                onClick={() => act("clear")}
              />
            </Fragment>
          }>
          {has_disk ? (
            has_program ? (
              disk.name === undefined ? ( // This is dirty but it's not updating
                <NoticeBox>No Program Installed</NoticeBox>
              ) : (
                <LabeledList>
                  <LabeledList.Item label="Program Name">
                    {disk.name}
                  </LabeledList.Item>
                  <LabeledList.Item label="Description">
                    {disk.desc}
                  </LabeledList.Item>
                </LabeledList>
              )
            ) : (
              <NoticeBox>No Program Installed</NoticeBox>
            )
          ) : (
            <NoticeBox>Insert Disk</NoticeBox>
          )}
        </Section>
        <Section
          title="Programs"
          buttons={
            <Fragment>
              <Button
                icon={detail_view ? "info" : "list"}
                content={detail_view ? "Detailed" : "Compact"}
                onClick={() => act("toggle_details")}
              />
              <Button
                icon="sync"
                content="Sync Research"
                onClick={() => act("refresh")}
              />
            </Fragment>
          }>
          {programs !== null ? (
            <Flex grow={4}>
              <Flex.Item grow={1} mr={2} minWidth="150px">
                <Tabs vertical>
                  {map((cat_contents, category) => {
                    const progs = cat_contents || [];
                    // Backend was sending stupid data that would have been
                    // annoying to fix
                    const tabLabel = category.substring(0, category.length - 8);
                    return (
                      <Button
                        grow
                        mb={2}
                        color="grey"
                        key={category}
                        icon="microchip"
                        content={tabLabel}
                        selected={category === selectedCategory}
                        onClick={() => setSelectedCategory(category)}
                      />
                    );
                  })(programs)}
                </Tabs>
              </Flex.Item>
              <Flex.Item grow={3} overflowY="scroll">
                {detail_view ? (
                  programsInCategory.map(program => (
                    <Section
                      key={program.id}
                      title={program.name}
                      level={2}
                      buttons={
                        <Button
                          mr={2}
                          height={2}
                          icon="download"
                          content="Download"
                          disabled={!has_disk}
                          onClick={() =>
                            act("download", {
                              program_id: program.id,
                            })}
                        />
                      }>
                      {program.desc}
                    </Section>
                  ))
                ) : (
                  <LabeledList>
                    {programsInCategory.map(program => (
                      <Box key={program.id}>
                        <LabeledList.Item
                          label={program.name}
                          buttons={
                            <Button
                              mt={1}
                              mr={2}
                              icon="download"
                              content="Download"
                              disabled={!has_disk}
                              onClick={() =>
                                act("download", {
                                  program_id: program.id,
                                })}
                            />
                          }
                        />
                        <LabeledList.Divider />
                      </Box>
                    ))}
                  </LabeledList>
                )}
              </Flex.Item>
            </Flex>
          ) : (
            <NoticeBox>No nanite programs are currently researched.</NoticeBox>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
