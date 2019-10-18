# DBpedia Lookup 2016

[![Build Status](https://travis-ci.org/dbpedia/lookup.svg?branch=master)](https://travis-ci.org/dbpedia/lookup)

DBpedia Lookup is a web service that can be used to look up DBpedia URIs by related keywords. Related means that either the label of a resource matches, or an anchor text that was frequently used in Wikipedia to refer to a specific resource matches (for example the resource http://dbpedia.org/resource/United_States can be looked up by the string "USA"). The results are ranked by the number of inlinks pointing from other Wikipedia pages at a result page.

## Web APIs

Two APIs are offered: Keyword Search and Prefix Search. A hosted version of the Lookup service is available on the DBpedia server infrastructure.

### Keyword Search

The Keyword Search API can be used to find related DBpedia resources for a given string. The string may consist of a single or multiple words.

Example: Places that have the related keyword "berlin"

http://lookup.dbpedia.org/api/search/KeywordSearch?QueryClass=place&QueryString=berlin

### Prefix Search (i.e. Autocomplete)

The Prefix Search API can be used to implement autocomplete input boxes. For a given partial keyword like *berl* the API returns URIs of related DBpedia resources like http://dbpedia.org/resource/Berlin.

Example: Top five resources for which a keyword starts with "berl"

http://lookup.dbpedia.org/api/search/PrefixSearch?QueryClass=&MaxHits=5&QueryString=berl

### Parameters

The query parameters accepted by the endpoints are

* `QueryString`: a string for which a DBpedia URI should be found.
* `QueryClass`: a DBpedia class from the Ontology that the results should have (for owl#Thing and untyped resource, leave this parameter empty).
* `MaxHits`: the maximum number of returned results (default: 5)

### JSON support

By default all data is returned as XML, the service also retuns JSON to any request including the `Accept: application/json` header.

## Running a local mirror of the webservice

### Clone and build DBpedia Lookup

    git clone git://github.com/dbpedia/lookup.git
    cd lookup
    mvn clean install


## Rebuilding the index

    Rebuilding an index is required if you want to use the 2016 version of DBPedia.

    To re-build the index you will require

    * DBpedia datasets


    ### Get the following DBpedia datasets
    from http://downloads.dbpedia.org/2016-10/core-i18n/en/

    * redirects\_en.ttl (Redirects are not indexed, but they are excluded as targets of lookup.)
    * short\_abstracts\_en.ttl
    * instance\_types\_en.ttl  --> it is beter to rename this one to: core_instances.ttl
    * article\_categories\_en.ttl

    from http://downloads.dbpedia.org/2016-10/core/

    * instance_types_en.ttl
    * instance_types_lhd_dbo_en.ttl
    * instance_types_transitive_en.ttl  

    ### Concatenate all data and sort by URI

    This is necessary because indexing in sorted order is significantly faster.

          cat core_instances.ttl  \
              short_abstracts_en.ttl \
              article_categories_en.ttl \
              instance_types_en.ttl  \
              instance_types_lhd_dbo_en.ttl \
              instance_types_transitive_en.ttl | sort >all_dbpedia_data..ttl

### Run Indexer

    The indexer has to be run twice:

    1. with the DBpedia data

            ./run Indexer lookup_index_dir redirects_en..ttl all_dbpedia_data.nt .ttl

    (this code will make the segementation files needed to run dbpeida lookup)

### Run the server


    `./run Server lookup_index_dir`

    lookup_index_dir is the directory created by Run Indexer (previous step)
    E.g:

    `./run Server ..`


#### Available languages (i18n working in progress):

* en - English

but you can change the language by indexing other files

The server should now be running at http://localhost:1111


## Support and feedback

The best way to get support or give feedback on the Lookup project is via the [DBpedia discussion mailing list](https://lists.sourceforge.net/lists/listinfo/dbpedia-discussion). More technical queries about the code base should be directed to the [DBpedia developers mailing list](https://lists.sourceforge.net/lists/listinfo/dbpedia-developers).

The [DBpedia wiki](http://wiki.dbpedia.org/lookup/) also has useful information on the project.

## Maintainers

* Kunal Jha [@Kunal-Jha](https://github.com/Kunal-Jha)
* Sandro Coelho [@sandroacoelho](https://github.com/sandroacoelho)
* Pablo Mendes [@pablomendes](https://github.com/pablomendes) (less active)
* Max Jakob [@maxjakob](https://github.com/maxjakob) (less active)
* Matt Haynes [@matth](https://github.com/matth) (less active)
