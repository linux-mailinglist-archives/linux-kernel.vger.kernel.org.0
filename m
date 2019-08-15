Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8878ED13
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 15:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbfHONjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 09:39:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44050 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732335AbfHONjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:39:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id e24so2231728ljg.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 06:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/SOlumz6vk2Alm/CYh7S2Oejxh0Xe/C95oR58raMHnQ=;
        b=Bqv5iBRPvFl2b9VdsUGma7yaA5FL4jWGwfAzscFHwHgVn2LkIz6NuqRaS3ifedqu7t
         Zl7nkg7Uvq2YawfNEJDqo0IYmfIhnGM6j1EU/ZuUjmua4FPdl6LRWb6bSeIV+U0Sy44Q
         sROgcq6zOpSCERywNRarUg2G+rFt2vOyPf9FWZmSyerZuCp8sAqpkmh3gJONeWc4aH47
         JwsXgTRJArkMPd/jBm9NQ9aNekx8d+hIw0V02KXdw6uP/wWAr+bkxjv5FWgCcCPAzN5b
         +79RHCgxN2dvNUlunVHE72i3dFzwn0IA3O/C+Qz/QpA1t4b0CAGIa20oHiT1OEqgIcR1
         ulLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/SOlumz6vk2Alm/CYh7S2Oejxh0Xe/C95oR58raMHnQ=;
        b=Vkbt4aO21dJ0VE8QMo0kJL8iOhtefr9yh9X1KHJtAyiIWO+ttu2pfLJes04xKW0zqV
         tESdKuFQW48qva2lJLxEXXU0oJ4Os8GQP9Qvci0ikEim0HnsWJCKKtjhQ0SYQf9BLhgV
         BuN51FYxWvKxH2PJIPbKUOhamM+7BKPcPOcVpuk3HOkAOzqekNo6OUhlnwBdzjuNGrpO
         ZPvItR4c4xjSdbJakJ5t0hFXAUEXjvqtNfdsVMwe1MscrELMFeyLjzIQFWdknCn5Qmxf
         5ia8zVNJ4jENnvchAdrbreLMFipjff0sk7bzokYKD3x+y+c49mwqTdhjcDdzjK7ZZglz
         DWjw==
X-Gm-Message-State: APjAAAW+0v9gE4N5gHkmNIupbVOB3CXbjuLNpeYdD06mAXcObVUql+aR
        3LWBJFeYaNv9mP7JeAvMoyjz3HEvvG2pTXsuwTfoOg==
X-Google-Smtp-Source: APXvYqwFALZTskPXo6e7NXJ/utTQfhrRgdFbqggPbykgoqXnV4m7nNI5t8VLZQOj3hti8lr1yIIaXwLEq2Y74hb9jMA=
X-Received: by 2002:a2e:3a0e:: with SMTP id h14mr2771959lja.180.1565876359961;
 Thu, 15 Aug 2019 06:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <5D514D6F.4090904@hisilicon.com> <CAHp75VcKNZeq80hw5qjKKuh8Qg=WUrXPSpcy6yx5h-_7RHah+g@mail.gmail.com>
In-Reply-To: <CAHp75VcKNZeq80hw5qjKKuh8Qg=WUrXPSpcy6yx5h-_7RHah+g@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Aug 2019 15:39:07 +0200
Message-ID: <CACRpkdbJS-b4E84qU7Knt7ND9WHwKh_d1MdawrFf4Ht_MHt2xw@mail.gmail.com>
Subject: Re: [PATCH] gpio: pl061: Fix the issue failed to register the ACPI interruption
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>, jinying@hisilicon.com,
        Zhangyi ac <zhangyi.ac@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        Tangkunshan <tangkunshan@huawei.com>,
        huangdaode <huangdaode@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 3:10 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Aug 12, 2019 at 2:30 PM Wei Xu <xuwei5@hisilicon.com> wrote:

> Linus, I'm wondering if we can do this for all inside the GPIO library.
> Thoughts?

If it's supposed to happen exactly the same way on all ACPI-enabled
gpiochips, I think it is more or less mandatory :D

We need to be sure we're not gonna have to quirks for misc variants
of GPIO controllers down in the gpiolib-acpi.c as a result because
some ACPI-thing is "standard not quite standard" though.

Yours,
Linus Walleij
