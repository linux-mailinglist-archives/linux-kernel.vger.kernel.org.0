Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78D6399308
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 14:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388409AbfHVMN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 08:13:58 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43853 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388389AbfHVMNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:13:45 -0400
Received: by mail-ua1-f68.google.com with SMTP id y7so1897226uae.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 05:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8Whq5t8q9GwheJahJvFQp/NfuL/9ssSVrrEeSWFZQU=;
        b=cAnyMpYGBwM8IXEcyZhXp6XNeJ4oqG8RVl6vX5Xv/J9d/FHqRPyEMmdNKw9wf1KDCE
         tLTajI7r01JOL69r+MoFBwfA1kjTucGY+G1R14bZq8SmlCM6PO3BGBBN9yuq69YNiacP
         mYmpS/C4rlbiZnBN3MJkIjzZi5QjJIBgqTDkqsktrLNUQCVUDKxJoAxYiNOrTY+ddK7Q
         6hojXA83VxhzBp+wgoJjn3HcUYPgqfT3ruM7jraS3qKSkrTGl/9vDXPvOZTN+kPk59su
         yaT/o07Qu6Cu/gc8sHAXfdaN6Zaf43AQzGWM4IaU3HTRALrleGzaFrp9e7J8oqudmz8J
         twXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8Whq5t8q9GwheJahJvFQp/NfuL/9ssSVrrEeSWFZQU=;
        b=qkGp6gTD3Tgg18jTaIk5YYt1FrrESyCw6WjxtBr4Y3S5qxWpHt6MQjQqapg82kEa++
         z1YUbzyHJmI9+QBjwxvnoQLTTv8x6PnUt3zFPNV+6KsBytMtzQMjlaMCV9m2I8GVkbs+
         Imy4L0+NyFcoyVqZSXqoCgF+zwNL6jzfIAzDNWDz8P/7Ln0H7IZbwMvv3Q1jEUcmmXms
         Rs0HjlraJciN90sNcJviqybe2Yi7+IRIQ0GaAVW3bsxbwYUaPsn3E155dQbQ9k+VffVs
         hWwiVLtaZnhZLiOnCzc/P4gJXioMEzCLe+mPVNc3EyXfgHQpMC6mSttOX2y1irtyBTK1
         /eoQ==
X-Gm-Message-State: APjAAAWAfVFhRj1FX7aaSO9D3xD2y2vMXKjIZG68MXYf9T1Mv5TFxWX0
        fYVvwEfOoyYkDBhl+R3ISbQqrrp9n5OsSlCTDNglw4qu
X-Google-Smtp-Source: APXvYqwyfK3+XunOkjrMGsFKUo/ps28tqmznFkFmVvl2sGgjI2r67E341S3VzcLrmVKcgXCaRvFrYS6XYbcLEdIXitk=
X-Received: by 2002:ab0:6883:: with SMTP id t3mr5681666uar.104.1566476024313;
 Thu, 22 Aug 2019 05:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190808165301.GA30877@embeddedor>
In-Reply-To: <20190808165301.GA30877@embeddedor>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Aug 2019 14:13:07 +0200
Message-ID: <CAPDyKFoS3_RJvOxjQXpYT6YUgqJM7WXfvdHe1f6cTkab0rgsEQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-cadence: use struct_size() helper
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019 at 18:53, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
>
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct sdhci_cdns_priv {
>         ...
>         struct sdhci_cdns_phy_param phy_params[0];
> };
>
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
>
> So, replace the following form:
>
> sizeof(*priv) + sizeof(priv->phy_params[0]) * nr_phy_params
>
> with:
>
> struct_size(priv, phy_params, nr_phy_params)
>
> Also, notice that, in this case, variable priv_size is not necessary,
> hence it is removed.
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-cadence.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 163d1cf4367e..1768a13f89be 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -337,7 +337,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_cdns_priv *priv;
>         struct clk *clk;
> -       size_t priv_size;
>         unsigned int nr_phy_params;
>         int ret;
>         struct device *dev = &pdev->dev;
> @@ -351,8 +350,8 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>                 return ret;
>
>         nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
> -       priv_size = sizeof(*priv) + sizeof(priv->phy_params[0]) * nr_phy_params;
> -       host = sdhci_pltfm_init(pdev, &sdhci_cdns_pltfm_data, priv_size);
> +       host = sdhci_pltfm_init(pdev, &sdhci_cdns_pltfm_data,
> +                               struct_size(priv, phy_params, nr_phy_params));
>         if (IS_ERR(host)) {
>                 ret = PTR_ERR(host);
>                 goto disable_clk;
> --
> 2.22.0
>
