Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87570FD8DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 10:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfKOJ2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 04:28:03 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38725 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfKOJ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:28:03 -0500
Received: by mail-ua1-f65.google.com with SMTP id u99so2810987uau.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 01:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SxLLly/NDlRCS30fS9KIwQ6+KObnKWcAwfTZ0ZVdfoc=;
        b=s/vJKlHvRVRbLxSM9gw7Z2Ss/5b9KpGP8+dQXRh9GElgkA11nMKbvRg4sn5hIwKg5J
         VgQ3YiwM4S/MkTcME3YnZEKO9/Id0BVpWUbRzj+PU1ymRr71oGfDpXlkapBIGVRxogFy
         VxNx/LwqgSddqip8zTm59kZisunqqLVNGvcjlmRHh2GwnQ0Gp240oPLOO0seM1t0cDs9
         PKtGK5trxHgct46123f7/LFPkMAH+y/nesq0Lo/4cqlA8COgWAKQEW6LiUJgwWUHcIL/
         mFfqQUpqGvN3B3+sPfx4U0AibuqCcFX4FmR1hfIBztD9Sx8qVWE+4nsuIyJ8hdxVK3Xn
         zZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SxLLly/NDlRCS30fS9KIwQ6+KObnKWcAwfTZ0ZVdfoc=;
        b=uOLlX16yhcB6426ZPqjAktmDoF14sKjuIfsGwMr5+Y2sxgAl7eiJVhXgtUwOAFcPc7
         1aq2GnFhBDkHe63+i1L76CV9w5CyoMVZ9AW2LfM8uj0ZGNDyyPagYpitjdP8BkqEagw9
         6lexkk/RssKvwup2rvZRgIKMqJTWfKXkQsBg8zGQ0qmWRBsQqet8/r9xkQpoygqZBote
         mH9lqOMXonmzLk0VSLxWgbepNcHauCnpLopJYFqUSlZ9H6j5n4TFf5ennO5AWlgmWEEi
         TK5Pug6gOQt0OhlT6hqsYEwoLP+JdCvcJu238ufbfE9/mBqhvxbyHF3nhL/6ed8VXONC
         Jh3w==
X-Gm-Message-State: APjAAAXEFXkEPQ+2kMcdaAMbSznT4XiH5/lX95OnEPCi2mZ9/oyPm9ij
        /Jvk0ujyTtCUn7nTs/xM9rL2CPcDIceLyV3Kl+ghUw==
X-Google-Smtp-Source: APXvYqyzRwtFIjZ1mG/sfGTrmo5k+aGOrGMpYjafFb+fvgL/SdX5QSjvGsMOddkXeHjXeJsXGzGStJwvtyirThpsTBY=
X-Received: by 2002:ab0:2042:: with SMTP id g2mr8284571ual.19.1573810081741;
 Fri, 15 Nov 2019 01:28:01 -0800 (PST)
MIME-Version: 1.0
References: <20191112134808.23546-1-erosca@de.adit-jv.com> <20191112204952.GA2976@kunai>
 <CAPDyKFq8oVk26ruNA_R8HDXhMGKhDeHnL0q82xi40g1aeo109A@mail.gmail.com>
 <20191114113743.GA19656@vmlxhi-102.adit-jv.com> <CAPDyKFp5iqrFDM1EWnYBwFmQAiAA5FADDLAyuVVBgMu4Sx=x5w@mail.gmail.com>
 <20191114220744.GA17678@vmlxhi-102.adit-jv.com>
In-Reply-To: <20191114220744.GA17678@vmlxhi-102.adit-jv.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 Nov 2019 10:27:25 +0100
Message-ID: <CAPDyKFoXEFbK_7-Nmkhz2_Sifc=hiPEGmUHKsp4=Baye86TCOg@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi_internal_dmac: Add MMC_CAP_ERASE to
 Gen3 SoCs
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019 at 23:07, Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
>
> Hi Ulf,
>
> On Thu, Nov 14, 2019 at 01:48:41PM +0100, Ulf Hansson wrote:
>
> [..]
> >
> > Let's first take a step back, because I don't know how the HW busy
> > detection works for your controller.
> >
> > I have noticed there is TMIO_STAT_CMD_BUSY bit being set for some
> > variants, which seems to cause renesas_sdhi_wait_idle() to loop for a
> > pre-defined number of loops/timeout. This looks scary, but I can't
> > tell if it's really a problem.
> >
> > BTW, do you know what TMIO_STAT_CMD_BUSY actually is monitoring?
> >
> > I have also noticed that MMC_CAP_WAIT_WHILE_BUSY isn't set for any of
> > the renesas/tmio variant hosts. Is that simply because the HW doesn't
> > support this? Or because implementation is missing?
>
> Hopefully Wolfram just addressed that?
>
> > If you want to run a test that stretches the behaviour on the timeout
> > path, I would rather use an SD-card (the older the better). For eMMCs
> > the erase likely translates to a trim/discard, which is far more
> > quicker than a real erase - as is what happens on an old SD card.
>
> Running 'blkdiscard' with different SD cards on H3ULCB, I don't see any
> signs of misbehavior:
>
> root@rcar-gen3:~# blkdiscard -V
> blkdiscard from util-linux 2.32.1
>
> root@rcar-gen3:~# lsblk
> NAME         MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
> mmcblk0      179:0    0 59.2G  0 disk
> mmcblk0boot0 179:8    0    4M  1 disk
> mmcblk0boot1 179:16   0    4M  1 disk
> mmcblk1      179:24   0   30G  0 disk
>
> # Erasing 32 GiB uSD Card
> root@rcar-gen3:~# time blkdiscard -v /dev/mmcblk1
> /dev/mmcblk1: Discarded 32227983360 bytes from the offset 0
>
> real    0m1.198s
> user    0m0.001s
> sys     0m0.122s
>
> # Erasing 64 GiB eMMC
> root@rcar-gen3:~# time blkdiscard -v /dev/mmcblk0
> /dev/mmcblk0: Discarded 63585648640 bytes from the offset 0
>
> real    0m8.703s
> user    0m0.002s
> sys     0m1.909s
>
> I guess that by decreasing below erase sizes, I could further increase
> the execution time, but these sysfs properties are read-only:
>
> cat /sys/devices/platform/soc/ee100000.sd/mmc_host/mmc1/mmc1:59b4/preferred_erase_size
> 4194304
> cat /sys/devices/platform/soc/ee100000.sd/mmc_host/mmc1/mmc1:59b4/erase_size
> 512
>

This test and due to the discussions with Wolfram and you in this
thread, I would actually suggest that you enable MMC_CAP_ERASE for all
tmio variants, rather than just for this particular one.

In other words, set the cap in tmio_mmc_host_probe() should be fine,
as it seems none of the tmio variants supports HW busy detection at
this point.

Kind regards
Uffe
