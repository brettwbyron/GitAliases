# Kickoff Documentation

Kickoff is a framework for Jobvite CWS team to make starting a new site easier and quicker to setup. It uses SCSS, Gulp, and your favorite editor to make outputting stylesheets easy.

## Table of Contents
* [Package.json](package.md)
* [gulpfile.js](gulpfile.md)
* Components/
    * plugins/
        * [plugins.scss](components-plugins.md)
    * [buttons.scss](components-buttons.md)
    * [desktop.scss](components-desktop.md)
    * [forms.scss](components-forms.md)
    * [jv-classes.scss](components-jv-classes.md)
    * [links.scss](components-links.md)
    * [mobile.scss](components-mobile.md)
    * [sections.scss](components-sections.md)
* Elements/
    * [base.scss](elements-base.md)
* Objects/
    * [cssgrid.scss](objects-cssgrid.md)
    * [flex.scss](objects-flex.md)
    * [grid.scss](objects-grid.md)
* Settings/
    * [fonts.scss](settings-fonts.md)
    * [variables.scss](settings-variables.md)
* Tools/
    * [flex.scss](tools-flex.md)
    * [mixins.scss](tools-mixins.md)
* Utilities/
    * [media.scss](utilities-media.md)
    * [sizing.scss](utilities-sizing.md)
    * [spacing.scss](utilities-spacing.md)
    * [type.scss](utilities-type.md)

## Design Strategy

While we build career websites desktop-layout first then mobile, Kickoff is designed from a [mobile-first](http://mobile-first.abookapart.com/) approach. It helps to understand this when building your CWS. It will also help you effectively use the built-in classes in Kickoff.

### What does this mean?

When you are buildling layout, for example a grid with text and photos in it, think first about how you want it to appear on a mobile-device. See the following example.

```
<div class="grid">
    <div class="grid-item">Content 1</div>
    <div class="grid-item">Content 2</div>
    <div class="grid-item">Content 3</div>
</div>
```

On a phone you would probably want to show these items stacked vertically to allow the content to show nicely. Using Kickoff's built-in flex classes you would achieve this by adding `flex-col` to the `grid` div.

```
<div class="grid flex-col">
    <div class="grid-item">Content 1</div>
    <div class="grid-item">Content 2</div>
    <div class="grid-item">Content 3</div>
</div>
```

However, as the customers' screen gets larger, you have more space to display the items horizontally on a screen. Depending on the content of the `grid-item` div, decide what is the best breakpoint to change from vertical (flex-col) to horizontal (flex-row). This is done using one of the breakpoint modifiers for `flex-row`; `-sm`, `-md`, `-lg`, or `-xl`. In this example I'll use `-md`.

```
<div class="grid flex-col flex-row-md">
    <div class="grid-item">Content 1</div>
    <div class="grid-item">Content 2</div>
    <div class="grid-item">Content 3</div>
</div>
```

Now, with this added class, at the medium breakpoint the grid items will change from stacked to horizontal. Your breakpoints are set in the `settings/variables.scss` file. Play around with different modifiers to get the right look.

Maybe after a medium-breakpoint you want div's horizontally stacked but after a large-breakpoint you want it to go back to veritical again. You can do that by adding another modifier class.

```
<div class="grid flex-col flex-row-md flex-col-lg">
    <div class="grid-item">Content 1</div>
    <div class="grid-item">Content 2</div>
    <div class="grid-item">Content 3</div>
</div>
```

The modifiers can be nested too.

```
<div class="grid flex-col flex-row-md flex-col-lg">
    <div class="grid-item">
        <div class="flex-col flex-row-sm">
            <div class="grid-item">Content 1</div>
            <div class="grid-item">Content 2</div>
            <div class="grid-item">Content 3</div>
        </div>
    </div>
    <div class="grid-item">Content 2</div>
    <div class="grid-item">Content 3</div>
</div>
```

[Back to About Kickoff](../README.md)