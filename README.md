## Version matrix

Mini API to fetch version information from GitHub.

### `GET /ruby-versions`

Returns Ruby versions for GitHub repos

```
GET /ruby-versions?repos[]=alphagov/rummager&repos[]=alphagov/government-frontend
```

```json
{
  "alphagov/rummager": "2.3.0",
  "alphagov/government-frontend": "2.3.1"
}
```

### `GET /gem-versions`

Returns Ruby versions for GitHub repos

```
GET /gem-versions?repos[]=alphagov/rummager&repos[]=alphagov/government-frontend&gems[]=sinatra&gems[]=rails
```

```json
{
  "alphagov/rummager": {
    "sinatra": "1.4.7",
    "rails": null
  },
  "alphagov/government-frontend": {
    "sinatra": null,
    "rails": "5.0.0.1"
  }
}
```
