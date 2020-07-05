/*
 * This is a manifest file that'll be compiled into application.css, which will include all the files
 * listed below.
 *
 * Any CSS and SCSS file within this directory, lib/assets/stylesheets, vendor/assets/stylesheets,
 * or vendor/assets/stylesheets of plugins, if any, can be referenced here using a relative path.
 *
 * You're free to add application-wide styles to this file and they'll appear at the top of the
 * compiled file, but it's generally better to create a new file per style scope.
 *
 * require_self
 * require non-responsive
 * require parsley
 */

/*@import "bourbon";*/

/**** Load Fonts ****/

//@include font-face(LuxiMonoBold, 'luximb-webfont-westernlatin', bold, normal);
//@include font-face(LuxiMonoRegular, 'luximr-webfont', normal, normal);
/*
@include font-face(LuxiMonoOblique, 'luximri-webfont', normal, italic, $asset-pipeline: true);
@include font-face(LuxiMonoBoldOblique, 'luximbi-webfont', bold, italic, $asset-pipeline: true);
*/

/**** Bootstrap setup ****/

$font-family-base: "Roboto";
$grid-columns: 6; /* column width: 144px */
$grid-gutter-width: 16px;

$text-color:						black;
$brand-primary:         #F50015;
$special-color:					#19CBFA;
$special-background-color: rgba(24, 190, 232, 0.80);
/*
$brand-success:         #5cb85c !default;
$brand-info:            #5bc0de !default;
$brand-warning:         #f0ad4e !default;
$brand-danger:          #d9534f !default;
*/

$link-color:            inherit;
$link-hover-color:      $brand-primary;

/*
$screen-xs: 1024px;
$screen-sm: 1024px;
$screen-md: 1024px;
$screen-lg: 1024px;

$container-margin: 16; // margin left and right, so the vertical menu can fit in

$container-tablet:             ((960px + $grid-gutter-width));
$container-desktop:            ((960px + $grid-gutter-width));
$container-large-desktop:      ((960px + $grid-gutter-width));
*/

//@import "bootstrap";
//@import "editable/bootstrap-editable";
//@import "editable/inputs-ext/bootstrap-wysihtml5";
//@import "editable/inputs-ext/wysiwyg-color";

/**** Variables ****/

$vertical-menu-width: 555px;
$overall-container-margin: 32px; /* margin for vertical secondary menu */
$line-height: 1.45em;
$vertical-box-padding: 0.3em;
$klappfenster-bottom-distance: 4.2 * $line-height;

/**** General Styles ****/

h1,h2,h3,h4,h5,ol {
	margin:0;
	padding:0;
}

h1,h2,h3,h4 {
	font-size: 1em;
}


p {
	margin-bottom: 1em;
}

p:last-of-type, p:empty, .line2 p:not(:empty):last-of-type {
	margin-bottom: 0; /* for editables */
}

a:hover, a:focus {
		text-decoration: none;
		cursor: pointer;
}

#content {
	line-height: $line-height;
	font-size: 1em;
}

a abbr[title] {
	cursor:pointer;
}

abbr[title] {
	border:none;
	cursor:default;
}

.open-close-shade {
	position:relative;
}

.open-close-shade.shaded {
	/*opacity:0.4;*/
}

.not-overflown .if-overflown {
	display:none;
}

ul, li {
	margin:0;
	padding:0;
	list-style-type: none;
}

/**** Mixins ****/

@mixin menu-font($font-size) {
	font-family: "LuxiMonoBold", Georgia, serif;
	letter-spacing: 2px;
	font-size: $font-size;
}

@mixin border-line($border-position, $border-color) {
	content: " ";
	display:block;
	@if $border-position == "top" {
		border-top:1px solid $border-color;
	}
	@else {
		border-bottom:1px solid $border-color;
	}
}

@mixin facebook-link($font-size) {
	@include menu-font($font-size);
	color:#00d2ff !important;
	font-family: "LuxiMonoRegular";
	&:hover {
		//color:#3b5998 !important;
	}	
}

/**** Layout rows/columns ****/

#header, #headlines, .headlines {
	@include make-row();
}

#language-logo {
	@include make-xs-column(1);
}

#top-menu {
	@include make-xs-column(5);
}

.basic {
	@include make-xs-column(4);
	@include make-xs-column-push(2);
}

.details {
	@include make-xs-column(2);
	@include make-xs-column-pull(4);
}

.event-calendar .basic {
	@include make-xs-column(5);
	@include make-xs-column-push(1);
}

.event-calendar .details {
	@include make-xs-column(1);
	@include make-xs-column-pull(5);
}

/**** Layout spacing/position ****/

body {
	min-height: $vertical-menu-width;
	overflow-y: scroll;
}

#overall-container {
	width:1024px;
	overflow:hidden;
	min-height: $vertical-menu-width;
	margin: 0 auto;
	padding: (2 * $vertical-box-padding) $overall-container-margin (3 * $line-height) $overall-container-margin;
}

#header {
	margin-bottom:40px;
	body:not(.start) & {
		position:relative;
	}
}

#content-container {
	overflow:hidden;
	width:100%;
	position:relative;
	top:50px; /* would be 3.6em */
}

.start #content-container {
	top: 20px; /* would be $line-height, but it doesnt round to integer, causing a jump by one pixel when js executes */
}

.cache {
	overflow-y:hidden;
}

/**** background ****/

.site-background:after, .site-background:before {
	position:fixed;
	top:0;
	left:0;
	width:100%;
	height:100%;
}

