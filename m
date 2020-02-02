Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E20CA14FDCD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Feb 2020 16:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgBBPcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Feb 2020 10:32:48 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:38633 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgBBPcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 10:32:48 -0500
Received: by mail-vk1-f194.google.com with SMTP id w4so1821622vkd.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 07:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mi90bhimP2jFo8+p9OQpeUpQJ64yDvLVQgP6F2u9uVY=;
        b=sg0V/ZEY7dip3DPh2qScwwXLgsOdsHMbJpEt/HidDkUo2ozTR1tL/uF7fLiOwFm1C8
         HGalfdK6UF5WK+mlmAvuuk4zJRL4z34U89LZ2qoA+X+tCgM8dLGKtQh2HfOite9TOIpF
         RkAlpkXeZ4A+9KjhaYRk2IpuXwcOV1YM/oc/wDL+OKvHqzdH4sVnkqfK5khHHHwlXlVD
         Hnk0BjepTdKx5ylG3EknP1a+v8P4ppI1iJSYMmtujHO1XIUpJjMMlCLah+bMqn5e/oSN
         Phg0MqA0qhlAnmY2zG5nNd6QW/u1RfgqiLhI6VCW/UL9lhaNOPidCLHwu3gec3bAuwuR
         qYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mi90bhimP2jFo8+p9OQpeUpQJ64yDvLVQgP6F2u9uVY=;
        b=awDZ3WibqWrT7uNdzxH4B6xsodWp4DXp3My52sV9VDLRRZVtpsd447SLBzH+BT6dry
         +CcPUel1pHUiIFV8aNaFQmi2zHLQd9TpHiYJfsRcqWAL6ZzuTaYrN7gbfohgC/Mu4gAh
         MmtDm4JoFV+CEhlhaHvHNdONoE/+8VPJJTrN8O8z71o0nnO9SRCUIABfjGqvGM0xy0l4
         Lq8b/ka8iZjgZsPXNjbN3cqqIRy8hcpHJZZZQbXA/MIyhrx9Vsr8tkbebEigpJ+vjoJz
         mIadFsYn209jYs2SgXxaWoxMJ0gUfkaz8++rQ9YEOwh7GYuMklC8sTATMEcBSo8InYpW
         PopQ==
X-Gm-Message-State: APjAAAXKjKBFyAlh0pMabOiML/TwTXKnKHaSmABCtBMHtYXB49DUUv9x
        OSXcvo8WytcBOowyPwzDwMi6QBk6d1XpdFwrBK31489C/PA=
X-Google-Smtp-Source: APXvYqzBdegfrRAQZPJTNqqHFNCy/GnEoZFaWZ8XhQ3QHf76DwqaIc9nOnqobCWdRP3+qDU3VnSL8eetfU207zqK4jk=
X-Received: by 2002:a1f:8d0f:: with SMTP id p15mr11945370vkd.100.1580657565589;
 Sun, 02 Feb 2020 07:32:45 -0800 (PST)
MIME-Version: 1.0
References: <20200129143757.680-1-gilad@benyossef.com> <20200129143757.680-5-gilad@benyossef.com>
 <CAMuHMdVb_AGa7980fRXaxon=uDojZ1x5d6z-FCJAt5aMEGMcbw@mail.gmail.com>
 <CAOtvUMdUBMkmZ6nzGVxi1W_Y4yFvcd6rfvz6BA63h4eq2QFUdA@mail.gmail.com> <CAMuHMdXecd0KAN6B4GWKMp-DsmZVTJqOJfm5CymwwPMwDqG0qA@mail.gmail.com>
In-Reply-To: <CAMuHMdXecd0KAN6B4GWKMp-DsmZVTJqOJfm5CymwwPMwDqG0qA@mail.gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Sun, 2 Feb 2020 17:32:33 +0200
Message-ID: <CAOtvUMcejz8qLrg8MBxM2DkYSqvfX-yKwK7NujmwD=szystUAQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] crypto: ccree - fix AEAD blocksize registration
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 3:19 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Gilad,
>
> On Thu, Jan 30, 2020 at 12:33 PM Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> > On Wed, Jan 29, 2020 at 5:17 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Wed, Jan 29, 2020 at 3:39 PM Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> > > > Fix an error causing no block sizes to be reported during
> > > > all AEAD registrations.
> > > >
> > > > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> > >
> > > Thanks, this fixes:
> > >
> > >     alg: aead: blocksize for authenc-hmac-sha1-cbc-aes-ccree (0)
> > > doesn't match generic impl (16)
> > >     alg: aead: blocksize for authenc-hmac-sha256-cbc-aes-ccree (0)
> > > doesn't match generic impl (16)
> > >
> > > which you may want to mention in the commit description, so
> > > people who search for the error message will find the fix.
> > >
> > > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > Note that even after applying this series, the kernel still crashes with
> > >
> > > kernel BUG at kernel/dma/swiotlb.c:497!
> > > ....

Thank you!

I've managed to reproduce this here.
Looking into it now...

Gilad
