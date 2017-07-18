require "./spec_helper"

class SiteSettings < AnySetting
  source "spec/config/site.yml"
  namespace "production"

  mapping(
    title: String,
    description: String,
    url: String,
    year: Int32,
    author: {
      type:     String,
      key:      "made_by",
      nillable: true,
    }
  )
end

describe AnySetting do
  settings = SiteSettings.load

  it "maps fields" do
    settings.title.should eq "Site Title"
    settings.description.should eq "Site Description"
    settings.author.should eq "John Doe"
  end

  it "properly uses namespace" do
    settings.url.should eq "https://example.com"
  end
end