.site-background:after {
	z-index:-2;
	/*background-image: url("http://www.ruhrnachrichten.de/storage/pic/mdhl/artikelbilder/lokales/mz-mlz-evz-gz/mslo/msfe/2844603_3_111129ms-ku-tanzFoto_275_a.jpg?version=1387197953");*/
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
	filter: alpha(opacity=12);
	opacity:0.12;
}

.site-background.with-transition:after {
	@include transition(opacity 0.5s linear);
}

.site-background.strong:after {
	opacity:1;
}

.site-background:before {
	z-index:-1;
}

.site-background:before {
	background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iI2ZmZmZmZiIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiNmZmZmZmYiIHN0b3Atb3BhY2l0eT0iMC4zMyIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
	background: -moz-linear-gradient(top,  rgba(255,255,255,1) 0%, rgba(255,255,255,0.15) 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(255,255,255,1)), color-stop(100%,rgba(255,255,255,0.15))); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top,  rgba(255,255,255,1) 0%,rgba(255,255,255,0.15) 100%); /* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top,  rgba(255,255,255,1) 0%,rgba(255,255,255,0.15) 100%); /* Opera 11.10+ */
	background: -ms-linear-gradient(top,  rgba(255,255,255,1) 0%,rgba(255,255,255,0.15) 100%); /* IE10+ */
	background: linear-gradient(to bottom,  rgba(255,255,255,1) 0%,rgba(255,255,255,0.15) 100%); /* W3C */
}

/* begin legacy: manual gradient for IE < 11, currently not used */

.legacy.site-background.weak:before {
	background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iI2ZmZmZmZiIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiNmZmZmZmYiIHN0b3Atb3BhY2l0eT0iMC45MiIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
	background: -moz-linear-gradient(top,  rgba(255,255,255,1) 0%, rgba(255,255,255,0.88) 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(255,255,255,1)), color-stop(100%,rgba(255,255,255,0.88))); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top,  rgba(255,255,255,1) 0%,rgba(255,255,255,0.88) 100%); /* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top,  rgba(255,255,255,1) 0%,rgba(255,255,255,0.88) 100%); /* Opera 11.10+ */
	background: -ms-linear-gradient(top,  rgba(255,255,255,1) 0%,rgba(255,255,255,0.88) 100%); /* IE10+ */
	background: linear-gradient(to bottom,  rgba(255,255,255,1) 0%,rgba(255,255,255,0.88) 100%); /* W3C */
}

/* end legacy */

/**** Top Menu: Language Select ****/

.no-text-transform {
	text-transform: none;
}

#language-select {
	@include menu-font(90%);
	text-transform: uppercase;
	list-style-type: none;
	width:$vertical-menu-width;
	position: absolute;
	overflow: hidden;
	text-align: right;
	//@include transform(translateX(-$vertical-menu-width - 3px) rotate(-90deg));
	//@include transform-origin(right top);  
  list-style-type: none;
  margin:0;
  padding:0;
}

#language-select li {
  float:right;
}

#language-select li:first-child:before {
  content: "/";
  float:left;
  color:$text-color;
  padding:0 0.2em;
}

/**** Top Menu: Logo ****/

#logo {
	clear:both;
	display:block;
	float:right;
	position:absolute;
	width: 120px;
	height: 130px;
	z-index: 5;
	perspective: 50em;
	right: 0.5 * $grid-gutter-width;
}

#logo img {
	display:block;
	position:absolute;
	top:0;
	left:0;
	transition: opacity 0.2s cubic-bezier(0.445, 0.050, 0.550, 0.950), transform 0.35s 3s linear;
	// .ready & {
	// 	transform: rotateY(90deg);
	// }
}

#logo span {
	font-size: 6.9em;
	font-weight: bold;
	font-family: "LuxiMonoBold";
	position: absolute;
	top: -0.34em;
	left: 0;
	width: 100%;
	display: block;
	color: red;
	text-align: center;
	transition: transform 0.3s 3.3s linear;
	transform: rotateY(-90deg);
	.ready & {
		transform: rotateY(0)
	}

	#logo img,
	#logo span {
		will-change: transform;
	}
}

/* disable following section to disable special 40 years logo animation */
//#logo.transitionend {
//	img {
//		transition: transform 0.15s 0s;
//	}
//	span {
//		transition: transform 0.15s 0.15s;
//	}
//	&:hover {
//		img {
//			transform: rotateY(0deg);
//			transition: transform 0.15s 0.15s;
//			&:nth-child(1) { opacity: 1 !important; }
//			&:nth-child(2) { opacity: 0 !important; }
//		}
//		span {
//			transform: rotateY(90deg);
//			transition: transform 0.15s 0s;
//		}	
//	}
//}
/* end section for special 40 years logo animation */

#logo img:nth-child(1) {
	opacity:1;
}

#logo img:nth-child(2) {
	opacity:0;
}

#logo:hover img:nth-child(1) {
	opacity:0;
}

#logo:hover img:nth-child(2) {
	opacity:1;
}


/**** Top Menu: Navigation ****/

#top-menu {
	top:-4px;
}


ul.navigation {
  @include menu-font(100%);
  list-style-type:none;
  text-transform:uppercase;  
  line-height: $line-height;
}

ul.navigation, ul.navigation ul, ul.navigation li {
  list-style-type:none;
  margin:0;
  padding:0;
}

ul.navigation li { 
	white-space:nowrap; 
}

/* level 1 */
ul.navigation > li {
  float:left;
  clear:both;
}

ul.navigation > li {
	span {
	  min-width: 73px; /* should be 10% if parent ul/li elements were 100%. But because of inline-block there is a gap of 1 space character... solution: stop using inline-block here; */
	  display: inline-block;
	}

  li span {
		min-width: 0; /* reset the above */
	}
}

