import SwiftyJSON


struct Repo {
    var name: String
    var issueConut: Int
    var forks: Int
    var starCount: Int
    var watcherCount: Int
    var description: String?
    var language: String?
    var licenseName: String?
}


/**
 * Example Repo:
 * {
   "has_wiki" : true,
   "events_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/events",
   "notifications_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/notifications{?since,all,participating}",
   "license" : {
     "spdx_id" : "Apache-2.0",
     "key" : "apache-2.0",
     "name" : "Apache License 2.0",
     "url" : "https:\/\/api.github.com\/licenses\/apache-2.0",
     "node_id" : "MDc6TGljZW5zZTI="
   },
   "merges_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/merges",
   "open_issues_count" : 4,
   "languages_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/languages",
   "pushed_at" : "2020-09-04T23:38:02Z",
   "description" : null,
   "blobs_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/git\/blobs{\/sha}",
   "issue_events_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/issues\/events{\/number}",
   "collaborators_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/collaborators{\/collaborator}",
   "git_refs_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/git\/refs{\/sha}",
   "has_projects" : true,
   "tags_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/tags",
   "keys_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/keys{\/key_id}",
   "open_issues" : 4,
   "contents_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/contents\/{+path}",
   "html_url" : "https:\/\/github.com\/iberatkaya\/QR-Reader-Generator",
   "issue_comment_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/issues\/comments{\/number}",
   "watchers" : 2,
   "statuses_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/statuses\/{sha}",
   "git_tags_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/git\/tags{\/sha}",
   "homepage" : "",
   "fork" : false,
   "updated_at" : "2020-04-05T16:03:58Z",
   "id" : 191061561,
   "svn_url" : "https:\/\/github.com\/iberatkaya\/QR-Reader-Generator",
   "forks" : 0,
   "git_commits_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/git\/commits{\/sha}",
   "compare_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/compare\/{base}...{head}",
   "branches_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/branches{\/branch}",
   "default_branch" : "master",
   "language" : "JavaScript",
   "stargazers_count" : 2,
   "full_name" : "iberatkaya\/QR-Reader-Generator",
   "has_downloads" : true,
   "url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator",
   "git_url" : "git:\/\/github.com\/iberatkaya\/QR-Reader-Generator.git",
   "forks_count" : 0,
   "ssh_url" : "git@github.com:iberatkaya\/QR-Reader-Generator.git",
   "pulls_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/pulls{\/number}",
   "teams_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/teams",
   "archive_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/{archive_format}{\/ref}",
   "private" : false,
   "releases_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/releases{\/id}",
   "archived" : false,
   "owner" : {
     "followers_url" : "https:\/\/api.github.com\/users\/iberatkaya\/followers",
     "gravatar_id" : "",
     "site_admin" : false,
     "login" : "iberatkaya",
     "url" : "https:\/\/api.github.com\/users\/iberatkaya",
     "gists_url" : "https:\/\/api.github.com\/users\/iberatkaya\/gists{\/gist_id}",
     "starred_url" : "https:\/\/api.github.com\/users\/iberatkaya\/starred{\/owner}{\/repo}",
     "node_id" : "MDQ6VXNlcjM0NDg4Mzc0",
     "repos_url" : "https:\/\/api.github.com\/users\/iberatkaya\/repos",
     "organizations_url" : "https:\/\/api.github.com\/users\/iberatkaya\/orgs",
     "following_url" : "https:\/\/api.github.com\/users\/iberatkaya\/following{\/other_user}",
     "type" : "User",
     "events_url" : "https:\/\/api.github.com\/users\/iberatkaya\/events{\/privacy}",
     "html_url" : "https:\/\/github.com\/iberatkaya",
     "avatar_url" : "https:\/\/avatars.githubusercontent.com\/u\/34488374?v=4",
     "received_events_url" : "https:\/\/api.github.com\/users\/iberatkaya\/received_events",
     "subscriptions_url" : "https:\/\/api.github.com\/users\/iberatkaya\/subscriptions",
     "id" : 34488374
   },
   "assignees_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/assignees{\/user}",
   "forks_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/forks",
   "labels_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/labels{\/name}",
   "created_at" : "2019-06-09T22:27:36Z",
   "deployments_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/deployments",
   "contributors_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/contributors",
   "stargazers_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/stargazers",
   "has_issues" : true,
   "milestones_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/milestones{\/number}",
   "downloads_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/downloads",
   "hooks_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/hooks",
   "disabled" : false,
   "subscription_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/subscription",
   "mirror_url" : null,
   "comments_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/comments{\/number}",
   "node_id" : "MDEwOlJlcG9zaXRvcnkxOTEwNjE1NjE=",
   "trees_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/git\/trees{\/sha}",
   "clone_url" : "https:\/\/github.com\/iberatkaya\/QR-Reader-Generator.git",
   "issues_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/issues{\/number}",
   "subscribers_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/subscribers",
   "commits_url" : "https:\/\/api.github.com\/repos\/iberatkaya\/QR-Reader-Generator\/commits{\/sha}",
   "name" : "QR-Reader-Generator",
   "watchers_count" : 2,
   "has_pages" : false,
   "size" : 2063
 * }
 */
