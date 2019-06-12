Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0E341F9E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 10:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407407AbfFLItc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 04:49:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42717 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406833AbfFLItc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:49:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id t28so14337854lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Go55dDXBxVBTWBgHjRr7inycAYbApdoypRw2tPb4kWQ=;
        b=XULc8GkrnhaQZap8xerLTLJbDC4Vu3G3CYe+YRnGb9SOhgJo8QyYfbP/z4RLyLHyGO
         JI097H7HICDQV6/JiBVxzTFPbxvFr55c32ket0JRA1wepBTGOVMGHDkQkQpf+qPWOppC
         b6Ped6QGTDS2BkRxpdvw7W37G6Oe1I8/47flObJxn8Fv/sI+3J+Gq1x0SbMT+EU4kCL1
         m4UVOBVgo6/Abl2/aqX53jzwfKm1saWCRdhn8m88+wTfefqD5QyqRwgi/ZZsZELMBKYO
         w5Tkl1ULDEl4uCWNJ7yAGLlJK6bx7xmyGchKTAvL+v88bUvCxyYdhBcbDYsqsjpMRGwU
         QQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Go55dDXBxVBTWBgHjRr7inycAYbApdoypRw2tPb4kWQ=;
        b=U/E7aPlesRmdm87Va2ToXWuhbX36+IgfN1cuXEZvmtmEBLDf5wxta9j3RC89ceWla5
         dgPg/8gI6ueBXYR3fnEUzgK4X1FXJZbu2ibmggTYliFnjWWoKWC9EoyKgTSGG8BKB7fw
         D+F7hHgl5MFcv7dMYVyAKMPMrOQ/PymiYBxFIL30iyIKwxvz2PZ1bJBcY/O3jCzq1ToX
         Y+6cWFKbOIPnYmw0YbIlaMT+8lEZUr1uNw1IqkfXOVMBqH+ADgU1rfqPw7lRWVQU/Tdg
         K+SNnA9pAPJwYaxidkKMrh7B7yqu6d4ocOU2wlIe9vYlJpAiCynWiJEakda22yxXi+7J
         YWfQ==
X-Gm-Message-State: APjAAAWr05iamxsnYedNFQ1gBOnhDvHTP6TzXmZS1hZ4qjJ+geqTaPtI
        9RU9crvdtzMzclJF+VNbim1oqCjPljLJV9IgXl2t1A==
X-Google-Smtp-Source: APXvYqzT4UuSfXJUfCCGnwLeNcRt44Bq6L/QA4xe4AKQZSNz6rHdkZ/b4iGfLvjO/pGIhZkElV+yC5wfkayrlEYjqP0=
X-Received: by 2002:a2e:5dc4:: with SMTP id v65mr33005733lje.138.1560329370020;
 Wed, 12 Jun 2019 01:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-9-grygorii.strashko@ti.com>
In-Reply-To: <20190610171103.30903-9-grygorii.strashko@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 10:49:18 +0200
Message-ID: <CACRpkdY4eUN=E6BD-J=8oo+QjDPhL8giFasNrb-=vvGE7dTy1Q@mail.gmail.com>
Subject: Re: [PATCH-next 08/20] gpio: gpio-omap: simplify get() method
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Russell King <rmk@arm.linux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 7:12 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> omap_gpio_get() calls omap_get_gpio_datain() or omap_get_gpio_dataout()
> to read the GPIO state. These two functions are only called from this
> method, so they don't add much value.  Move their contents into
> omap_gpio_get() method and simplify.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
