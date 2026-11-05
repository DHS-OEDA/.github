# DHS-OEDA `.github`

Default issue templates for every repository in the DHS-OEDA organization.

## How it works

GitHub uses the templates in `.github/ISSUE_TEMPLATE/` here for **any org repo that has no `.github/ISSUE_TEMPLATE/` folder of its own**. It's all or nothing: if a repo adds even one template or a `config.yml`, it stops seeing these defaults and must carry its own full set.

This repository must stay **public**. Don't commit anything sensitive here.

## Templates

| Template | Use it when… | Issue type | Labels |
|---|---|---|---|
| 🐞 Bug report | Code is broken, errors, or gives wrong output | Bug | `triage` |
| ✨ Feature request | You want a new capability or improvement | Feature | `triage` |
| 🗺️ Epic | Grouping several issues into a larger effort | *(Epic, once created)* | `epic` |
| ✅ Task | Maintenance, docs, refactoring, analysis, or setup | Task | – |
| 🧮 Data issue | The *data* is wrong, late, missing, or changed | Bug | `data`, `triage` |

Blank issues are turned off (`config.yml`), so everyone picks a template.

## Labels

Templates only apply labels that **already exist** in the target repo. Sync the standard set with:

```bash
./scripts/sync-labels.sh DHS-OEDA/some-repo        # one repo
./scripts/sync-labels.sh --all DHS-OEDA            # every non-archived repo
```

Edit `scripts/labels.tsv` to change the set.

## Issue types

`type:` in each template sets the org-level issue type (Bug, Feature, Task are GitHub's defaults). To use the Epic type, an org owner adds it under **Organization settings → Planning → Issue types**, and then uncomment `type: Epic` in `03-epic.yml`.

## Customizing for one repo

Copy the whole `.github/ISSUE_TEMPLATE/` folder into that repo, then edit. Remember that the repo then stops getting updates made here.
