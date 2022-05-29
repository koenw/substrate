let templ_repo = Git.clone("koenw/substrate-node-template", "main");

for f in repo.ls("bin/node-template")
  .filter(|entry| entry.is_file())
  .map(|entry| entry.path) {
    let new_path = f.strip_prefix("bin/node-template");
    templ_repo.write(new_path, repo.read(f));
}

// TODO: update Cargo.toml

for f in templ_repo.status().changed() + templ_repo.status().added() {
  templ_repo.add(f);
}

templ_repo.commit("Updating templates");
templ_repo.push("main");
issue.comment("Successfully updated the templates");
