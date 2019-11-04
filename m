Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E76CFEE29B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 15:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbfKDOdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 09:33:51 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42232 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfKDOdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:33:50 -0500
Received: by mail-pg1-f196.google.com with SMTP id s23so8033142pgo.9;
        Mon, 04 Nov 2019 06:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y0LjwwudNxoKXLMFauDhc+7y1KSWawa3U8V/1y04qhY=;
        b=W3u/M/m8YPcgoIbvOq3z+AScd9MMk40jPqIPQgOzYCSQ5/gufeqYXWhrfS4AkTVd1Q
         jYOl1O8z/3IGl+X7b8MQ4Y/poh2Sweu4BsvaK3vOlnl/jY8mv8TTNCwLaraIPdxPoG0G
         JraidkM2O04yJwgYQbYt71l7lm0ZmKblXMAnCkjNV5RKQ4kAtpv23/1JAYFQvW5Xk7kS
         KLfd6BS+5CvHrCgEzAQS2xPBiuWiAs9p4UXpG7pLCAZ3H9vxT7z1YEGnaBr5fgN74N0N
         ie7IpevCE9DizovPo7YE+exr0mDFZfYVYsRPWrFWovUcHvpuK1Eij7O7GRdlQT9gSoQk
         XpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y0LjwwudNxoKXLMFauDhc+7y1KSWawa3U8V/1y04qhY=;
        b=BdzBCll3Zzkhh2SQpohKFzbdXkOhCUr9lgk9ie+QrRg2LqH84DrH487G1SPJn1vbnS
         ldEDjyFw9//s873xJLYeiIxhXjHFGfVxwcY3rc/nE9evxM0+a+f8Wt3S5OW3UR/Wvywo
         ho1pFhQ8cQrnEwMLspydCDfw5qDR4lQ1kirXNtxhtBHVL36jyN95cT+9Dr4Hc5YHo5P6
         CV+TbSQe2eClcpI7A+VEi9kCe3oRCXih9nsGy6yLUSZ8DSFqRrWF1UIOFshf7zp1Cbpd
         Q+krnXtE+u9VTm1m/vQ46rKZrVZWsiiDtdL8Xh1uQTKXPLvylVBm/Kytmh2GwD3SNz+t
         RyhQ==
X-Gm-Message-State: APjAAAU0eGVH4EhFjg2WdQBwaQGutdDY9hE8MQcxb1QH63mvkDgulGVo
        glllZSOlOlcQIER2F3af1peJ8z2ct31pU4uR4qw=
X-Google-Smtp-Source: APXvYqzWBznWzT1SNSexxUG7YFpcNOyrpq2OEJL3zO7BFJXo/sn/h9Fo+N22Dk38B51SR9YoC/Pw8q12nowE0T29nEE=
X-Received: by 2002:a65:5542:: with SMTP id t2mr29785749pgr.74.1572878030045;
 Mon, 04 Nov 2019 06:33:50 -0800 (PST)
MIME-Version: 1.0
References: <CAPW-Pu0KuxqbKSQ2JQaxh5AHbdZdNQZJfOgxoe_XZSxow+9e3A@mail.gmail.com>
In-Reply-To: <CAPW-Pu0KuxqbKSQ2JQaxh5AHbdZdNQZJfOgxoe_XZSxow+9e3A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Nov 2019 16:33:38 +0200
Message-ID: <CAHp75VdWSfR+4kMA470ZVBHiDi_HCGOwS6q=xOg0neubcxGG8Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] asus_wmi: Support of ASUS TUF laptops on Ryzen CPUs
To:     Leon Maxx <leonmaxx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Daniel Drake <drake@endlessm.com>,
        Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 12:53 PM Leon Maxx <leonmaxx@gmail.com> wrote:
>
> Hi,
>
> this patch series adds support of ASUS TUF laptops on Ryzen CPUs to existing
> asus_wmi platform driver and also fixes minor bug.
>

All three patches are broken. Please, fix your MTA / MUA (for the
latter one it's highly recommended to use git-send-email).
You may test patches by sending to another address you have in some
extarnal domain.

> Leonid Maksimchuk (3):
>   platform/x86: asus_wmi: Fix return value of fan_boost_mode_store
>   platform/x86: asus_wmi: Support fan boost mode on FX505DY/FX705DY
>   platform/x86: asus_wmi: Set default fan boost mode to normal
>
>  drivers/platform/x86/asus-wmi.c            | 57 +++++++++++++++++++++--------
>  include/linux/platform_data/x86/asus-wmi.h |  1 +
>  2 files changed, 43 insertions(+), 15 deletions(-)



-- 
With Best Regards,
Andy Shevchenko