/* level 2 */
ul.navigation > li > ul {
  display:inline-block;
  vertical-align: bottom;
}

ul.navigation > li > ul > li {
  float:left;
  position:relative;
  padding-right:0.8em;
}

/* level 3 */
ul.navigation > li > ul > li > ul {
  float:left;
  position: absolute;
  padding-bottom: 0.6em;
}

ul.navigation > li > ul > li > ul > li {
  text-transform:none;
}

// fix halved line at certain number of lines (5,4 or 3 respectively)
ul.navigation li:nth-child(1) > ul > li > ul  li:nth-child(5),
ul.navigation li:nth-child(2) > ul > li > ul  li:nth-child(4),
ul.navigation li:nth-child(3) > ul > li > ul  li:nth-child(3) {
  	padding-bottom:0.8em;
}
ul.navigation li:nth-child(1) > ul > li > ul  li:nth-child(6),
ul.navigation li:nth-child(2) > ul > li > ul  li:nth-child(5),
ul.navigation li:nth-child(3) > ul > li > ul  li:nth-child(4) {
  	margin-top:-0.8em;
}

/**** navigation interaction **/

ul.navigation li {
	cursor: default;
}

ul.navigation a {
	text-decoration: none;
}

ul.navigation > li > ul a,
ul.navigation:active > li > span,
ul.navigation:hover > li > span {
  color:black; 
}

ul.navigation > li > span,
ul.navigation > li:hover > span,
ul.navigation > li:hover li:hover,
ul.navigation > li:hover li:hover a:hover,
ul.navigation > li:active > span,
ul.navigation > li:active li:active,
ul.navigation > li:active li:active a:active {
  color:red; 
}

ul.navigation > li > ul > li > ul {
  display: none; 
}

ul.navigation > li > ul > li:hover > ul,
ul.navigation > li > ul > li:active > ul {
	  display: block;
	  z-index: 100; 
}

ul.navigation:hover ul,
ul.navigation:active ul {
  opacity: 0; 
 }

ul.navigation:hover > li:hover *,
ul.navigation:active > li:active * {
  opacity: 1; 
 }

ul.navigation, ul.navigation ul, ul.navigation li {
  @include transition(opacity 0.2s);
}

/**** secondary menu ****/

#secondary-menu {
	@include menu-font(87%);
	text-transform: lowercase;
	list-style-type: none;
	width:$vertical-menu-width;
	position: absolute;
	overflow: hidden;
	text-align: right;
	//@include transform(translateX(-($vertical-menu-width + $overall-container-margin)) rotate(-90deg));
	//@include transform-origin(right top);
	padding-top: 1em;
}

#secondary-menu li {
	display:inline-block;
	padding-left:0.2em;
}

/**** menu selection ****/

.selected, 
.selected a,
ul.navigation > li > ul > li span.selected a {
	color:red;
}
ul.navigation > li > ul > li > ul > li span.selected a {
	color:black;
}

/**** main ****/

#content {
	clear:both;
}

/**** headlines ****/

#headlines, .headlines {
	.before {
		@include make-xs-column(2);
	}
	.main {
		@include make-xs-column(5);
		@include make-xs-column-offset(1);
	}
	.before + .main {
		@include make-xs-column-offset(0);
		@include make-xs-column(4);
	}
}

#headlines, .headlines {

	font-size: 1em;

	a.next, a.previous {
		@include menu-font(100%);
	}

	.before {
		line-height: 2em;
	}

	.line1 {
		overflow: hidden;
		line-height: 2em;

		h1 {
			line-height:2em;

			.neutral {
				padding-left:1em;
				text-transform: none;
			}
		}
		
		ul.alphabet {
			float: right;
			@include menu-font(100%);
		}

		ul.alphabet li, ul.alphabet li a {
			color: red;
			font-family: "LuxiMonoRegular";
		}

		ul.alphabet li {
			float: left;
			margin-left: 0.2em;			
		  -ms-user-select: none;
		  -moz-user-select: none;
		  -webkit-user-select: none;
				 			
			&.unavailable a {
				cursor: default;
			}	
			
			&.selected a {
				color: $text-color;
			}
		}

		.facebook-link {
			@include facebook-link(80%);
			position: relative;
			top:0.8px;
			float: left;
			margin-left: 1em;
		}			

		a.next, a.registration {
			float:right;
		}

		a.registration {
			font-size: 90%;
			font-weight: bold;
		}

		a + a {
			padding-right: 1em;
		}

	}

	.title {
		float:left;
		@include menu-font(100%);
		text-transform: uppercase;
		color:red;
	}

	.line2:before , .line3:before {
		@include border-line(top, black);
	}

	.line2 {

		.open {
			padding-bottom: 0em;
			position:relative;
			overflow: hidden;
			padding-top: 0;
			height:0;
			opacity:0;
			padding-bottom: 2em;
			margin-bottom: -2em;
			z-index:-1;
			box-sizing: content-box;
			@include transition (opacity 0.7s 0.3s, height 1s, padding-bottom 0.3s, padding-top 0.3s 0.6s);

			.close-trigger {
				position:absolute;
				right:0;
				bottom:0;
				font-size: 0.8em;
			}

			.close-trigger:hover {
					color:red;
					cursor:pointer;
			}	

			.row .image-container {
				@include make-xs-column(2);
				padding-top: 2 * $vertical-box-padding;

				img {
					width:100%;
				}
			}
			.row .description {
				@include make-xs-column(4);
			}
		}

		.closed {

			@include transition (opacity 0.4s 0.6s);
			line-height:2em;
			height:2em;

			:hover {
					color:red;
					cursor:pointer;
			}

			:after {
				content: " >";
				white-space: pre;
			}
		}

	}

	.line2.opened {
		.open {
			position: relative;
			padding-bottom: 2em;
			height:auto;
			opacity:1;
			z-index:1;
			padding-top: $vertical-box-padding;
			line-height: $line-height;			
			@include transition (opacity 0.7s 0.3s, height 1s, padding-bottom 0.3s, padding-top 0.3s);
		}

		.closed {
			opacity:0;
			@include transition (opacity 0.3s);
		}

	}

	.line3 {
		font-size:0.8em;
		line-height: (2em / 0.8em);
		padding-bottom: $klappfenster-bottom-distance;

		a.facebook-link {
			@include facebook-link(100%);
			float:right;
		}			

		ul {
			list-style-type: none;
			margin:0;
			padding: 0;

			li {
				float:left;
				margin-right:1em;
			}
		}
	}
}

