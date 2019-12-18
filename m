Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD7A1248E8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 15:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfLROBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 09:01:47 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44767 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfLROBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:01:47 -0500
Received: by mail-ua1-f66.google.com with SMTP id d6so652519uam.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 06:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0JG9FsmPpOoD5GBiRIPhJrj1c4tEf6Dk1qUflCL1l8=;
        b=d+j2Q3gMVEtDTZjx1PNLgfsbE6Px+yOzGhY1xmsvXfcSM6QKcgkr2gXBoMNBcDMz7w
         OzsoFt6Gp647NxbZU7y0+wMgrGuU5fLA08daq08/VS5L/KwKS6a32BFmscI3WhomjQ4A
         RzUZJwp0kUOAMobVS6mQZNG/dAk1Z9UOVOGlXul7tP2u9saMls+iXSfeIM251sRQUffl
         EgN0ErbWqJ4YFlfl/2Sub+Bmtcs/U0DbGMV030EHMNqetRXno8uTGZpxRvSMb3voA10m
         3Mnn8YvCisimpKMIaZe9I57gTUQ2ZKwomfL2oSKfVTi2r3G9oa5KAsIzYdM1JA5uR9rT
         +MZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0JG9FsmPpOoD5GBiRIPhJrj1c4tEf6Dk1qUflCL1l8=;
        b=VtSXM6prm1btpF6TWroNArz3k+ufoY7YypUtxW7r0mtwghOzOee1TChiRnEKnqPCju
         ga7hROFTLNJkzk/qLoNES/pIIXFmfg8hNIzG1CfL3iDhIdZ9SvgOXoQf0Rsp+v+TE+zb
         aKW9fw3FctJTNyU12RR2FQWJHKM6FCnZ8ePRuGcl6RdhWWdg5Gqhzsw6fogy1Bwxy07H
         gyY+xOt4sOJ7j6ZFet1ngkwhzUosEzW+Pb1pWEv6c7gOZU/TUZt2KXXdkxn6VeiKFqw7
         lkwjTJp2mJTkPU3CAjUuWEwcOpG40V6yPNpLZB98lyeG4eLEPDAJ8yXZn9OJw8OdtVjf
         quKQ==
X-Gm-Message-State: APjAAAUiOL/k00WzUSp7ACLBaysydgHti+G+k7SakyjzV71hS+Cl9FGs
        ytDhKVkfQGKLJATVB5HSIXRyyHKM+RB9R3ApdpMBnA==
X-Google-Smtp-Source: APXvYqz9r2dN0C3+Bqwu22rtfMOoZJ3AuiEMR41kI//837m0N3aIJdrC3qBt5RrNMLJKSN7EjFvCzPXStXBx/AV2eUQ=
X-Received: by 2002:ab0:2759:: with SMTP id c25mr1395424uap.104.1576677705884;
 Wed, 18 Dec 2019 06:01:45 -0800 (PST)
MIME-Version: 1.0
References: <20191206075408.18355-1-hslester96@gmail.com>
In-Reply-To: <20191206075408.18355-1-hslester96@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Dec 2019 15:01:09 +0100
Message-ID: <CAPDyKFqsNpgGiDEH42Mo_fJ3jGjSO+y3tP45DpJA7vH-696yYg@mail.gmail.com>
Subject: Re: [PATCH] mmc: cavium: Add missed pci_release_regions
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Jan Glauber <jglauber@cavium.com>,
        David Daney <david.daney@cavium.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Dec 2019 at 08:54, Chuhong Yuan <hslester96@gmail.com> wrote:
>
> The driver forgets to call pci_release_regions() in probe failure
> and remove.
> Add the missed calls to fix it.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cavium-thunderx.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
> index eee08d81b242..76013bbbcff3 100644
> --- a/drivers/mmc/host/cavium-thunderx.c
> +++ b/drivers/mmc/host/cavium-thunderx.c
> @@ -76,8 +76,10 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
>                 return ret;
>
>         host->base = pcim_iomap(pdev, 0, pci_resource_len(pdev, 0));
> -       if (!host->base)
> -               return -EINVAL;
> +       if (!host->base) {
> +               ret = -EINVAL;
> +               goto error;
> +       }
>
>         /* On ThunderX these are identical */
>         host->dma_base = host->base;
> @@ -86,12 +88,14 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
>         host->reg_off_dma = 0x160;
>
>         host->clk = devm_clk_get(dev, NULL);
> -       if (IS_ERR(host->clk))
> -               return PTR_ERR(host->clk);
> +       if (IS_ERR(host->clk)) {
> +               ret = PTR_ERR(host->clk);
> +               goto error;
> +       }
>
>         ret = clk_prepare_enable(host->clk);
>         if (ret)
> -               return ret;
> +               goto error;
>         host->sys_freq = clk_get_rate(host->clk);
>
>         spin_lock_init(&host->irq_handler_lock);
> @@ -157,6 +161,7 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
>                 }
>         }
>         clk_disable_unprepare(host->clk);
> +       pci_release_regions(pdev);
>         return ret;
>  }
>
> @@ -175,6 +180,7 @@ static void thunder_mmc_remove(struct pci_dev *pdev)
>         writeq(dma_cfg, host->dma_base + MIO_EMM_DMA_CFG(host));
>
>         clk_disable_unprepare(host->clk);
> +       pci_release_regions(pdev);
>  }
>
>  static const struct pci_device_id thunder_mmc_id_table[] = {
> --
> 2.24.0
>
