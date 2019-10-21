Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8E4DE1A2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 02:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfJUA5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Oct 2019 20:57:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43683 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfJUA5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 20:57:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id n14so11391388ljj.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 17:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P0N78KoI75Hj59hJ0I2gcVqsjFplO4gxrv4G5I2+4wY=;
        b=mXQSV+xskxiAYbld+JVVUAM7zaTNgFNlzGaGMyyAvs/xTTJSXGLypKbNNa/ebuF2Co
         SzTAlstFFq8CpLRbU5Si81AeInxVQUiNsXtkQXI47YG/uJmxJmUA8bJrwVaZbooN1G7z
         IdOlfNltzzWIc078dsHchy/8jGJ2OtN4inzNzpBXWd8qgEjfz8mdjDEgeOPqZ+E1Ski4
         xxdg5bBAbuEpljaVamq9daPnDqN8aaa6LQw33F2HB6unuJT3acNoBKCon8jFGGKvvb4x
         ZMjcGmyvXEl4L7297moOas0yGdBd79K6BEgBlVfpfsWW6JOOfjxZkFwDckZpdsxPq25E
         yDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P0N78KoI75Hj59hJ0I2gcVqsjFplO4gxrv4G5I2+4wY=;
        b=sHJ6gEfzfumUt6b9D1i+zc4q+1JOJHHiNX/QDKkRu28BPdrpFHrknz2rfn03ToB1ch
         la4GPP5CquA7Zp07qXgj63NyPMJAAMqYbCyaeUWBE0qlQIEKEo8FqSRKvvhTlWwIXaMq
         W9XdP0rOKGWVfMkpbjoTluJgHH/b/45pxluqu7t1zbUHkheSV/vUDn7HvYobV6VYIrhu
         HqSMdENBVzcY5xi3SkaLKnYVVShDNLEFK1ondegw6FcnThwKyqIDTkwEhE4H/Tc+qOkR
         yujW3OrS7m0Gc1XpajTdjEhD1qnpcYA9yhEhYmKJYxNgIWo1FC51rXrjkadZ7haoJ9vL
         2OSA==
X-Gm-Message-State: APjAAAU/f+qsTaIOxmLDm/BGMIi/iniAYp6sIducjeT9GIH0gCum41pV
        pNSN4CF3yhErHRB3rCX2d542VZ9PGdQSaXitWKGYMw==
X-Google-Smtp-Source: APXvYqxPrMm6CyCmtsqcedLUxx1JQ8hJkvFjyPe1danPq+lfioMZVhJm0Lo4howbIW74oUzEEQUOvBdOXuk+Y2BOegs=
X-Received: by 2002:a2e:a0c9:: with SMTP id f9mr13068040ljm.77.1571619464557;
 Sun, 20 Oct 2019 17:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191015173026.9962-1-manivannan.sadhasivam@linaro.org>
 <20191015173026.9962-4-manivannan.sadhasivam@linaro.org> <CACRpkdZRY138RAf8N2xGam89r66ik2vW44OZx0bDcCt4P2GBLA@mail.gmail.com>
 <20191019160513.GA17631@Mani-XPS-13-9360>
In-Reply-To: <20191019160513.GA17631@Mani-XPS-13-9360>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Oct 2019 02:57:31 +0200
Message-ID: <CACRpkdbgFGciZMBF-_h5Wi47Hmco7tA9Pr7XegM8SpWxhqLT1A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] gpio: Add RDA Micro GPIO controller support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-unisoc@lists.infradead.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 6:05 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> On Wed, Oct 16, 2019 at 02:41:32PM +0200, Linus Walleij wrote:

> > select GPIO_GENERIC
>
> hmm.. I don't think this driver can use it. Please see the justification
> below.
(...)
> As you can see in this driver, there are 2 separate registers needs to be
> read in order to get the value. RDA_GPIO_VAL needs to be read when the pin
> is in input state and RDA_GPIO_SET needs to be read when the pin is in output
> state.
>
> The MMIO driver relies on a single `dat` register to read the GPIO state and
> this won't fit for this driver and hence my justification for not using it.

Use RDA_GPIO_VAL for dat, then set BGPIOF_READ_OUTPUT_REG_SET
and the mmio core will do what you want I think? That's what the flag is
for IIUC.

Maybe we should document it better :/

Yours,
Linus Walleij
