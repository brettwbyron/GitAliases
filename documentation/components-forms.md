# components/forms.scss

Use this file to edit styles for search and application forms.

## Search Form

Most of the time on desktop we want the search form inputs layed out horiontally. Using the `.jv-form-inline-md` class on the `.jv-search-form` element will allow for horizontal layouts on screens larger than medium.

```
#macro (facetedSearchForm)
    #if ($jvEnableFacetedSearch)
        <form class="jv-search-form jv-form jv-faceted-search-keyword jv-form-inline-md" action="${careersiteBaseUrl}/search" method="get" ng-controller="facetedSearchController">
```

This isn't always what you need so take care to use the right classes. 

[Back to home](README.md)