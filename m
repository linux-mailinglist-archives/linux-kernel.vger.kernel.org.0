Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C709103A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 13:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfKTM7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 07:59:41 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:36222 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbfKTM7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:59:41 -0500
Received: by mail-vk1-f194.google.com with SMTP id d10so5997932vke.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 04:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mv3ivjIPtynZHdywCSMliDx/clqr1q5FAXmvUn8sv20=;
        b=DZZd0nosT6fMGQa1LrZVBdRXKbdVyqsPindUQS1a1nqo5KvOOvDL6TYkJpiTiwvqJm
         kj/g0mCy/d36pCSmPRACtWRYhBo+puCWySIvVjJkhBdjQlOJX/vdsIwvOFJXKTqWEIkJ
         qilWi7YApsYcUIF/Ghp5HFDBliyzAw2KPYzEBMtEnuPBotdX72kg7XjjLYcdPlzZ6eTE
         mJzOOAhDrtjtwPvojZ3vCHKnUlRdvUb5r2UjPybqDbDV7PKTti/mA0zC4GArhWLwD1pu
         09jXs0Rs4TfHjCztF/mr43pLNjcug2oAeU+TFTbYX8J1siDHLBfAw3ku2nwrQVzY2d3/
         8HkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mv3ivjIPtynZHdywCSMliDx/clqr1q5FAXmvUn8sv20=;
        b=HeYPMB6LtmxiTCvx/+pAxbCEWko3s9win20ru069mZ5ZBLixfksWIYNEEgKSXCQr3q
         1a1XYa5/qr2YyDCxFai4prJiskcYghBhrVvv8RzDhuZqgrW7JqANQdyLwbcrFhv92sx9
         w3DL+xhPpn2K7wcT6OBidpjqpnAvlZFOp34lyMexROMD6oJ3PQFwb6p9zYlI1s8QjXdg
         mLjzbf8GXGnCW9MH0TWR62AGhSj146uGUjKQ5oc4YM8WBHJz1UnY8/1nKYkmXBVHEDRn
         NaokulGS4fB6NjEEgSkdNMFuUbPf2TMxYtyVyYYVPZv53KQ8mSRnasray78IulpeMTgH
         FUfg==
X-Gm-Message-State: APjAAAWA3iT3yofj4jSFMEyV0csBiw61N5bY/wPAcDTGkN7rKXDrldjv
        8vWEfC5G63zzfHrM1dwpaF96Wt/418jep1TNOVOgKQ==
X-Google-Smtp-Source: APXvYqxQDALgcQNWwHLSVFVl8w6QJkMBvvg1vKNEOr6M8d/if/KbiPE09YO/XzOrupoT94zbpYTuK0JTffdMAGJDNgk=
X-Received: by 2002:a05:6122:1181:: with SMTP id x1mr1311701vkn.25.1574254780111;
 Wed, 20 Nov 2019 04:59:40 -0800 (PST)
MIME-Version: 1.0
References: <20191118104646.3838-1-i.mikhaylov@yadro.com> <20191118104646.3838-4-i.mikhaylov@yadro.com>
In-Reply-To: <20191118104646.3838-4-i.mikhaylov@yadro.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Nov 2019 13:59:04 +0100
Message-ID: <CAPDyKFrshWd1P9dZGTSuU=5P0L6LSPz=v2nn+0SWi3ZZazKrRw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mmc: sdhci-of-aspeed: add inversion signal presence
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019 at 11:47, Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
>
> Add read_l callback in sdhci_ops with flipping of SDHCI_CARD_PRESENT
> bit in case of inverted card detection signal.
>
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

Applied for next, thanks!

For clarity, I am leaving patch 1 for arm-soc.

Kind regards
Uffe



>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index 8962f6664381..56912e30c47e 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -111,7 +111,19 @@ static void aspeed_sdhci_set_bus_width(struct sdhci_host *host, int width)
>         sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>  }
>
> +static u32 aspeed_sdhci_readl(struct sdhci_host *host, int reg)
> +{
> +       u32 val = readl(host->ioaddr + reg);
> +
> +       if (unlikely(reg == SDHCI_PRESENT_STATE) &&
> +           (host->mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH))
> +               val ^= SDHCI_CARD_PRESENT;
> +
> +       return val;
> +}
> +
>  static const struct sdhci_ops aspeed_sdhci_ops = {
> +       .read_l = aspeed_sdhci_readl,
>         .set_clock = aspeed_sdhci_set_clock,
>         .get_max_clock = aspeed_sdhci_get_max_clock,
>         .set_bus_width = aspeed_sdhci_set_bus_width,
> --
> 2.20.1
>