/**** timetables ****/

/* fades table behind opened description popup */
.shaded .timetable td > .event > *:not(.opened):not(a),
.shaded .timetable th, 
.shaded .timetable + dl {
  opacity:0.3;
  @include transition(opacity 0.5s 0 linear);
}
.shaded .timetable td .event {
	border-color: rgba(0,0,0,0.2) !important;
	@include transition(border-color 0.5s 0 linear);
}

.timetable td > .event > *:not(.opened):not(a), 
.timetable th, 
.timetable + dl {
  @include transition(opacity 0.3s 0 linear);
}
.timetable td .event {
	@include transition(border-color 0.3s 0 linear);
	&:last-of-type {
		border-color: red;
	}
}

.timetable tbody tr:not(:first-child) th {
	visibility: hidden;
}


.timetable-container {
	@include make-row();

	margin-bottom: $klappfenster-bottom-distance;

	.tags {
		@include make-xs-column(5);
		@include make-xs-column-offset(1);
	}
}

.timetable {
	
	h3, h4 {
		font-size: 1em;
	}

	.title-description {
		position:relative;


		.description {
			position:absolute;
			top:-5px; /* should be: -$vertical-box-padding;*/
			left:-$grid-gutter-width;
			background-color: $special-background-color;
			width:233%;
			padding: (2 * $line-height + 2 * $vertical-box-padding) $grid-gutter-width 1em $grid-gutter-width;
			z-index:-1;
			visibility: visible;
			font-size:90%;
			height:0;
			opacity:0;
			overflow:hidden;
			@include transition(height 0.8s, opacity 0.4s);
			
			.description-content {
				opacity: 0;
				/*@include transition(opacity 0.5s 0.1s);*/
			}

			.close-trigger {
				font-size: 90%;
				display:block;
				float:right;
				color:white;
				position:relative;
				top: -#{$line-height + ($line-height * 0.9) + 2 * $vertical-box-padding};
				cursor:pointer;
			}
		}

		.title.open-trigger:hover {
			cursor: pointer;
			color:$special-color;
		}
	}

	.title-description.opened {
		.title, .title:hover {
			position:relative;
			z-index:6;
			color:white;
			cursor:inherit;
		}

		.description {
			display:block;
			visibility: visible;
			z-index:5;
			opacity:1;
			@include transition(height 0.4s, opacity 0.8s);

			.description-content {
				opacity:1;
			}			
		}

		&.no-height-transition .description {
			@include transition (opacity 1.2s);
		}

	}
}

.week .event + .event {
	@include border-line(top, black);
}

table.timetable td:last-child .title-description.opened .description {
	left: -176px;

	.close-trigger {
		left: -258px;
	}
}

table.timetable {

	width:100%;

	.day {
		padding: $vertical-box-padding 0;
		@include border-line(bottom, red);
	}

	th .studio {

		padding: $vertical-box-padding 0;

		@include menu-font(100%);
		text-transform: uppercase;

		.location-name {
			float:left;
		}

		.studio-name {
			float:right;
		}
	}

	th .time {
		@include border-line(top, red);

		@include menu-font(100%);
		/* text-transform: uppercase;	*/

		color: transparent; /* hide time to prevent confusion */
		position:relative;
		top:-1px;
		padding: $vertical-box-padding 0;
	}

	tr {

		th, td {
			@include make-xs-column(1);
		}

		th {
			font-weight:normal;
			color:red;
		}
	}

	.event {
		height: 7 * $line-height + 2 * $vertical-box-padding;
		padding: $vertical-box-padding 0;
		
		@include border-line(bottom, black);
	}

}

ul.timetable {

	.day {
		padding: $vertical-box-padding 0;
		@include border-line(bottom, black);
		color:red;
		font-weight: normal;
	}

	.day.holiday {
		color:black;
	}

	list-style-type: none;
	margin:0;
	padding:0;

	ul {
		list-style-type: none;
		margin:0;
		padding:0;		
	}

	> ul >li {

		@include make-row();
	
		li, .header {
			@include make-xs-column(1);
		}

		.time-week, .day {
			@include border-line(top, red);
		}

	}

	.time-week {
		@include menu-font(100%);
		padding: $vertical-box-padding 0;
		display:block;
		color:red;
	}

	.event {
		padding: $vertical-box-padding 0;
	}

}

.timetable .event {

	.title {
		font-weight: bold;
		line-height: $line-height;
	}
	.teacher{ 
	}
	.warning {
		color:red;
	}
	.course-time {
		font-weight: bold;
	}

	.title {
		height: 2 * $line-height;
		overflow:hidden;
	}

	.title.one-line {
		height: 1 * $line-height;
	}

	.teacher, .warning, .time {
		height:$line-height;
		overflow:hidden;
	}		
}


