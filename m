Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 718D42075B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 14:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfEPMyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 08:54:44 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36505 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfEPMyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 08:54:44 -0400
Received: by mail-vs1-f67.google.com with SMTP id l20so2252109vsp.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 05:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5JFKFzEG0xBUwD7HIYkZnnh9dqUah7E+Ib/gYxU2vLc=;
        b=VYoxyClJ3IjCVsog1UOHY1j+te4vzK7Zn2KD34QyuMIWoFuDNp2DKcFQsGF7V5m1+7
         9TjRCmfp8zPch4KoXHkfiEsy94k9AIuh7YLakWy4P/y4oXwuJlYONSjl0JX9V0ajbr6v
         +0DcWGGJ63IhmWOGKLnbLaXwZa6K0t2YEfKHqwyZrkAIlahHSxIvEmiv8NjKLjsb/Z/s
         BwwGWbUZWgcHXmcdk1Y858SQGg5Fa9I9UqDHVf2ZLb5pjWASAuLCnZazpDqjQUtKNmww
         QdbHS9uJTFRRPv2+3ogrqq5IM09zMxLdUcwvpGgFIT/9DjcNWIAGPbYTEiMhAUhA9X4h
         JNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5JFKFzEG0xBUwD7HIYkZnnh9dqUah7E+Ib/gYxU2vLc=;
        b=r52aBSk8A61xF3TUinLsh7yj4CtzK5c49MkoZKFTrRoRGlBs3aAt7x00BQZDM2X0dF
         KcIfW6F1Sz2IOLhdpRsywGAcUR/7e9U7646gA1lGpJem2IdLyGRvXZe9HOGepE6k/eny
         GjiswHQVDtBGHaNTx3nd8VQ9eZJqxdBX1PNmUGsQAhBH+M+J/NQnHVEkANRaWndBIRqy
         Tpvg4kE0inj1HydOdJTj+Zpqd1Yktz14eeHPIA8LYgYy78X5bj6LSnX4zLjo1mn19y6u
         a60D13FDZCcAkMTUqJDXVXvLZ1+B+PB8zJMI5TT33PpXVG3QOlZXDTDcNAAqv8a6SoIE
         TTww==
X-Gm-Message-State: APjAAAV8Ap9pBvVCWZIs8voLUBuXmR1lD28bMkaoI+DZiwCpTCnjKexz
        nPfp70UjLs2AxeHU1HDlIPI30oZWvBQ1/lLCiNDKKKQxd6RuQA==
X-Google-Smtp-Source: APXvYqzDDDWdu9fo9iPHY+ysVVykXsJWlZRil28ig+PCzrEXYHeHo4q5f7yXfu68QdSmpPfaBGotMnL52M7tvXUqMI4=
X-Received: by 2002:a67:c84:: with SMTP id 126mr8581637vsm.178.1558011283233;
 Thu, 16 May 2019 05:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <1557983320-14461-1-git-send-email-sagar.kadam@sifive.com>
 <1557983320-14461-4-git-send-email-sagar.kadam@sifive.com> <20190516123120.GB14298@lunn.ch>
In-Reply-To: <20190516123120.GB14298@lunn.ch>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Thu, 16 May 2019 18:24:32 +0530
Message-ID: <CAARK3H=L2AFtog6wdJGU7rKi7yk-AzDgFdjcjktZgkqdDwnOZQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] i2c-ocores: sifive: add polling mode workaround
 for FU540-C000 SoC
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Thu, May 16, 2019 at 6:01 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > @@ -682,13 +693,24 @@ static int ocores_i2c_probe(struct platform_device *pdev)
> >
> >       irq = platform_get_irq(pdev, 0);
> >       if (irq == -ENXIO) {
> > -             i2c->flags |= OCORES_FLAG_POLL;
> > +             /*
> > +              * Set a OCORES_FLAG_BROKEN_IRQ to enable workaround for
> > +              * FU540-C000 SoC in polling mode interface of i2c-ocore driver.
> > +              * Else enable default polling mode interface for SIFIVE/OCORE
> > +              * device types.
> > +              */
> > +             match = of_match_node(ocores_i2c_match, pdev->dev.of_node);
> > +             if (match && (long)match->data ==
> > +                             (TYPE_SIFIVE_REV0 | OCORES_FLAG_BROKEN_IRQ))
>
> This looks wrong. You added:
>
> +       {
> +               .compatible = "sifive,fu540-c000-i2c",
> +               .data = (void *)TYPE_SIFIVE_REV0,
> +       },
> +       {
> +               .compatible = "sifive,i2c0",
> +               .data = (void *)TYPE_SIFIVE_REV0,
> +       },
>
> So match->data just has TYPE_SIFIVE_REV0.
I updated the device_id table into two logically separated patches as follows:-

1. Update device id table for Sifive devices
    [PATCH v3 2/3] i2c-ocore:
                  .data for sifive,fu540-540-c000 and sifive,i2c0 both
are for sifive devices hence TYPE_SIFIVE_REV0
2. Add polling mode workaround fix for fu540-c000 SoC
    [PATCH v3 3/3] i2c-ocores:
                  .data for sifive,fu540-540-c000 is of
TYPE_SIFIVE_REV0 and has a broken IRQ so the flag
OCORES_FLAG_BROKEN_IRQ is OR'd to data into device id table.

Please let me know if you feel patch 2 and patch 3 need to be squashed
together into a single patch.

>
> > +                     i2c->flags |= OCORES_FLAG_BROKEN_IRQ;
> > +             else
> > +                     i2c->flags |= OCORES_FLAG_POLL;
>
> These two don't need to be exclusive. It makes more sense to say
> SIFIVE needs to poll and it its IRQ is broken. A lot of your other
> changes then go away.
>
Other SiFive chip's with Ocore based I2C re-implementation might not
need the broken IRQ workaround.
and can use the the existing mainline polling mode interface, using
OCORES_FLAG_POLL.

Thanks & BR,
Sagar Kadam
>        Andrew
