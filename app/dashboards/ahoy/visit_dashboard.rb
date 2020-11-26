require "administrate/base_dashboard"

class Ahoy::VisitDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    events: Field::HasMany.with_options(class_name: "Ahoy::Event"),
    user: Field::BelongsTo,
    id: Field::Number,
    visit_token: Field::String,
    visitor_token: Field::String,
    ip: Field::String,
    user_agent: Field::Text,
    referrer: Field::Text,
    referring_domain: Field::String,
    landing_page: Field::Text,
    browser: Field::String,
    os: Field::String,
    device_type: Field::String,
    country: Field::String,
    region: Field::String,
    city: Field::String,
    latitude: Field::Number.with_options(decimals: 2),
    longitude: Field::Number.with_options(decimals: 2),
    utm_source: Field::String,
    utm_medium: Field::String,
    utm_term: Field::String,
    utm_content: Field::String,
    utm_campaign: Field::String,
    app_version: Field::String,
    os_version: Field::String,
    platform: Field::String,
    started_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  events
  user
  id
  visit_token
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  events
  user
  id
  visit_token
  visitor_token
  ip
  user_agent
  referrer
  referring_domain
  landing_page
  browser
  os
  device_type
  country
  region
  city
  latitude
  longitude
  utm_source
  utm_medium
  utm_term
  utm_content
  utm_campaign
  app_version
  os_version
  platform
  started_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  events
  user
  visit_token
  visitor_token
  ip
  user_agent
  referrer
  referring_domain
  landing_page
  browser
  os
  device_type
  country
  region
  city
  latitude
  longitude
  utm_source
  utm_medium
  utm_term
  utm_content
  utm_campaign
  app_version
  os_version
  platform
  started_at
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how visits are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(visit)
  #   "Ahoy::Visit ##{visit.id}"
  # end
end
