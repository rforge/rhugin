get.cases <- function(domain)
{
  nodes <- get.nodes(domain)
  data <- list()

  n <- .Call("RHugin_domain_get_number_of_cases", domain,
              PACKAGE = "RHugin")
  RHugin.handle.error()

  if(n < 1)
    return(invisible(NULL))

  index.set <- as.integer(0:(n-1))

  node.ptrs <- .Call("RHugin_domain_get_node_by_name", domain,
                      as.character(nodes), PACKAGE = "RHugin")
  kinds <- .Call("RHugin_node_get_kind", node.ptrs, PACKAGE = "RHugin")
  subtypes <- .Call("RHugin_node_get_subtype", node.ptrs, PACKAGE = "RHugin")

  for(node in nodes) {
    if(kinds[node]  == "discrete") {
      state.indices <- .Call("RHugin_node_get_case_state", node.ptrs[node],
                              as.integer(index.set), PACKAGE = "RHugin")
      RHugin.handle.error()

      states <- get.states(domain, node)

      if(is.element(subtypes[node], c("labeled", "interval")))
        data[[node]] <- factor(states[state.indices + 1], levels = states)
      else
        data[[node]] <- states[state.indices + 1]
    }

    else {
      data[[node]] <- .Call("RHugin_node_get_case_value", node.ptrs[node],
                             as.integer(index.set), PACKAGE = "RHugin")
      RHugin.handle.error()
    }
  }

  data[["Freq"]] <- .Call("RHugin_domain_get_case_count", domain,
                           as.integer(index.set), PACKAGE = "RHugin")
  RHugin.handle.error()

  as.data.frame(data)
}


