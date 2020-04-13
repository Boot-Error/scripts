#!/usr/bin/env bash

percent() {
  # completed total
  if [[ $2 -eq 0 ]]; then
	printf 0
  else
	printf "%.0f" "$(bc -l <<<"$1/$2*100")"
  fi
}

project_list() {
  task all rc.report.all.{labels,columns}:project rc.verbose:nothing 2>/dev/null | sort -u
}

project_completed() {
  task project:"$1" +COMPLETED count 2>/dev/null
}

project_pending() {
  task project:"$1" -COMPLETED count 2>/dev/null
}

echo_sortable_line() {
  # project completed total
  echo "$(percent "$2" "$3") $2 $3 ${1:-<none>}"
}

echo_conky_line() {
  echo "$1\${alignr}$2/$3 $4% \${execbar echo '$4'}"
}

iterate_projects() {
  local project completed pending total

  { echo; project_list; } | while read -r project; do
    completed="$(project_completed "${project}")"
    pending="$(project_pending "${project}")"
    total=$(( completed + pending ))
    echo_sortable_line "${project}" "${completed}" "${total}"
  done
}

echo_for_conky() {
  local project completed total percent
  while read -r percent completed total project; do
    echo_conky_line "  ${project}" "${completed}" "${total}" "${percent}"
  done
}


main() {
  SORT=true
  FILTER_PROJECTS=("<none>")
  FILTER_COMPLETED=true
  FILTER_ONE_TASK_PROJECTS=false
  FILTER_NOT_STARTED=false
  LIMIT=10

  if ${SORT}; then
    apply_sort() { sort -k1 -gr; }
  else
    apply_sort() { cat; }
  fi

  if ${FILTER_COMPLETED}; then
    filter_completed() { grep -v '^100'; }
  else
    filter_completed() { cat; }
  fi

  if ${FILTER_NOT_STARTED}; then
    filter_not_started() { grep -v '^0 '; }
  else
    filter_not_started() { cat; }
  fi

  filter_projects() {
    grep -v $(for p in "${FILTER_PROJECTS[@]}"; do printf -- "-e %s " "$p"; done)
  }

  apply_filters() {
	filter_projects | filter_completed | filter_not_started
  }

  iterate_projects | apply_filters | apply_sort | head -n${LIMIT} | echo_for_conky
}

main "$@"
