Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54F0161E11
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 13:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfGHL4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 07:56:42 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:32865 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730682AbfGHL4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:56:39 -0400
Received: by mail-vs1-f65.google.com with SMTP id m8so7995695vsj.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 04:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0N2o6vb53INmsDRg0vvoXHm5GyPTVSZcycR7PVLISU=;
        b=PvlU5vz7XoPZUwIvygXmPcP5QfufMINmsJEA7E6WNSLKKplD/mSsZUWag6tko+vG5x
         XhtSx4FHOo6+nMJ0HrtqzjOliGarGG8Qp5ulq4ym4Kbi/Cw//tCLhRkEdTCJUC+kSCMa
         NX5lcpTu11Vh/MglPgWVWg7gRus8cgDxQ688ZKq7L823/gfYF6IDsTOxYvoUOn9QnJo+
         2FSycF8LeDN6Qd3cSu1UXRzF3Ia7nxFLFkXnVtv8m9watIfHrMAtWHcDT4KDevlhpLPh
         MucM1y0V40Df/oSHl4aXhjyKWggA+uISfJ/U0HDz74oQFLiO/XZx4lhRUWoyGWPAavF8
         764w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0N2o6vb53INmsDRg0vvoXHm5GyPTVSZcycR7PVLISU=;
        b=gyOtm3yfl5L1m8UE/xrjWqZgBl/rfiRln/4sjKrAUchZjcSBZXP7+ZGXxrFoVXTTaF
         CEt9FXqsBchGsVCY5ncO2dWK86JicXuSFJHLCAnVOcUYspueFRbEW9PNkoCmlcfTmQOA
         gxOcvvwUABMccJTVTD8IIi0jf44g4WVIjW6D6PQCeg+QOPHftSo7Fyo089MyimSC9M4i
         ZTY3ENuFMuSW9PawtjjyWCkgPIyzkpK3ZhvafX5R7XVD7KN2VuhhaIkXipte5wnMOaSq
         BAxE2WslEBB6e76Y7mOmGn7EuZCMXtY46xH+Lt/WT75E5aWRJFg8jlznAawn6tfODQMt
         7/fg==
X-Gm-Message-State: APjAAAWltP0z1wgSRD6TeuGWscXlr5Edz8aXdSnueomx0ss0uKonNuA9
        2qq6jJmC4FzyJ77ElWgHzsrpUU6yEOu71UIsc/nZ+w==
X-Google-Smtp-Source: APXvYqwyuPgEkSrZremYSuowjEnjBh5G+SBxTju74mqujXxMD4n9mlArpncHihuukVZeUm+rYjRxRxKjUErClPTQcEk=
X-Received: by 2002:a67:e454:: with SMTP id n20mr8380623vsm.34.1562586998946;
 Mon, 08 Jul 2019 04:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190702133631.47760-1-yuehaibing@huawei.com>
In-Reply-To: <20190702133631.47760-1-yuehaibing@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Jul 2019 13:56:03 +0200
Message-ID: <CAPDyKFrfAD8_-s+uCeA=XYO5+YM7bPwfK0geNBLQ1gB80G6jbg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci_am654: Add dependency on MMC_SDHCI_AM654
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2019 at 15:36, YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix build error:
>
> drivers/mmc/host/sdhci_am654.o: In function `sdhci_am654_probe':
> drivers/mmc/host/sdhci_am654.c:464: undefined reference to `__devm_regmap_init_mmio_clk'
> drivers/mmc/host/sdhci_am654.o:(.debug_addr+0x3f8): undefined reference to `__devm_regmap_init_mmio_clk'
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: aff88ff23512 ("mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 931770f..14d89a1 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -996,7 +996,7 @@ config MMC_SDHCI_OMAP
>
>  config MMC_SDHCI_AM654
>         tristate "Support for the SDHCI Controller in TI's AM654 SOCs"
> -       depends on MMC_SDHCI_PLTFM && OF
> +       depends on MMC_SDHCI_PLTFM && OF && REGMAP_MMIO
>         select MMC_SDHCI_IO_ACCESSORS
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
> --
> 2.7.4
>
>
