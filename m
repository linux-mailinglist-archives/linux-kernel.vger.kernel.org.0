Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71F71237FF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 15:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbfETN2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 09:28:05 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38163 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730928AbfETN2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:28:05 -0400
Received: by mail-ua1-f67.google.com with SMTP id r19so4632347uap.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=22AYQZzoG7Oe1jq6WNzXvotDPxdHztrQDTFuuJjGD78=;
        b=KB+CPJT2B2gTqpChkgYubBcoMAaSKKmohJm72ITD+9kxXbGDON4+fMeDfrWYISfepH
         3cdJhye8mj133t2xqh0X9RMCvkPiAnrPoRJjuScuMAxc9WbC6k1Oh4Z+Cccbqz9zUZjf
         d+vQYSR+sBkLz3ophnJIc1lEdzR5dJ4ZOcmMfy12tpgUEmf5E/aA/DV63qZeia8NLmxw
         lJ4Z6/PL+AhCYV3slJcRe4PvUQmjlONdMFsOzqlWOAkyOn93lkGcsz2onkvWAbyNEfU/
         RAgibC9WAm2cMFTFDj5XdoU/fxAwLyIYsH6IUUZjkok2lZX8X1InymPma68VtyeaUuIT
         OVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=22AYQZzoG7Oe1jq6WNzXvotDPxdHztrQDTFuuJjGD78=;
        b=sk4Ksuv1ibxO5RFKVJhodj1IKQQaBsaDgB9LFArneeil0s04mxnB+FN+3dj6BQcfBb
         UUCYN2B59Vy9JtioJiiALSn8e+ofIc3Ua7bJLqkMxpa74118+f3efAGKLZS1iJrkTQS7
         LuEAjMdtS6VaKASRHnh0Lveq8JUjiaQM6OjtvnFRY1/w2uxZbcaxsqNN/zGypYNYjPrK
         6IXmqV0Uby+2JFrwVNo/rOarV06q/DgEbX5IlbSnub4CLTvyJhseoIOsICv3a8s2+2YI
         Y+iAuUTE72/Cx35pW8q5q7jqKXf7a28iHKIDhTCE0rKoyfm3FkAPmoAmbICPj5Onjgb9
         G+Vg==
X-Gm-Message-State: APjAAAW3DxXpfpXXDZMVf7rbT9jgiEhNXYII7AsOczNj6Tdi25Eww1fn
        dQyqBW1MAYrcLhS44vjhCkEpfgS2FmRVRaccPvi92LTJdqARcg==
X-Google-Smtp-Source: APXvYqwapFA3zJOmbxCEv+ksueO2t69F5DHKCwH1G0GdQycduLQrNvaH4w0zK9X8JYEmpaBjLAgnC2yANMyJKTOmNRA=
X-Received: by 2002:ab0:5ad0:: with SMTP id x16mr14383639uae.124.1558358884007;
 Mon, 20 May 2019 06:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <1558354817-12034-1-git-send-email-sagar.kadam@sifive.com>
 <1558354817-12034-4-git-send-email-sagar.kadam@sifive.com> <20190520124107.GA25785@lunn.ch>
In-Reply-To: <20190520124107.GA25785@lunn.ch>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Mon, 20 May 2019 18:57:52 +0530
Message-ID: <CAARK3HnZgiUOE3S7BOk9uC-MfmB4wO5zWFbuGGRFqKauYaX8yg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] i2c-ocores: sifive: add polling mode workaround
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

Hi Andrew,

On Mon, May 20, 2019 at 6:11 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > @@ -406,7 +416,7 @@ static int ocores_xfer(struct i2c_adapter *adap,
> >  {
> >       struct ocores_i2c *i2c = i2c_get_adapdata(adap);
> >
> > -     if (i2c->flags & OCORES_FLAG_POLL)
> > +     if ((i2c->flags & (OCORES_FLAG_POLL | OCORES_FLAG_BROKEN_IRQ)))
> >               return ocores_xfer_polling(adap, msgs, num);
> >       return ocores_xfer_core(i2c, msgs, num, false);
> >  }
>
> You are not listening to what i said. All you need to know here is
> that you must poll. It does not matter if the IRQ is broken or not.
>

Apologies for my miss-understanding. I will rectify this and submit a v5.

> >       irq = platform_get_irq(pdev, 0);
> >       if (irq == -ENXIO) {
> > -             i2c->flags |= OCORES_FLAG_POLL;
>
> If there is no interrupt, you need to poll. So keep this line.

Will retain this.

> > +             /*
> > +              * Set a OCORES_FLAG_BROKEN_IRQ to enable workaround for
> > +              * FU540-C000 SoC in polling mode interface of i2c-ocore driver.
> > +              * Else enable default polling mode interface for SIFIVE/OCORE
> > +              * device types.
> > +              */
> > +             match = of_match_node(ocores_i2c_match, pdev->dev.of_node);
> > +             if (match && (long)match->data == TYPE_SIFIVE_REV0)
> > +                     i2c->flags |= OCORES_FLAG_BROKEN_IRQ;
>
> If it is a OCORE, IRQ is broken, so OR in OCORES_FLAG_BROKEN_IRQ.

Got it, as device type SIFIVE is based on OCORE's re-implementation,
will OR in the broken IRQ flag and submit a v5.

> >
> > -     if (!(i2c->flags & OCORES_FLAG_POLL)) {
> > +     if (!(i2c->flags & (OCORES_FLAG_POLL | OCORES_FLAG_BROKEN_IRQ))) {
> >               ret = devm_request_irq(&pdev->dev, irq, ocores_isr, 0,
> >                                      pdev->name, i2c);
>
> Here you just need to know if you are polling. Broken IRQ does not
> matter.
>
>         Andrew

Thanks & Regards,
Sagar
