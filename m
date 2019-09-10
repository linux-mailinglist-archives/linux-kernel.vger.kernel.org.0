Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84F7BAE806
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 12:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393677AbfIJKZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 06:25:39 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:38433 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732679AbfIJKZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:25:38 -0400
Received: by mail-lf1-f48.google.com with SMTP id c12so12999299lfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 03:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=86PBgefI/y6X/Isd1n0htxpzll5TC6xu2rYWUoOg2+E=;
        b=ExqvI2xn9CJJpk4iCHBRebb8Z9iziuTPjPohh4nkXLq31YjmvLjecF8HaVD1b03Zwp
         BmLmeDpN/7+qkAbxeUzkffB2MRHqZfH+tOLHexeSWoxHaJNeMuv8HNdAPCnRcb1gZ/5a
         f5eHP58LUGy/385RwTvXwD+XwN0OPXFjOn9ytYD85Uxsc7OrZFqdclb8T7ch5gygoH86
         HaDeRzxgs4jW/Ig38MwZfRMFk3u/jWISZNWTwHDxy3wXACxguMRTIbjlki94IlZtP/0E
         /1te8vF5EdgDwHXV17XE18Q1yzV6xbuCWx62fuAhxy9QTlELMJa2cbelEUrW1X6KWzdp
         9DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=86PBgefI/y6X/Isd1n0htxpzll5TC6xu2rYWUoOg2+E=;
        b=CJrDcsq1ofbGrzV8h2ylRoM5nYy65T4onqTOu6Zl39dBd2MZLt14Q99Mqlw1AJqlqE
         ZSBcuonaUNXNNvCkKxOInTGHJ3Cpm8YsDR0AyTLC1pboxUepDjSWIBZe7Tkaprpe/mCq
         rSoDfOv+NG85p92NQO8PlnQE/oRNzLUpwAMh/ml6P7Iib7oYhwXZ27qb6PPcueHB8V5C
         SYApkcZjNXjSlXLhDNLsny7SQc7yK8aQYwVp/On40k5PqjZJZdY/UQRvh37I5BrEfKcR
         YQtfq77kFkLZ+u/a14qPsqjqfst4yF/YMHZ6kV1+LNX71FnkvLFpFhDLLYYaEp/XEtbF
         ZAfQ==
X-Gm-Message-State: APjAAAW5gA7o9B/Bs+n/S6tVUjAVaf9iVKNCh9hBKM609Jh13NxieNDM
        +Y1XqcX61hGy/MVCOhg7tNF4AaGsnrCkD+LYx+Cq5g==
X-Google-Smtp-Source: APXvYqxzAgxWmnCAlWjLbJSC2xDUVMd1qjJIhYHnDdxKGJ4zV+g693y3TgzFL0iinVPQnVMmNKjBkeRooOIaDrac4HQ=
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr20173197lfp.61.1568111136928;
 Tue, 10 Sep 2019 03:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190908085133.GA7233@amd>
In-Reply-To: <20190908085133.GA7233@amd>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Sep 2019 11:25:25 +0100
Message-ID: <CACRpkdYuaoc=0Ljn+xM8nqdo16-5tfS0=N5VeAnM6Lx0FME4Jg@mail.gmail.com>
Subject: Re: next-20190904: build failure in cp210x usb serial, gpio related?
To:     Pavel Machek <pavel@denx.de>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 8, 2019 at 9:51 AM Pavel Machek <pavel@denx.de> wrote:

> I'm getting this compiling the -next:
(...)
>   ./include/linux/gpio/driver.h:722:19: error: static declaration of
>   =E2=80=98gpiochip_lock_as_irq=E2=80=99 follows non-static declaration
>     722 | static inline int gpiochip_lock_as_irq(struct gpio_chip
>   *chip,

Yes this was fixed pretty much the same day the next release came
out, and by now I got like 4 different patches solving the same problem,
because no new next releases are coming out right now...
bad timing with no next releases during the kernel summit, sorry!

Yours,
Linus Walleij
