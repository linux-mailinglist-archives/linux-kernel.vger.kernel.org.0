Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80D986EEF8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 12:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfGTKNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jul 2019 06:13:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43182 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfGTKNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 06:13:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id w17so33635457qto.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 03:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CX30tYfAAn3HA4g60/4RynDzjTsyZz+o/dEyAjFSqJw=;
        b=nUyJA0xuihyysPCQIEbUyHtxZZQltP/2ULe6Bm6NjmcPwRbuMeKbvzH7tp9ZiKlMkg
         Kv6W2AvNaykvC5gVZeijmvFZXLbOHqUdGWJiVwW5eamwZS1djIbzAphlpXxmJSmDDITX
         SwjBAFSjMDdlos6Y8LCwS0qls7j2iXldmPNVhfkYboHcFeH9cFwyIDvzKvajWMyTUF40
         PqaWuNvKv3yJDLCfZvltdrYgHfg/NyGzc1Ho/rlOPQuuBprgcNzUTSVCj10FqKrKHJ/z
         dhMRoHgD4E7dAjVD7IofcMDcNMqoLbNHtN8YjIs11FRgHNdCMHfyQVE0VemFNnGEdn49
         ifrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CX30tYfAAn3HA4g60/4RynDzjTsyZz+o/dEyAjFSqJw=;
        b=tK79JgaD8LkA4k5uToCjOpHoWd3AHMcugwRzG7kRuHO3l/36DmSMiX9rY7/9pCU+qU
         /eHk7Hz3wTkGBTRYNPlq3Y4tQ4j6ZL6hUPodoYiR9acjU1UQDZ86DpFb54RN2UN0zrd7
         NBlDFiEs2EXFY2CS6y8hInqO4sktXQgf7oI+VUpSMTyNMCOct4G7exh2EwbutC/v4eP4
         p9QEmufClv2MxOVx1tnrjKxSY5WenrdiU/HwLFGg2xZ7ZSWyijUCZquFKWBqMNsqq0Gu
         PNaimxYV0W6rPw1mN2GFNTZDMY1m0XDenZ+UXsnalYKjMOdPkEHHhOTZyNPOXHAx5rhW
         VxaA==
X-Gm-Message-State: APjAAAXnxI8BONu0DptDRy2sJzHBEH7FK70SPo2a8XzN75sGv+0eHDly
        RJUBsItVDJ/iAiD8404G/NJ39YkCkOXZps1xS90=
X-Google-Smtp-Source: APXvYqyn7FVeVoQZDWtnNymGIpPRpvEcKpKS7HJVaY0J1bFzOj+MglYjbR+zL7WRoTSMPerJT5MR0Yq2Ps1UJo2YPlA=
X-Received: by 2002:a0c:9214:: with SMTP id a20mr42193968qva.195.1563617618674;
 Sat, 20 Jul 2019 03:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907161434260.1767@nanos.tec.linutronix.de>
 <20190716170606.GA38406@archlinux-threadripper> <alpine.DEB.2.21.1907162059200.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907162135590.1767@nanos.tec.linutronix.de>
 <CAK7LNASBiaMX8ihnmhLGmYfHX=ZHZmVN91nxmFZe-OCaw6Px2w@mail.gmail.com>
 <alpine.DEB.2.21.1907170955250.1767@nanos.tec.linutronix.de>
 <CAHbf0-GyQzWcRg_BP2B5pVzEJoxSE_hX5xFypS--7Q5LSHxzWw@mail.gmail.com> <alpine.DEB.2.21.1907201133000.1782@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907201133000.1782@nanos.tec.linutronix.de>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Sat, 20 Jul 2019 11:13:27 +0100
Message-ID: <CAHbf0-FfD_tzRFfkYK=gWDOkB=+ecFuJPbZwPS3S3HJmDThPWw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Fail if gold linker is detected
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, "H.J. Lu" <hjl.tools@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jul 2019 at 10:34, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, 20 Jul 2019, Mike Lothian wrote:
> > On Wed, 17 Jul 2019 at 08:57, Thomas Gleixner <tglx@linutronix.de> wrote:
> > I've done a bit more digging, I had a second machine that was building
> > Linus's tree just fine with ld.gold
> >
> > I tried forcing ld.bfd on the problem machine and got this:
> >
> > ld.bfd: arch/x86/boot/compressed/head_64.o: warning: relocation in
> > read-only section `.head.text'
> > ld.bfd: warning: creating a DT_TEXTREL in object
> >
> > I had a look at the differences in the kernel configs and noticed this:
> >
> > CONFIG_RANDOMIZE_BASE=y
> > CONFIG_X86_NEED_RELOCS=y
> > CONFIG_PHYSICAL_ALIGN=0x1000000
> > CONFIG_DYNAMIC_MEMORY_LAYOUT=y
> > CONFIG_RANDOMIZE_MEMORY=y
> > CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0x0
> >
> > Unsetting CONFIG_RANDOMIZE_BASE=y gets things working for me with ld.gold again
>
> Can you please provide the full config? I have the above set here and it
> builds just fine.
>
> > In light of this - can we drop this patch?
>
> No. I'm not going to deal with unsupported tools.
>
> Thanks,
>
>         tglx

Hi

Here is my config

https://github.com/FireBurn/KernelStuff/blob/9b7e96581598d50b266f9df258e7de764949147a/dot_config_tip

Regards

Mike
