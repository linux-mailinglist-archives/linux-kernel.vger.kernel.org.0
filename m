Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F656EF27
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 12:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfGTK7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jul 2019 06:59:54 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39101 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfGTK7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 06:59:54 -0400
Received: by mail-qk1-f196.google.com with SMTP id w190so25182836qkc.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 03:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qV6C2HshTNaf1Z3rmhIYKeohKZT77ml6JYQNs+hOtF0=;
        b=ga/hV/z9VGir/SFny7Bm11ORYELLp6KLBzSMPiAm45y6KR+NmkCLu4JwONweu4OUl0
         lz0KFNtU0p4Mjjtd1cnaCrP8F00cCzCIhPmRIu+aMeGb7Q7j2tZMSdaLcTaKS+yNS5QA
         U5dLURGmNkPxQil04U8X7C9udytYu6IK/DVVrfGu/KyLJt7LDHdzO16hUHJoAP7NPz4R
         BpN3RngmsKSniSoWX6LnbVtBIPP4EFJP1m6A4mmRLM1WQBEUv13JxqXl/NYJV9VN0qb8
         bPk1f/1bLsylaQlxqWmmgRfGSpOF8UW5wWR84fgOqtoj2AHuzRpbw7c9Vzg/dv0Yzj13
         uwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qV6C2HshTNaf1Z3rmhIYKeohKZT77ml6JYQNs+hOtF0=;
        b=Gf0ixrxzE6t4zPVu3DNF4VscUohOYU4z6fBQ1/54khLbFeQtgZzWP/T0XGN8LraW4M
         I52UrPKkF/dE4TuIXKpW1NnWKRPpEGukPNmOkO92FT9M507hTQh6YvzmKGPhHiMgGq09
         Zr2JpxwPUVEC5IZan5SRJk54agFG4wplMiTCkn+6/4kNtVrDfx7YwrNBCshGXIwMqB86
         D2mAZBGZtGPlC1PefKx7zQea8FejmfQ8/hTClU93s2L3PEQXpt8+IicbertrCv7yD2LQ
         DnIXlecRSwTVmWyReXktsAgZ3RzuPSvcGQ9tmjsuFgZga6OYhIYh9Bo4gAaGdsDxoIeV
         xxtQ==
X-Gm-Message-State: APjAAAULEYaFrV8ZtSXKHqF3Au8rYD5ipTYo1O3tqFqSkl7Rt4kt8phk
        KPpoJNs8CqEMIuPPGM7ST7GGwnCDkfjxIJMxZFM=
X-Google-Smtp-Source: APXvYqyHn+GehhygqUV66ttkVm505Ca0Q+yOuFpiioGMsn25Vi+bYgOJKern2ncZ+vSvfoJMIfbr8uQ+rl36gMRhfT0=
X-Received: by 2002:a37:2d43:: with SMTP id t64mr36843093qkh.472.1563620393025;
 Sat, 20 Jul 2019 03:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907161434260.1767@nanos.tec.linutronix.de>
 <20190716170606.GA38406@archlinux-threadripper> <alpine.DEB.2.21.1907162059200.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907162135590.1767@nanos.tec.linutronix.de>
 <CAK7LNASBiaMX8ihnmhLGmYfHX=ZHZmVN91nxmFZe-OCaw6Px2w@mail.gmail.com>
 <alpine.DEB.2.21.1907170955250.1767@nanos.tec.linutronix.de>
 <CAHbf0-GyQzWcRg_BP2B5pVzEJoxSE_hX5xFypS--7Q5LSHxzWw@mail.gmail.com>
 <alpine.DEB.2.21.1907201133000.1782@nanos.tec.linutronix.de>
 <CAHbf0-FfD_tzRFfkYK=gWDOkB=+ecFuJPbZwPS3S3HJmDThPWw@mail.gmail.com> <alpine.DEB.2.21.1907201253360.1782@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907201253360.1782@nanos.tec.linutronix.de>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Sat, 20 Jul 2019 11:59:41 +0100
Message-ID: <CAHbf0-GZySHLPMsR7NcyqpxD0DwK1Y44=A0sgA=pFzRMe2fXtw@mail.gmail.com>
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

On Sat, 20 Jul 2019 at 11:54, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, 20 Jul 2019, Mike Lothian wrote:
> > Here is my config
> >
> > https://github.com/FireBurn/KernelStuff/blob/9b7e96581598d50b266f9df258e7de764949147a/dot_config_tip
> >
>
> Builds perfectly fine.

Sorry top posted from my phone

Are you using gold? And which versions of GCC & binutils are you using?
