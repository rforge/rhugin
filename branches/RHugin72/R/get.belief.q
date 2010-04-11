get.belief <- function(domain, node)
{
  RHugin.check.args(domain, node, character(0), "get.belief")

  node.ptr <- .Call("RHugin_domain_get_node_by_name", domain, node[1],
                     PACKAGE = "RHugin")
  kind <- .Call("RHugin_node_get_kind", node.ptr, PACKAGE = "RHugin")

  belief <- NULL

  if(kind == "discrete") {
    states <- get.states(domain, node)
    states.idx <- 0:(length(states) - 1)

    belief <- .Call("RHugin_node_get_belief", node.ptr, states.idx,
                     PACKAGE = "RHugin")

    names(belief) <- states
  }

  if(kind == "continuous") {
    mean <- .Call("RHugin_node_get_mean", node.ptr, PACKAGE = "RHugin")
    variance <- .Call("RHugin_node_get_variance", node.ptr, PACKAGE = "RHugin")
    belief <- c("(Mean)" = mean, "(Variance)" = variance)
  }

  belief
}

