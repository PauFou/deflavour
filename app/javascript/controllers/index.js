// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"


import ChartController from "./chart_controller"
application.register("chart", ChartController)

import ExperienceController from "./experience_controller"
application.register("experience", ExperienceController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import MapController from "./map_controller"
application.register("map", MapController)

import SearchToggleController from "./search_toggle_controller"
application.register("search-toggle", SearchToggleController)

import TomSelectController from "./tom_select_controller"
application.register("tom-select", TomSelectController)

import NestedFormController from "./nested_form_controller"
application.register("nested-form", NestedFormController)