dl.tags {
	margin: $line-height;
	dt, dd {
		font-size: 76%;
		line-height: ($line-height / 0.76);
		float:left;
		font-weight: normal;
	}
	dt:after {
		content: " = ";
		white-space: pre;
	}
	dd {
		padding-right:1em;
	}
}

/* style for schedule demo */
.schedule th, .schedule td {
	border: solid 1px black;
	padding:1em;
}

/**** general pages ****/

.basic:before {
	@include border-line(top,black);
}

.details:before {
	@include border-line(top,red);
}

.basic, .details {
	/*padding-top:0.5em;*/
}

.basic .description {
	margin: $vertical-box-padding 0;
}

.basic .description,
.single-event-page .details .info,
.headlines .line2 .open,
form {

	a {
		color:rgb(170,0,0);
	}

	a:hover {
		color:red;
	}
}

.details {
	.image-container {
		padding-top: $vertical-box-padding + 0.3em;

		img {
			width:100%;
			padding-bottom:1em;
		}
	}

	.image-grid {

		@include make-row();

		img {
			@include make-xs-column(3);
			padding-bottom: $grid-gutter-width / 1.6;
		}
	}

	.content .image-container {
		padding-top: 0.2em;
	}

	.image-license {
		display:block;
		font-size: 90%;
	}

	small { 
		display: block;
	}	
}

.details.empty:after {
	content: " ";
	min-height:330px;
	width:100%;
	display: block;
	//background-image: url(asset_path("rotT.png", image));
	background-repeat: no-repeat;
	background-size: 100%;
	margin-top: $vertical-box-padding * 2;
}

.details.empty[data-variant="1"]:after {
	//background-image: url(asset_path("schwarzT.png", image));
}

/**** events ****/

.event .details {
	.separated-1 {
		padding-top: 1em;
	}

	.times-places {
		list-style-type: none;
		margin:0;
		padding:0 0 $vertical-box-padding 0;
		@include menu-font(90%);

		li {
			border: 0px solid red;
			border-width: 0 0 1px 0;
		}

		li:not(:first-child) {
			padding-top: $vertical-box-padding;
		}

		time {
			color:red;
		}

		.place {
			display:block;
			padding-bottom: $vertical-box-padding ;
		}

		.moment {
			overflow: hidden;
			clear:both;

			.time-moment {
				float:left;
			}
			.place {
				@include menu-font(100%);
				text-transform: uppercase;
				color:red;
				float:left;
			}
			.place a {
				color:red;
			}
			.place a:hover {
				color:black;
			}
			.time-moment:after {
				content: " "; /* width of 1 character */
				white-space: pre;
			}
		}
	}

	.time-end + .daynames:before {
		content: "\A";
		white-space: pre-wrap;
	}

	small p:last-child { // unintended result of wysiwyg editor
		margin: 0;
	}

	.facebook-link {
		@include facebook-link(100%);
	}	
}

.event .basic .teacher,
.single-event-page .basic .type {	
		font-size: 0.9em;
		font-weight: 900;
}

.single-event-page .basic .type,
.single-event-page .basic .teacher {	
	line-height: $line-height / 0.9em ;
	margin-bottom: $line-height;
}

.single-event-page .basic .type + .teacher {	
	margin-top: -$line-height;
}

.event.single-event .basic .title {
	@include menu-font(100%);
	text-transform: uppercase;
	line-height: $line-height;
}

.event .content {
	padding: $vertical-box-padding 0;
}

.event p {
	margin-bottom: 1em;
}

.single-event-page {
	.event-bio {
		margin-top: 1em;
	}
}

.event-performanceprojekt {
	.title, .teacher {
		display: inline;
	}
	.title {
		@include menu-font(100%);
		text-transform: uppercase;
	}
	.teacher {
		padding-left:1em;
	}
	.description {
		line-height: $line-height;
		height: 3 * $line-height;
		overflow: hidden;
		margin: 0;
		small {
			display:none;
		}
	}
	.more {
		margin-top: -0.1em;
		line-height: $line-height;
	}
	.more:after {
		content: " >";
	}
	.time-duration {
		@include menu-font(100%);
		color:red;
	}
	.info {
		display: table-cell;
		vertical-align: bottom;
		padding-top: $vertical-box-padding;
		height: 4 / 0.9 * $line-height + $vertical-box-padding;
	}
}

/**** teachers ****/

.teachers {

	.basic {

		.open-trigger.overflown:not(.opened), .close-trigger {
			cursor: pointer;
		}

		.open-trigger.overflown:not(.opened):hover, .close-trigger:hover {
			color:red;
		}

		.description {
			position:relative;
			margin-top:$vertical-box-padding;

			.bio {
				height:7 * $line-height * 0.98;
				min-height:7 * $line-height * 0.98;
				overflow-y: hidden;
				@include transition(height 0.5s)
			}

			.close-trigger {
				text-align: right;
				display: none;
			}
		}

		.description.no-height-transition .bio {
			@include transition (height 0s);
		}

		.description.opened {

			.bio {
				height: auto;
			}

			.more {
				display:none;
			}
			.close-trigger {
				display: block;
			}
		}

		.open-trigger.opened {
			cursor:normal;
			color:inherit;
		}
	}

}


.teachers .image-container, {
	@include make-xs-column(3);

	img {
		padding-bottom: 2 * $vertical-box-padding;
		min-height:152px; /* this values should better be replaced by width and height in HTML, retrieved from the image */
	}
}

.teachers .info {
	padding-top: $vertical-box-padding;
}

.teachers .image-container.empty {
	width:146px;
	height:152px;
	//background-image: url(asset_path("schwarzT.png", image));
}

