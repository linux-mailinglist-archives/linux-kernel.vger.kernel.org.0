Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC32A186A58
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 12:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbgCPLsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 07:48:18 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45370 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730875AbgCPLsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 07:48:17 -0400
Received: by mail-vs1-f67.google.com with SMTP id x82so10991600vsc.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 04:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hwg98eSj5AvN+n9LqyLq1HfFtpBX4891xtP0x63HRRo=;
        b=Bnbh9AJ1nGpYl39RiuMC7eK1V2xLE9pQ6UN95mQJs9otlzB1cyCJ0gpcjFrGwlvd7X
         YEct+PprYP0LdxRSj3aAZsjo7Qn0tnsRkPJ5M8b6eLR0QiU70oohnhRe9UBgFpkOjIUK
         EmUyfZ/Cm1runPuX6lFBsJsSw+eA3Dd3YxsCC47w5ywjvBzEYtDGVAflw7sb2WxFx5Hn
         yeFVe+hndZdajE+yaNIS1O5zRz4JJ9inBci4XCJOD5PSPWRlgQd0tjABWBHZkqH5+dVA
         Wb9vvWmyt9S4rCHj1tGp9bGiRIdLs5KMkKxXZOkkov9G7C51vHQ3g2M4fOL9gq25tm0n
         rAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwg98eSj5AvN+n9LqyLq1HfFtpBX4891xtP0x63HRRo=;
        b=TZoFmScoovMf3bY2f/ByqpwYwPekXPll9824IiktaxfMKOX4RAhHizIwOCOpuqLC1m
         KdUmeKiI6Gr1+cQXk3k8jUdJ2BpkcFCeNOY4MrChk2bjij2oCITnwHK8fs1IT6gaTAwJ
         j7u6OlH1uwDtIS5pMVTpJC/OQRjJl5Y7mQavp5G2cGCKC8OHjQNlfmKdn6cmVZuR5aFe
         3yWfBg/XyALV8C193EtWZatns7ZlcAYGTuMvKmrp2l4WhPe5ss2JjfcfkYo2tEvZHC/5
         ZJc8sYG3fEKnXgTLFz5G2ONoPA8XHkPxdazgf0mS3onYWYwwPa6LAuILdBv1svYDumNv
         4byw==
X-Gm-Message-State: ANhLgQ2t4Olm/iD9yacfkjgRVoa7UJjwSYCCHiEjE0rlLqIOXp6onYGG
        ulSXzoQHPUTi9zsrTyIQjJ5ioA8QEK2JQyQJSAT60A==
X-Google-Smtp-Source: ADFU+vtONaSXwYoqZwxzyu+DxqUCuZhAuA4KROccUIP7E0mjR7itCXDr0lHeeHfuKa8qrweO7J5CisAlE88MmBNyv1w=
X-Received: by 2002:a67:a81:: with SMTP id 123mr17067122vsk.191.1584359295692;
 Mon, 16 Mar 2020 04:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583307441.git.baolin.wang7@gmail.com> <ace53bca354e2846f19684bd33a9c0f3c2ee2c44.1583307441.git.baolin.wang7@gmail.com>
In-Reply-To: <ace53bca354e2846f19684bd33a9c0f3c2ee2c44.1583307441.git.baolin.wang7@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Mar 2020 12:47:39 +0100
Message-ID: <CAPDyKFp-HvMtEX4F-aumBy93DMn8aPjx8kBm+rCSL316HFPL0w@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/3] mmc: host: Introduce the request_atomic() for
 the host
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 at 08:42, Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> The SD host controller can process one request in the atomic context if
> the card is nonremovable, which means we can submit next request in the
> irq hard handler when using the MMC software queue to reduce the latency.
> Thus this patch adds a new API request_atomic() for the host controller
> and implement it for the SD host controller.
>
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  drivers/mmc/host/sdhci.c | 27 +++++++++++++++++++--------
>  drivers/mmc/host/sdhci.h |  1 +
>  include/linux/mmc/host.h |  3 +++
>  3 files changed, 23 insertions(+), 8 deletions(-)

I think the code split of the changes in the series can be improved a
bit, so I suggest you move the code around in the series to reach
this:

1. A patch that adds the new host ops callback, combined with the
change you have in patch3.
2. The sdhci core specific changes, from $subject patch.
3. The sdhci-sprd changes, as in patch2.

Other than that, I think the code looks good to me, besides a minor
comment on patch2, see separate reply.

Kind regards
Uffe


>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9c37451..4febbcb 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2016,17 +2016,12 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>   *                                                                           *
>  \*****************************************************************************/
>
> -void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +static void sdhci_start_request(struct mmc_host *mmc, struct mmc_request *mrq,
> +                               int present)
>  {
> -       struct sdhci_host *host;
> -       int present;
> +       struct sdhci_host *host = mmc_priv(mmc);
>         unsigned long flags;
>
> -       host = mmc_priv(mmc);
> -
> -       /* Firstly check card presence */
> -       present = mmc->ops->get_cd(mmc);
> -
>         spin_lock_irqsave(&host->lock, flags);
>
>         sdhci_led_activate(host);
> @@ -2043,6 +2038,22 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>
>         spin_unlock_irqrestore(&host->lock, flags);
>  }
> +
> +void sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +       sdhci_start_request(mmc, mrq, 1);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_request_atomic);
> +
> +void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +       int present;
> +
> +       /* Firstly check card presence */
> +       present = mmc->ops->get_cd(mmc);
> +
> +       sdhci_start_request(mmc, mrq, present);
> +}
>  EXPORT_SYMBOL_GPL(sdhci_request);
>
>  void sdhci_set_bus_width(struct sdhci_host *host, int width)
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index cac2d97..5507a73 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -775,6 +775,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>                            unsigned short vdd);
>  void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
> +void sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
>  void sdhci_set_bus_width(struct sdhci_host *host, int width);
>  void sdhci_reset(struct sdhci_host *host, u8 mask);
>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 562ed06..db5e59c 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -92,6 +92,9 @@ struct mmc_host_ops {
>                             int err);
>         void    (*pre_req)(struct mmc_host *host, struct mmc_request *req);
>         void    (*request)(struct mmc_host *host, struct mmc_request *req);
> +       /* Submit one request to host in atomic context. */
> +       void    (*request_atomic)(struct mmc_host *host,
> +                                 struct mmc_request *req);
>
>         /*
>          * Avoid calling the next three functions too often or in a "fast
> --
> 1.9.1
>
