import { Component, createRef, RefObject } from 'inferno';
import type { InfernoNode } from 'inferno';
import { Button, Section, Stack, Flex } from '../../components';
import { FlexProps } from '../../components/Flex';
import { CollapsibleSection } from 'tgui/components/CollapsibleSection';

type TabbedMenuProps = {
  categoryEntries: [string, InfernoNode][];
  contentProps?: FlexProps;
};

export class TabbedMenu extends Component<TabbedMenuProps> {
  categoryRefs: Record<string, RefObject<HTMLDivElement>> = {};
  sectionRef: RefObject<HTMLDivElement> = createRef();

  getCategoryRef(category: string): RefObject<HTMLDivElement> {
    if (!this.categoryRefs[category]) {
      this.categoryRefs[category] = createRef();
    }

    return this.categoryRefs[category];
  }

  render() {
    return (
      <Stack vertical fill>
        {this.props.children && <Stack.Item position="relative">{this.props.children}</Stack.Item>}
        {this.props.categoryEntries?.length > 1 && (
          <Stack.Item>
            <Stack fill px={5}>
              {this.props.categoryEntries.map(([category]) => {
                return (
                  <Stack.Item key={category} grow basis="content">
                    <Button
                      align="center"
                      fontSize="1.2em"
                      fluid
                      onClick={() => {
                        const offsetTop = this.categoryRefs[category].current?.offsetTop;

                        if (offsetTop === undefined) {
                          return;
                        }

                        const currentSection = this.sectionRef.current;

                        if (!currentSection) {
                          return;
                        }

                        currentSection.scrollTop = offsetTop;
                      }}>
                      {category}
                    </Button>
                  </Stack.Item>
                );
              })}
            </Stack>
          </Stack.Item>
        )}

        <Stack.Item
          grow
          innerRef={this.sectionRef}
          position="relative"
          overflowY="scroll"
          {...{
            ...this.props.contentProps,

            // Otherwise, TypeScript complains about invalid prop
            className: undefined,
          }}>
          <Flex direction="column" px={2}>
            {this.props.categoryEntries.map(([category, children]) => {
              return (
                <Flex.Item mb={2} key={category} innerRef={this.getCategoryRef(category)}>
                  <CollapsibleSection fill title={category} sectionKey={category}>
                    {children}
                  </CollapsibleSection>
                </Flex.Item>
              );
            })}
          </Flex>
        </Stack.Item>
      </Stack>
    );
  }
}
