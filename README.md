# Roberto Cano Blog sources

This blog is based on the **So Simple Theme** from designer slash illustrator [Michael Rose](http://mademistakes.com). The original theme
can be found [here](http://mmistakes.github.io/so-simple-theme/) hosted on GitHub.

Some modifications have been made to the theme, removing all unwanted functionality and adding support for multilingual
site. In order to do this the theme templates and layouts have been modified to include the appropiate translations
from the translations.yml file. Also the original Jekyll plugin for pagination has been modified to paginate categories,
allowing for each separate category to have its own pagination. Two main categories are used **en** and **es** to achieve
multilingual pagination. Then tags are used to organize the website.

Due to GitHub restrictions on Jekyll compilation, done in *safe* mode, the compilation of this website has to be done
locally and then the result uploaded to GitHub. This is done by maintaining a **source** branch containing the source
files for Jekyll generation and then the live website in the **master** branch. To indicate to GitHub that no
compilation must be performed the hint file .nojekyll is included in the root of the **source** branch.

## Using this website

To use this website first fork it into your own repository.

Then you can adjust the following things:

  * In \_config.yml file:
    * The title section is a multilanguage section, change accordingly
    * paginate_per_category contains the number of posts per page per category
    * paginate_root_category indicates which category index.html file will be copied to the root of the site
    * The defaults section applies a default language to the category folder. If adding a new language
      you must update this section. Please note that the language names given in this section will be the
      ones used as a key throughout the entire website. No assumptions are made on language code (like **en** or **fr**)
  * Create a new category folder per language. This folder must include an index.html file that will
    present the language main page and a \_posts folder containing all the language posts
  * \_data/navigation.yml contains the main menu layout per language
  * The \_data/translations.yml contain translations for some elements of the site. Please update accordingly for
    your new languages
    
Compile and use!

The website is based on Jekyll 2.4.3 and the pagination plugin is 1.1.0, modified to suit the categories
pagination. If Jekyll version is different it may not work properly.

Enjoy!
