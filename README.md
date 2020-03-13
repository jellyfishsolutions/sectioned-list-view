# sectioned_list_view

The `sectioned_list_view` package adds a simple sectioned list view to the flutter framework.
It's API is similar to the UITableView available on the iOS platform.

## Usage

You should specify a number of sections and a number of items for each section.
For each section, you should provide an `headerBuilder` function.
Finally, you should also provide an `itemBuilder` function, executed for each item.

```
SectionedListView(
    numberOfSection: () => this.numberOfSection(),
    numberOfRowsInSection: (int section) =>
        this.numberOfRowsInSection(section),
    headerBuilder: (BuildContext context, int section) =>
        this.headerBuilder(context, section),
    itemBuilder:
        (BuildContext context, int section, int index) =>
            this.itemBuilder(context, section, index))
```