.teachers h3 {
	font-size: 1em;
	font-weight: 700;
	margin:$vertical-box-padding 0 $line-height 0;
}

.teachers .classes {
	font-size: 0.8em;

	.one-line {
		text-overflow: ellipsis;
		overflow: hidden;
		white-space: nowrap;		
	}

}

/**** programm ****/

.event-programm {
	.title {
		font-size: 1em;
		font-weight: bold;
		padding-right: 1em;
		float:left;
		line-height: $line-height;
	}
	.type {
		font-size:1em;
		float:left;
		line-height: $line-height;
	}
	.basic .teacher {
		display:block;
		clear:both;
		font-size: 1em;
		margin-bottom: 0;
		font-weight: normal;
		line-height: $line-height;
		float: left;
	}
	.month {
		@include menu-font(100%);
		text-transform: uppercase;
		color:red;
		padding-bottom: $vertical-box-padding;
		line-height: $line-height;
		padding-top: 1em;
	}
	.in-festival {
		padding-left: 1em;
		float:left;
		color: #999;
		// font-size: 0.8em;
		// padding-top: 0.125em; // = 1 / 0.8
	}
	.teacher:empty + .in-festival {
		padding-left: 0;
	}
	.time, .address {
		@include menu-font(100%);
		text-transform: uppercase;
		color:red;		
	}
	.day, .location {
			float:left;
			clear:both;
	}
	.clock, .studio {
			float:right;
	}
	.details {
		padding-bottom: $vertical-box-padding;
	}
}
.event-programm-section:first-of-type {
	.basic:before, .details:before {
		border-width: 0;
	}
	.month {
		padding-top: 0;
	}
}

/**** workshops ****/

.headlines-workshop {

	.line2, .line3 {
		@include make-row();
	}

	.line2 {

		padding-bottom: $vertical-box-padding;

		.details {
			@include make-xs-column(2);

			.time-duration {
				@include menu-font(100%);
				padding-top: $vertical-box-padding;
				color:red;
			}

			.image-container img {
				width:100%;
			}			
		}
		.basic {
			@include make-xs-column(4);
			
			.inline-title {
				padding-top: $vertical-box-padding;
			}

			.title {
				@include menu-font(100%);
				text-transform: uppercase;
				color:red;
				display:inline;
			}

			.info-link, .festival-link {
				padding-left: 1em;
				display:inline;
			}

			.info-link:after, .festival-link:after {
				content: " >";
				white-space: pre;
			}

			.info-link:hover {
				color:red;
				cursor:pointer;
			}

			.close-trigger {
				font-size: 0.8em;
				float:right;
			}

			.close-trigger:hover {
				color:red;
				cursor:pointer;
			}			
		}
	}

	.line3 {
		@include make-xs-column(6);
		@include border-line(top, red);

		font-size:0.8em;
		line-height:2em;
		/*padding-bottom: $line-height;*/

		ul {
			list-style-type: none;
			margin:0;
			padding: 0;

			li {
				float:left;
				margin-right:1em;
			}
		}
	}	

	/* interaction */

	.image-container, .description, .close-trigger {
		display:none;
		opacity:0;
		@include transition(opacity 0.5s);
	}

	.opened .image-container, .opened .description, .opened .close-trigger {
		display:block;
		display:initial;
		opacity:1;
	}

}

ul.workshops {

	margin-bottom: 1.5em;

	.controls {
		@include make-row();

		.header {
			@include make-xs-column(5);
			@include make-xs-column-offset(1);
			padding-bottom: $vertical-box-padding;
			line-height: $line-height;
			text-transform: uppercase;
			font-size: 0.8em;
			color:red;
		}
	}

	.group {
		@include make-row();

		+ .group {
			padding-top: 2em;
		}

		.headlines {
			margin-left: 0px;
		}

		.time-duration {
			@include make-xs-column(1);
			time { 
				@include menu-font(100%);
				color:red;
			}
			.festival-link {
				font-size:0.8em;
			}
		}

		.time-duration:before {
			padding-bottom: $vertical-box-padding;
		}

		.time-duration:before, .classes:before {
			@include border-line(top, red);
		}

		.classes {
			@include make-xs-column(5);

			.class {
				clear:both;
				padding: $vertical-box-padding 0;
				@include border-line(bottom, black);
				overflow:hidden;
			}

			.class:last-child {
				border:none;
			}

			.class a {
				display:block;
			}

			.title {
				font-size: 1em;
				font-weight: bold;
				float:left;
				line-height: $line-height;
			}
			.teacher {
				float:left;
				padding-left: 1em;
			}
			.class-data {
				float:right;
				font-weight: bold;

				.daynames {
					padding-left:1ex;
				}
			}
		}
	}
}

/**** page ****/

.page {
	.description {
		h4 {
			font-size: 1em;
			font-weight: bold;
			padding-bottom: 1em;
		}
	}
}

/**** studios ****/

.studios {
	.title {
		@include menu-font(100%);
		text-transform: uppercase;
		color: red;
		padding-top: $vertical-box-padding;
		padding-bottom: $vertical-box-padding;
	}
	.details .content, .basic .content {
		padding-bottom:1em;
		padding-top: $vertical-box-padding;
	}
	.basic .content {
	}	
	.basic .content div {
		padding-bottom:1em;
	}
}

/**** festivals ****/
.festivals {
	li + li .festival {
		margin-top: $klappfenster-bottom-distance;
	}
}

/**** festval containers ****/

