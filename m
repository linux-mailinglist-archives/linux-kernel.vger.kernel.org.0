Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C568A194160
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 15:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgCZO2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 10:28:52 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38658 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgCZO2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:28:47 -0400
Received: by mail-ua1-f65.google.com with SMTP id h35so2167634uae.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dpR7Oxz1qNUziJu9EkZNTQU3ukjyRpCe41037a5byCM=;
        b=A5cZNsK5c5uZutnm0OIXGS+KX7eNfN7wqt28zszCZAhqy6YCJE5AXwTRTNuYDXqs6O
         kVy906+0sjz7Ea81h3wXaysYdR1rk2YkZaFasf8szBzhyoNf2RhFmIDZJ7itRAwGsL6p
         WNZ1EWZMpmNa1RW0Y3ztF9PD6W/8Tg1LWwKb/Dsx6bkaaASYPLcIsKa1lSndDFWS+ybG
         vY5Q33UTJBetKrYcvjeakGfoc+euPMjtKyS/THQ2N6reNORXrSfKGjJesQFgGTNoI4U1
         wHF6ka30AIQAMrzkrofwUZOiYP3y0tSwom2KGfmjP0/uZtxcc0DRdQQw0w++JfPFBHFp
         PX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dpR7Oxz1qNUziJu9EkZNTQU3ukjyRpCe41037a5byCM=;
        b=AmGosdbjJpklTBQHSdfCjREKvPNQHv5xLson3Q0PCsW3UX3vkMNVf9aOz15796wd1I
         PlHeG24X17gfq8+E9fNCYa/JRL/3YocM/tKc0uV85LPle8s8M3tuYuJbENCEMziISP93
         BppI05RqglOMozqui5wROeFxoBMpsB7GVD9fXbxS2qhHGHQQSZUC7j+QyS/IqOUNJDaR
         iUyZBGlZFvjCN5+KozSGk8wYpnOmbCSX+gw1SWYfMjUrHzOx9b6J1dUVklzDG2ClvuSx
         8TKz4P5cBS13SsMRx/NtaIc0YpGWd1XcdGhsbFo3Ipj816PQOdiH7n0A/BRiozut9cnT
         uVqQ==
X-Gm-Message-State: ANhLgQ2TgplRWMm0Wl1wrXBY9rXDf5gM2u7Q6/b9eBwxoxHCF41cV1Yy
        Kzk88ph8V7SYYTVtwQ8KjWjT3mlanKdTbUChIvkryw==
X-Google-Smtp-Source: ADFU+vtSP1ZWeFS0v/IYE0yhokN9YWSHWu7abe9/C6yo19lM7d8FYypGhqrHHkutkPFQ/tySL6jnvOiMocB0QKtvN6g=
X-Received: by 2002:ab0:6204:: with SMTP id m4mr6628927uao.15.1585232925473;
 Thu, 26 Mar 2020 07:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200325143409.13005-1-ludovic.barre@st.com> <20200325143409.13005-2-ludovic.barre@st.com>
In-Reply-To: <20200325143409.13005-2-ludovic.barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 26 Mar 2020 15:28:09 +0100
Message-ID: <CAPDyKFo-Lgikwf=PUAd1naXxiyn=z425sTXX9O39__Xi39oUYQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] mmc: mmci_sdmmc: fix clear busyd0end irq flag
To:     Ludovic Barre <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 at 15:34, Ludovic Barre <ludovic.barre@st.com> wrote:
>
> The busyd0 line transition can be very fast. The busy request
> may be completed by busy_d0end without wait the busy_d0 steps.
> The busyd0end irq flag must be cleared even if no busy_status.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Applied for next, by adding a fixes+stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index f76e82f8f12f..d33e62bd6153 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -358,11 +358,11 @@ static bool sdmmc_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>         if (host->busy_status) {
>                 writel_relaxed(mask & ~host->variant->busy_detect_mask,
>                                base + MMCIMASK0);
> -               writel_relaxed(host->variant->busy_detect_mask,
> -                              base + MMCICLEAR);
>                 host->busy_status = 0;
>         }
>
> +       writel_relaxed(host->variant->busy_detect_mask, base + MMCICLEAR);
> +
>         return true;
>  }
>
> --
> 2.17.1
>
