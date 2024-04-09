# Helpful PGO Commands

Grab the cli from Github:
[GitHub](https://github.com/CrunchyData/postgres-operator-client) [Docs](https://access.crunchydata.com/documentation/postgres-operator-client/latest/)

## Point In Time Restore

`pgo show postgres -n database` for backup information

### Whole cluster
```sh
pgo restore postgres -n database \
    --options "--type=time --target='2024-04-09 11:00:03+00'" \
    --repoName repo1
```

### Individual databases
```sh
pgo restore postgres -n database \
    --options "--type=time --target='2024-04-09 11:00:03+00' --db-include=postgres" \
    --repoName repo1
```

## Manual full backup

```sh
pgo backup postgres -n database --repoName repo1
```
