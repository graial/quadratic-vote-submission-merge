# Quadratic voting proposal merge-tool

This tool provides a read-only calculator for a Quadratic vote implemented via tokenlog. It was conceived during the [Commons Prize](https://medium.com/commonsstack/announcing-the-commons-prize-d3df343c37a9) (whose tokenlog results can be found [here](https://tokenlog.xyz/commons-stack/commonsprize)) as a way to facilitate the merging of proposals "in-flight" during a quadratic voting race.

While not explicitly forbidden by any stated rules, this merging of proposals was not contemplated prior to the CommonsPrize vote.  As such, this script has been posted to illustrate & advocate for the principle.

In short, a few climate-solution oriented submissions are electing to merge our submissions because we believe that the submissions are stronger together than separate and also because we believe the causes are worth continuing to race for.

While there are currently no stated rules around submission merges, a couple choices have been made proactively to maintain the integrity of the quadratic voting computation and maintain a level playing field.

1. Quadratic voting causes each successive vote from a single voter to be exponentially more expensive in 'voting power'.  To prevent gaming, this computation, the max votes from all merged solutions is selected.
2. This script has been posted open source so that other submissions may also use it to verify our computations and also to evaluate the votes that their own submission might gain from a merger.

## Usage
*note: you need ruby installed to use this or use and [online interpreter](https://replit.com/languages/ruby)*

### 1. Fetch voting data
**not yet functional, requires tokenlog fix** use `get_votes.rb` to download the current votes cast in your election via the stats page.  For example
`https://tokenlog.xyz/commons-stack/commonsprize/stats`
*temporary fix is to visit the site manually,* 
- click `Show/Hide`
- `ctrl-a`
- `ctrl-c`
- `ctrl-v` into a doc in your project's `data` folder
- remove non-json text above and below the pasted snippet
- save

### 2. Convert json vote data into a csv
Use `json_to_csv.rb`. This makes it easy to load into a spreadsheet, if you'd like to explore the data in more detail 

### 3. Run the merge tool and fetch your results
Open `submissions.csv` to and take note of the numbers for which submissions you prefer to merge.  Add those numbers to the `submissions` array of `main.rb` then run `main.rb`.
Your results will then be posted to the folder `data/outputs`

## Testing
some rspec tests have been written to constrain the format of the input (which may be subject to change) and the output.  First run `bundle install` to set up, then run `rspec` to ensure the tests pass