.festivalcontainers {

	.title {
		@include menu-font(100%);
		text-transform: uppercase;
		color: red;
		padding-top: 2 * $vertical-box-padding;
		padding-bottom: $vertical-box-padding;
	}

	.upcoming {
		margin-top: $line-height;
		margin-bottom: $line-height;
		li {
		}
	} 

	.downloads {
		margin-top: $line-height;
		li {
			float:left;
			&+li {
				padding-left: 1em;
			}
		}
	} 

	.basic {

		.open-trigger.overflown:not(.opened), .close-trigger {
			cursor: pointer;
		}

		.open-trigger.overflown:not(.opened):hover, .close-trigger:hover {
			color:red;
		}

		.description {
			position:relative;
			margin-top:$vertical-box-padding;

			.may-overflow {
				height:14 * $line-height * 0.98;
				min-height:14 * $line-height * 0.98;
				overflow-y: hidden;
				@include transition(height 0.5s)
			}

			.close-trigger {
				text-align: right;
				display: none;
			}
		}

		.description.opened {

			.may-overflow {
				height: auto;
			}

			.more {
				display:none;
			}
			.close-trigger {
				display: block;
			}
		}

		.open-trigger.opened {
			cursor:normal;
			color:inherit;
		}
	}
}

/**** registration form ****/

.registration-form, .newsletter-subscribe-form {

	$gutter-division-factor: 3;

	.row {
		padding:$vertical-box-padding $grid-gutter-width (2 * $vertical-box-padding) $grid-gutter-width;
	}

	.intro, .basic p:first-child {
		padding-top: $vertical-box-padding;
	}

	.warning {
		@include make-row;
		@include make-xs-column(4);
		@include make-xs-column-offset(2);
		background-color: red;
		color:white;
		font-weight: bold;
		padding:$grid-gutter-width;
		border-radius: $grid-gutter-width / 2;
		margin: 0 0 (2 * $vertical-box-padding) $grid-gutter-width;
	}

	input[type=text], 
	input[type=email], 
	textarea,
	select {
		width:100%;
		border:solid 1px $text-color;
		background-color: white;
		border-radius: 0;
	}

	textarea {
		height:7em;
	}

	#registration_prename,
	#registration_surname,
	#registration_street,
	#registration_city,
	#registration_phone,
	#registration_email,
	#registration_country
	 {
		width:35%;
	}

	#registration_zip
	 {
		width:15%;
	}

	label {
		font-weight: normal;
	}

	.label-columns {

		label, input {
			/*margin-top:$vertical-box-padding * 2;*/
		}


		label {
			clear:both;
			@include make-xs-column(2);
			text-align:right;
			padding-right: $grid-gutter-width;
		}
		label + input,
		label + select,
		label + textarea {
			@include make-xs-column(4);
			left:$grid-gutter-width / $gutter-division-factor;
		}

		.parsley-errors-list.filled:before {
		content: "\A0";
		padding-left: 1em;
		float: left;
		}

		.parsley-errors-list.filled {
		opacity: 1;
		padding-top: 0.5em;
		color:red;
		}

	}

	.form-radio {
		.parsley-errors-list.filled {
		  width:100%;
		  text-align: center;
	    position: absolute;
	    top: calc(50% - 1em);
	    color:red;

	    &#parsley-id-multiple-registrationmembership_status {
		    position: absolute;
		    top: initial;
		    color: red;
		    width:auto;
		    left: 0;
		    transform: translateX(-60%) rotateZ(-90deg);
	    }
	  }
	}

	.form-workshops {
		.parsley-errors-list {
			display:none;
		}
		select.parsley-error {
			color:red;
		}
	}

	#parsley-id-multiple-registrationaccept_terms {
		@include make-xs-column-offset(2);
		left: 8px;
		position:relative;
		color:red;
	}

	.title {
		@include make-xs-column(2);
		text-align: right;
		padding-right: $grid-gutter-width;
	}

	.description {
		@include make-xs-column(4);
		padding-left: 0;
		left:$grid-gutter-width / $gutter-division-factor;
	}

	p:not(:last-child) {
		margin-bottom: 1em;
	}

	.early_bird_list {
		b, span {
			display: block;
		}
	}

	.label-columns .description {
		@include make-xs-column-offset(2);
	}	

	.form-checkbox, .form-radio {
		@include make-xs-column(4);
		left:$grid-gutter-width / $gutter-division-factor;

		padding-left: 3px;

		.radio-elem{
			position: relative;
		}

		input[type=checkbox], .radio-elem input[type=radio]{
			position:absolute;
			left: 8px;
			top:0;
			z-index: -1;
		}

		label {
			float:left;
			width:90%;
		}

		input[type=checkbox] + .input-style-helper,
		input[type=radio] + .input-style-helper {
			visibility: visible;
			display:block;
			border: 1px solid $text-color;
			border-radius: 100%;
			background-color: white;
			float:left;
			width:22px;
			height:22px;
			position:relative;
			margin-right:$grid-gutter-width;
			margin-bottom: 0.5em;
			clear:left;
			z-index:10;
		}
		input[type=checkbox].checked + .input-style-helper:after,
		input[type=radio].checked + .input-style-helper:after,
		input[type=checkbox]:checked + .input-style-helper:after,
		input[type=radio]:checked + .input-style-helper:after{
			content: " ";
			background-color: black;
			width: 14px;
			height: 14px;
			position:absolute;
			top:3px;
			left:3px;
			border-radius: 100%;
		}
		input[type=checkbox]:not(.checked) + .input-style-helper:hover:after,
		input[type=radio]:not(.checked) + .input-style-helper:hover:after,
		input[type=checkbox]:not(:checked) + .input-style-helper:hover:after,
		input[type=radio]:not(:checked) + .input-style-helper:hover:after {
			content: " ";
			background-color: #888;
			width: 14px;
			height: 14px;
			position:absolute;
			top:3px;
			left:3px;
			border-radius: 100%;
		}		
	}

	input[type=submit] {
		@include make-xs-column(4);
		@include make-xs-column-offset(2);
		border: 1px solid $text-color;		
		background-color: white;
		padding: $vertical-box-padding;
		left:$grid-gutter-width / $gutter-division-factor;
		margin-bottom:2em; /* make space for error messages */
	}

	input[type=submit]:hover {
		background-color: black;
		color:white;
	}

}

