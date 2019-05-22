Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C34A26673
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 17:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfEVPBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 11:01:00 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36885 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVPBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:01:00 -0400
Received: by mail-it1-f196.google.com with SMTP id m140so3551010itg.2;
        Wed, 22 May 2019 08:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aIzrHS5nLBf6pyiovGTr1aWzg7NgzfwfpU/6nbGyolg=;
        b=BD7xcKs/duZRRzHLDo7wNqdwMY5oXP4NZBypwS3LAI+SZ5LXCAKS+P8gltfDeN2Qrz
         b4aAFqqRLy8Fx6zEai6NLkMqEbHB6GZwyk/B78K1P90RWGGGEdSAf8AwfOWAmqD2GUG2
         NVzhGGXUk8xIoP4ns9cfeY5FYVPGpisQDXX6yD9Ot+rJ98osYrBokKhdIRUIoo5v7/H7
         o3reQpJtdq9u47s5xyOEiY0DYIyeMtZ27dajDF1bRZEWM0HnU+wmhjr3XTIQngUAasHz
         9lrOLvNjoopihTQJW2j3MRX2LqH1C1gz/MqRJH8SwC37noIL5bqhqK2+VcQG3KWnmsm2
         RklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIzrHS5nLBf6pyiovGTr1aWzg7NgzfwfpU/6nbGyolg=;
        b=gOOGt+U/0tES7DGG04Yho9WzOnk6pESmhZayVdWlS8B1UbvrCHuDE66+h2Z3XaCs+W
         oS6Wj8fL3KmIYRDZFRCr7sEXnApKcD/hSwZZQyxWXQWqPuGUnzCdTSXkFseMJaDyHvxB
         WGqv0ZXdqjqRQT2eVMD0l6n7C/e6QppCbiO1Y1jg3YXC4N9XVM4xB7ZyhculhPWokqDG
         3wYw/rUPhpGVL4rbwwZIGcgtpxVvbeViVgsKZ7qpIp8DmB3J3/mInaVc3UfMwVaUAyEC
         oZEOHfwrCzq55ZoOCYUzZz5eYzUlpmWJESUnIJg8LbiSVHkDO8Opm0WS/vsiKgsSUW3F
         05tw==
X-Gm-Message-State: APjAAAXWWM4x8W2XAHBBajTioa0R/3QNGLyGcZHIRQC9vMsWvswgzCSN
        9sSL3JeREEbmjkDmp8CBdQBfG3rU45TDMhrwxkPGd2BG9AE=
X-Google-Smtp-Source: APXvYqx4KcQotZMs/inGYcNvV6GW292VABI1Mzl46kBHGTl2TiKpifmJH/NUoivR+MQ5OQKRcC5GMJ9EwzfY5wRbIl0=
X-Received: by 2002:a24:91d2:: with SMTP id i201mr9261893ite.88.1558537259711;
 Wed, 22 May 2019 08:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190409120908.12079-1-alexandre.belloni@bootlin.com> <efaaff85-ac39-f0e2-e042-7d6fd0c59054@zaltys.org>
In-Reply-To: <efaaff85-ac39-f0e2-e042-7d6fd0c59054@zaltys.org>
From:   Sylvain Lemieux <slemieux.tyco@gmail.com>
Date:   Wed, 22 May 2019 11:00:48 -0400
Message-ID: <CA+rxa6qJDEvg6wCuaLo4yhqa6uZ45rKXcbGwE_XnWkjy2j9YAA@mail.gmail.com>
Subject: Re: [PATCH 0/5] usb: gadget: udc: lpc32xx: add stotg04 phy support
To:     James Grant <jamesg@zaltys.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Felipe Balbi <balbi@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You can add my "Acked-by" on the 5 patches.
Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>

On Mon, May 13, 2019 at 7:32 AM James Grant <jamesg@zaltys.org> wrote:
>
> Tested with a board containing LPC3250 SOC and STOTG04 PHY by using
> serial gadget.
>
> Needed patch "[PATCH] usb: gadget: udc: lpc32xx: allocate descriptor
> with GFP_ATOMIC" also.
>
> Tested-by: James Grant <jamesg@zaltys.org>
>
> Regards,
> James Grant.
>
> On 09/04/2019 14:09, Alexandre Belloni Wrote:
> > Hi,
> >
> > This series starts to clean up the lpc32xx udc driver and also repairs
> > interrupt handling so hotplugging actually works. The design I tested
> > that on uses an stotg04 instead of the usual isp1301 so support for that
> > is also added.
> >
> > A bit more work is needed to get the RNDIS gadget driver to work.
> >
> > Alexandre Belloni (5):
> >    usb: gadget: udc: lpc32xx: simplify probe
> >    usb: gadget: udc: lpc32xx: simplify vbus handling
> >    usb: gadget: udc: lpc32xx: properly setup phy interrupts
> >    usb: gadget: udc: lpc32xx: add support for stotg04 phy
> >    usb: gadget: udc: lpc32xx: rework interrupt handling
> >
> >   drivers/usb/gadget/udc/lpc32xx_udc.c | 167 +++++++++++----------------
> >   1 file changed, 66 insertions(+), 101 deletions(-)
