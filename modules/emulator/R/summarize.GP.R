##' @name summarize.GP
##' @title summarize.GP
##' @export
##' 
##' @param gp
##' @param pdf_file
##' @param txt_file
##' 
##' @author Michael Dietze
summarize.GP <- function(gp, pdf_file = NULL, txt_file = NULL) {
  nugget    <- gp$nugget
  isotropic <- gp$isotropic
  d         <- gp$d
  samp      <- gp$samp
  if (is.null(pdf_file)) {
    par(ask = TRUE)
  } else {
    pdf(pdf_file)
  }
  if (!is.null(txt_file)) {
    sink(txt_file)
  }
  
  plot(gp$tauwjump)
  # title('JUMP: TAUW')
  
  plot(gp$psijump)
  # title('JUMP: PSI')
  
  tauw <- coda::mcmc(gp$tauw[samp, ])
  psi <- coda::mcmc(gp$psi[samp, ])
  mu <- coda::mcmc(gp$mu)
  if (nugget) {
    tauv <- coda::mcmc(gp$tauv)
    print("**** TAUV ****")
    summary(tauv)
    plot(tauv, main = "TAUV")
    W <- coda::mcmc(gp$W)
    print("**** W ****")
    summary(W)
    plot(W, main = "W")
  }
  print("**** TAUW ****")
  print(summary(tauw))
  print("**** PSI ****")
  print(summary(psi))
  print("**** MU ****")
  print(summary(mu))
  ## par(ask=TRUE)
  plot(tauw)
  title("TAUW")
  plot(psi)
  title("PSI")
  plot(mu)
  title("MU")
  
  ## plot ACF
  par(mfrow = c(1, 1))
  if (isotropic) {
    xseq <- seq(0, max(d) / 2, length = 100)
    plot(xseq, mean(tauw) * exp(-mean(psi) * xseq ^ 2), type = "l")
  } else {
    ## anisotropic
    rng <- 0
    for (i in seq_len(dim)) {
      rng <- max(c(rng, sqrt(max(d[[i]]))))
    }
    xseq <- seq(0, rng / 2, length = 100)
    acorr <- matrix(NA, 100, dim)
    for (k in seq_len(dim)) {
      acorr[, k] <- exp(-mean(psi[, k]) * xseq^2)
    }
    plot(0, 0, type = "n", xlim = c(0, rng/2), 
         ylim = c(0, max(acorr)), xlab = "Parameter Distance", 
         ylab = "Correlation")
    for (k in seq_len(dim)) {
      lines(xseq, acorr[, k], col = k)
    }
  }
  par(ask = FALSE)
  if (!is.null(pdf_file)) {
    dev.off()
  }
  if (!is.null(txt_file)) {
    sink()
  }
} # summarize_GP
