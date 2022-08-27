import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mine_notes/cubits/cubits.dart';
import 'package:mine_notes/widgets/widgets.dart';

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({Key? key}) : super(key: key);

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Sheet holder.
          const SheetHolderWidget(),

          const SizedBox(height: 16),

          // Header row.
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title.
                const Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // Close button.
                IconButton(
                  alignment: Alignment.centerRight,
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
          // Search input.
          ClipRRect(
            // Make the input field round.
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.white,
              child: TextField(
                controller: _searchController,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 1,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Iconsax.search_normal),
                  hintText: 'Search...',
                ),
                onChanged: (String value) async {
                  setState(() {
                    query = value;
                  });

                  // Get search results.
                  BlocProvider.of<AppDataCubit>(context)
                      .retrieveSearchResults(query: query);
                },
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Search results.
          BlocBuilder<AppDataCubit, AppDataState>(
            builder: (context, state) {
              if (state is AppDataInitial) {
                // TODO: Show initial image
                // Show initial image.
                return const SizedBox();
              } else if (state is AppDataLoading) {
                // Show loading indicator.

                return const Center(child: CircularProgressIndicator());
              } else if (state is AppDataSearchResults) {
                // Show search results.

                return Expanded(
                  // Search results.
                  child: ListView.builder(
                    itemCount: state.searchResult.length,
                    itemBuilder: (context, index) {
                      // Iterate through the search results.
                      final Map<String, Object?> resultItem =
                          state.searchResult[index];

                      // Build a list item for each search result.
                      return _buildResultItem(resultItem, context);
                    },
                  ),
                );
              } else {
                // If something went wrong.

                return const SizedBox();
              }
            },
          )
        ],
      ),
    );
  }

  Container _buildResultItem(
      Map<String, Object?> resultItem, BuildContext context) {
    return Container(
      // Margin between list items.
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        // Title.
        title: Text(
          resultItem['title'].toString(),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),

        // Subtitle.
        subtitle: Text(
          resultItem['content'].toString(),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),

        // Trailing icon.
        trailing: Icon(
          resultItem['isPinned'] != null ? Icons.star : Icons.star_border,
          color: Colors.yellowAccent,
        ),

        // OnTap.
        onTap: () {
          // Check if the item is a note or a category.
          if (resultItem['type'] == 'note') {
            // Navigate to the note page.
            // TODO: Add Edit page to open result.
          } else if (resultItem['type'] == 'category') {
            // TODO: Open category.
            // Navigate to the category page.
          }
        },
      ),
    );
  }
}
