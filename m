Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B64118420
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 10:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfLJJv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 04:51:59 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40561 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfLJJv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:51:59 -0500
Received: by mail-ua1-f65.google.com with SMTP id v18so2279136uaq.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 01:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xUN3rGfqd0QTJZr6aZxtmVJn1us7qeeluWmJXj0Te7E=;
        b=xggK1nB9ejv8RrFLLP7MF/oV73DlomCcEFt6HG/TCk2YTOnfjzU3+OzQE8gFIrWdVJ
         TtWMwOMAm+lNOHbSBgqqfcWGtcvUCv75lA3LChaXWTTz0IACzZ6lxZQSbnTN3Fb3DP2O
         IJuvDyC789CqjCdgQcDf5UoOTHebBGiol9I8m3u0iIMym5mvaHzTt67ZcXglu22tZM6l
         vj4qeiLkVAYovR5jRIo0hNv66L1NOWtskL6JUwzFKzCajY4uwA3NIaWBXmgWfJSWKlEj
         WWrieoWz89mX714X7EAYQ87oD6/+ERYpjZqPZoyFB1vPFlOGCcfg9yzMlnZJzgMAYDNB
         /0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xUN3rGfqd0QTJZr6aZxtmVJn1us7qeeluWmJXj0Te7E=;
        b=H0p5iZ+53kMUmjCUYJbr+c9mOdOG1fFJ9b7+yEy1mg04Rdn/mawGlaSomF++LUimQk
         S0OmVGxjDuoxG74KuGF/j+ZMbXjpl+rs4Kdt6YLeWdXnBvcw/AjN9512CwG4u6J/uN6l
         sAC5RLJLTwHK6qHW+vbqH4e0cX4ah+PLLqyezcg4t0rzmUbZdf4aJAiSw/WwE6uT7+bk
         B6F4UiaCTq+VBeJK8Q2I36jNqUh7KwjnxYHoc/8uo1kzoaPuCjClwKtmpZwf9w0DckDE
         cniYFhRk7PP8ZvyCnSO24vEzezGlff/T1sNpgOA1IdECOPDbemV7dnYBBD9bIqyA7Y6c
         pesw==
X-Gm-Message-State: APjAAAUxM7Lve0tvLs8zGfQ0Jmxw9ZYVrxW9C+Jk7LZTZEt6bLqkrsOL
        ddxiz87EzDqTZa6Hbbs9P9SE4Ulo8GnY4ISD+XTnRw==
X-Google-Smtp-Source: APXvYqxI9QdLGOMqq6QaCpjOk+V2l3LXtFs7IfnhUjP0TmSsF2jOR5CpH0EuMu4/BYNbPnekTo3AHs1xkdV1CNj9hNE=
X-Received: by 2002:ab0:2759:: with SMTP id c25mr2903677uap.104.1575971518126;
 Tue, 10 Dec 2019 01:51:58 -0800 (PST)
MIME-Version: 1.0
References: <20191204071958.18553-1-chaotian.jing@mediatek.com>
In-Reply-To: <20191204071958.18553-1-chaotian.jing@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Dec 2019 10:51:22 +0100
Message-ID: <CAPDyKFo9Z2yj7zC5VOS-iX_LyavPp1A4n73eAp7VD-Q+dpoqpw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: fix CMD_TA to 2 for MT8173 HS200/HS400 mode
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>, hsinyi@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2019 at 08:20, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> there is a chance that always get response CRC error after HS200 tuning,
> the reason is that need set CMD_TA to 2. this modification is only for
> MT8173.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

I have applied this for fixes, however it seems like this should also
be tagged for stable, right?

Is there a specific commit this fixes or should we just find the
version it applies to?

Kind regards
Uffe



> ---
>  drivers/mmc/host/mtk-sd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 189e42674d85..010fe29a4888 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -228,6 +228,7 @@
>  #define MSDC_PATCH_BIT_SPCPUSH    (0x1 << 29)  /* RW */
>  #define MSDC_PATCH_BIT_DECRCTMO   (0x1 << 30)  /* RW */
>
> +#define MSDC_PATCH_BIT1_CMDTA     (0x7 << 3)    /* RW */
>  #define MSDC_PATCH_BIT1_STOP_DLY  (0xf << 8)    /* RW */
>
>  #define MSDC_PATCH_BIT2_CFGRESP   (0x1 << 15)   /* RW */
> @@ -1881,6 +1882,7 @@ static int hs400_tune_response(struct mmc_host *mmc, u32 opcode)
>
>         /* select EMMC50 PAD CMD tune */
>         sdr_set_bits(host->base + PAD_CMD_TUNE, BIT(0));
> +       sdr_set_field(host->base + MSDC_PATCH_BIT1, MSDC_PATCH_BIT1_CMDTA, 2);
>
>         if (mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
>             mmc->ios.timing == MMC_TIMING_UHS_SDR104)
> --
> 2.18.0