/**** archive links section ****/

.archive-section {
	@include make-row();
	@include make-xs-column(6);

	margin-top: (3 * $line-height) / 0.85;
	margin-bottom: (1 * $line-height) / 0.85;
	padding-top: ($vertical-box-padding / 0.85);
	border: 0 solid;
	border-width: 1px 0 0 0;
	display:inline;
	font-size: 85%;
	line-height: $line-height;	

	.archive-headline {
		line-height: $line-height;	
	}

	.archive-headline:after {
		content: ": ";	
		white-space: pre;
	}	

	.archive-headline, .archive-links, .archive-links li {
		display:inline;
		font-size: inherit;
	}

	.archive-links {
		li:not(:last-child):after {
			content: "/ ";
			white-space: pre;
		}
	} 

}

/**** start page video 40 years ****/

.start_video {
	@include make-row();
	@include make-xs-column(4);
	@include make-xs-column-offset(1.5);
	padding-left:4px;
	transition: opacity 0.5s;
	&:before {
    content: "///\A\A";
    white-space: pre;
		color: red;
		@include menu-font(100%);
		letter-spacing: 0.5em;
	}	
	.video_wrapper {
		position: relative;
		width: 50%;
		padding-bottom: 56.25%; /* 16:9 */
		margin-bottom: -28.125%;
		height: 0;
		iframe {
			width: 100%;
		}
		object, embed {
			position: absolute;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
		}
	}	
	iframe {
		display: block;
		margin-bottom: 2em;
	}
	a {
		display: block;
		text-transform: uppercase;
		@include menu-font(100%);
		padding-left: 4px;
		letter-spacing: 0.5em;
		// color: red;		
	}
	+ .start_events_listing {
		z-index: -5;
		opacity: 0;
		position: absolute;
		transition: opacity 0.5s 0.3s;
	}
	&.closed {
		opacity: 0;
		+ .start_events_listing {
			z-index: 1;
			opacity: 1;
		}
	}
}

div.start_video_close {
	@include make-xs-column-offset(5);
	position: absolute;
	background-color: rgba(255,255,255,0.95);
	height:1.5em;
	width:1.5em;
	line-height: 1.5em;
	border-radius: 50%;
	border-color:rgba(0,0,0,0.95);
	cursor: pointer;
	text-align:center;
	left: 1.6em;
	top:-0.7em;
	border: 1px solid black;
}

/**** start page listing ****/

.start_events_listing {
	li {
		@include make-row();
		@include make-xs-column(5);
		@include make-xs-column-offset(1);

		text-transform: uppercase;
		@include menu-font(100%);

		.time, .event {
			float:left;
		}

		.time {
			width: 10%; /* half a grid-width on 5 cells */
			color:red;
		}

		.event {
			max-width:90%;
			letter-spacing: 0.5em;
		}

		.time:before, .event:before {
			content : "///\A\A";
			white-space: pre;
			color:red;
		}
		.time:before {
			color:transparent;
		}

		.time:after {
			content : "\A\A";
			white-space: pre;
		}

		.event a:after {
			content: " >>>";
			white-space: pre;
		}

		.event:after {
			content: "\A";
			white-space: pre;
		}

	}
}

/**** newsletter page ( partially overwriting the workshop form :/ ) ****/

.newsletter {
	p:first-child {
		padding-top: $vertical-box-padding;
	}
}
.newsletter-subscribe-form, .newsletter-unsubscribe-form {
	@include make-xs-column(3);
	padding-top: $vertical-box-padding;
	.row, li {
		width: 100% !important;
	}
	.row {
		padding: 0.3em 0px 0.6em 0px;
		margin:0;
	}
	label {
		width: auto !important;
	}
	input[type="submit"] {
		margin-left: 0;
		width: 100%;
		left: 0;
	}
	input[type="email"] {
		padding-left: 8px;
	}
}

/**** search page ****/

.search-form {
	@include make-xs-column(5);
	@include make-xs-column-push(1);
	padding:0 0 1em 0;
}

.search-results {

	> li {
		@include make-row();
		margin-top: 1em;
	}

	.search-category-title {
		@include make-xs-column(1);
		@include menu-font(inherit);
		text-transform: uppercase;
		text-align:right;
		color:red;
		padding-top:2px;
	}

	.search-category-content {
		@include make-xs-column(5);
		//@include make-xs-column-push(1);
	}


}

/**** jubiläum 40 *****/

.jubi-tanzklassen {
	@include make-xs-column(5);
	@include make-xs-column-offset(1);
	margin-bottom: 4em;
	display: block;
	padding: 0;
	clear: both;	

	+ * {
		clear: both;
	}

	a {
		display: block;
	}

	.jubi-image {
		width: 100%;
	}

	.jubi-link {
		@include menu-font(100%);
		margin-top: 1em;
		display: block;
		text-align: right;
	}

}

.page .description h4 {
	@include menu-font(100%);
	@include border-line("bottom", black);
	color: red;
	text-transform: uppercase;
	line-height:2em;
	padding:0;
	margin-bottom: 1em;
}