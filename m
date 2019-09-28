Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE165C1235
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 23:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfI1VO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Sep 2019 17:14:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41363 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfI1VO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 17:14:58 -0400
Received: by mail-qt1-f196.google.com with SMTP id n1so11873086qtp.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 14:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0P2GLR5OwtTpxgCDK5Jv/YpV62Rd2/0hL9aWprfsTbE=;
        b=JxNru4/HpIbgU77KyIsMwYKhI7Rk9WTyEQhMLNvoXaR2Ds0RbXEZfFS97IBxe8vKMt
         DUc6YsDCsNJP/Pey/wgKIPhv5cjfASGQvj12LbpMte/5lT6gBuXgTsgnyx3m3Bm+3bBk
         tEcs4617kXKCFA3mGK3JQ77PvIJ5TlUbqgcPk5uRsaQICwsKfQ4aBFiq1j0Jt9+/ir1N
         Lndu2HPiH/iG4aSgLAbr/nkLJZXeeE4xHKOB6vtMvoK14UovliIWvg/W8xAU0/mz6s5g
         FlamfLZoPoUGwruznUiWRbCnk+IMWrOCRW5RGuEOhU4iVlftMa4ALaZVylVkpHTqWHOk
         n7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=0P2GLR5OwtTpxgCDK5Jv/YpV62Rd2/0hL9aWprfsTbE=;
        b=W6bU5b0KHWgSM4g4gaa+2f8Zm+ZYkTu5iB9I+wDoTD1sB1QCWVJlcL7A0Qk3fWV49E
         hLgG8B+lmQ8dbIFdak0borqpobRKaOUA45BpkdIwjp/lPhXt08WAD4YbCUthCPV7LaDb
         KwcKL/b/KU5ThgztoAGvwzlilyOo/jI0tN43f4EB5aMGHFd05nzUu+PwLzQD2Bka+hDJ
         9XAi/xteh7XXYgd7O6xNMhYzZYYzhC4v45nIrzdVAye5Zb/TxMW2cxxoD4PGrAHyeb/b
         OArgGcYcAyHIYF+vhfGp7cWjHCR3o7OcpJm8juvfnnNhX9hO3CN9/7LtIgchSRT1cr1l
         xkBA==
X-Gm-Message-State: APjAAAV0J9OdjOfl9QwceG0AxU7c5okl7z8RqgXhvSSP2s2pn0IXs02x
        GE9FWUk1aYRUqbmpN49ATfg=
X-Google-Smtp-Source: APXvYqyB+J5TCd9aIbGc1PC4owAT4ijHmxKcTbdCBtKg7SUEJXH4UoLA0rI2lS0Pa238KVSbKO7DWQ==
X-Received: by 2002:aed:3f3a:: with SMTP id p55mr18283755qtf.148.1569705297722;
        Sat, 28 Sep 2019 14:14:57 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id e4sm2954890qkl.135.2019.09.28.14.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Sep 2019 14:14:57 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 28 Sep 2019 17:14:55 -0400
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Andreas Smas <andreas@lonelycoder.com>
Subject: Re: x86/purgatory: undefined symbol __stack_chk_fail
Message-ID: <20190928211453.GA2300554@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 12:41:29PM +0000, Ingo Molnar wrote:
> 
> * Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > On 9/3/19 8:50 AM, Andreas Smas wrote:
> > > Hi,
> > > 
> > > For me, kernels built including this commit
> > > b059f801a937 (x86/purgatory: Use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS)
> > > 
> > > results in kexec() failing to load the kernel:
> > > 
> > > kexec: Undefined symbol: __stack_chk_fail
> > > kexec-bzImage64: Loading purgatory failed
> > > 
> > > Can be seen:
> > > 
> > > $ readelf -a arch/x86/purgatory/purgatory.ro | grep UND
> > >      0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
> > >     51: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __stack_chk_fail
> > > 
> > > Using: gcc version 7.4.0 (Ubuntu 7.4.0-1ubuntu1~18.04.1)
> > > 
> > > Adding -ffreestanding or -fno-stack-protector to ccflags-y in
> > > arch/x86/purgatory/Makefile
> > > fixes the problem. Not sure which would be preferred.
> > > 
> > 
> > Hi,
> > Do you have a kernel .config file that causes this?
> > I can't seem to reproduce it.
> 
> Does it go away with this fix in x86/urgent:
> 
>   ca14c996afe7: ("x86/purgatory: Disable the stackleak GCC plugin for the purgatory")
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
> 
> ?
> 
> Thanks,
> 
> 	Ing
This one was fixed by [1] e16c2983fba0f ("x86/purgatory: Change compiler
flags from -mcmodel=kernel to -mcmodel=large to fix kexec relocation
errors") from Steve Wahl, which in addition to changing mcmodel also
added back -ffreestanding (and -fno-zero-initialized-in-bss). It was
merged on the 12th. The stackleak one is a different undefined symbol
error.

[1] https://marc.info/?l=git-commits-head&m=156829711224800
