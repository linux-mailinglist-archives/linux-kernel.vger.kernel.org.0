Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F22AEC146C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2019 14:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfI2MMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Sep 2019 08:12:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34481 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfI2MMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 08:12:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so11974240wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 05:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ReoLOVCaGYO0zDdTc9sz9eU6CfNxDn465zi1yUtPFtk=;
        b=aUiVgCx4oWw3htW66kLVD7MHD4hILGnAr/lvyQmC5uH9ze5HloeMBBdAJ2JUMQU6/L
         S1ocHl3BHGTX3l8BWOltI2n+a0LszrpX9z9sUWvv7/YmDtWyA9py7KLvVA94EopJtJJ9
         5YLjdtWIVyI/CVy2jtxnpj/85y4jh3kxgeQ7gmuh265S/NDfLywTIdZqmGyAw9f3/07i
         UnGai12bURYMdOMLb3/WDKOteIM3Vj8Qx8uVr2ZoI6yqOplSe8hOFzDrwf5SeDx49BJ8
         sMT1qrlJ1viuWHBg25fV1GaPIOVfXk2CBnDA3pEP4hQtomVIaC8SEavB2S84zoa9L+O/
         Numw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ReoLOVCaGYO0zDdTc9sz9eU6CfNxDn465zi1yUtPFtk=;
        b=gb9W66XK9FYenXoXplAvU/i5u7gRyCmFLhHCugS/zLOGnlha9hCn55+WD3TiJBQaPn
         nxvhfwmSCOFBb37ne0ny0dcV9PgRyYMEB8RECF85H+tyt22BhaAsd9WIhiDtMpikZrqa
         Z5k0SgFHGrLPPO3DDa6gpBU/4ZJYfV/gYCRwzY4nlVtmvTSi4oXeayIoG9+jpe0evTKg
         Yu1MBvi2PBcknwD5BqQPuKHa86X8vHi015jPsKm1jldPmjG8Ok4KFzQSGxOn0jxp6IWE
         Of+LRB73CukXY5rhnl6PJ4Fm/KGfR813bNGEbmCmEZ+lxvBJfHghlay2IQXg9jx4wDFo
         fAdQ==
X-Gm-Message-State: APjAAAVuae6MO6OQJdBxlqg+srAUfLJc4GON2mvksJdQ4gZuL/TDQ37o
        cCmhExl280o2rDzYKiXiyno=
X-Google-Smtp-Source: APXvYqx3z7iWMDtWhP/RQC3kTM5q0PRANM3wq2XjU4gB9Ch94CnJ64BbUk9JP7C3a06GY387irwZVA==
X-Received: by 2002:a1c:c74e:: with SMTP id x75mr14315738wmf.177.1569759139458;
        Sun, 29 Sep 2019 05:12:19 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j26sm17821307wrd.2.2019.09.29.05.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 05:12:18 -0700 (PDT)
Date:   Sun, 29 Sep 2019 14:12:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Andreas Smas <andreas@lonelycoder.com>
Subject: Re: x86/purgatory: undefined symbol __stack_chk_fail
Message-ID: <20190929121216.GA35735@gmail.com>
References: <20190928211453.GA2300554@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190928211453.GA2300554@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arvind Sankar <nivedita@alum.mit.edu> wrote:

> On Sat, Sep 28, 2019 at 12:41:29PM +0000, Ingo Molnar wrote:
> > 
> > * Randy Dunlap <rdunlap@infradead.org> wrote:
> > 
> > > On 9/3/19 8:50 AM, Andreas Smas wrote:
> > > > Hi,
> > > > 
> > > > For me, kernels built including this commit
> > > > b059f801a937 (x86/purgatory: Use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS)
> > > > 
> > > > results in kexec() failing to load the kernel:
> > > > 
> > > > kexec: Undefined symbol: __stack_chk_fail
> > > > kexec-bzImage64: Loading purgatory failed
> > > > 
> > > > Can be seen:
> > > > 
> > > > $ readelf -a arch/x86/purgatory/purgatory.ro | grep UND
> > > >      0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
> > > >     51: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __stack_chk_fail
> > > > 
> > > > Using: gcc version 7.4.0 (Ubuntu 7.4.0-1ubuntu1~18.04.1)
> > > > 
> > > > Adding -ffreestanding or -fno-stack-protector to ccflags-y in
> > > > arch/x86/purgatory/Makefile
> > > > fixes the problem. Not sure which would be preferred.
> > > > 
> > > 
> > > Hi,
> > > Do you have a kernel .config file that causes this?
> > > I can't seem to reproduce it.
> > 
> > Does it go away with this fix in x86/urgent:
> > 
> >   ca14c996afe7: ("x86/purgatory: Disable the stackleak GCC plugin for the purgatory")
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
> > 
> > ?
> > 
> > Thanks,
> > 
> > 	Ing
> This one was fixed by [1] e16c2983fba0f ("x86/purgatory: Change compiler
> flags from -mcmodel=kernel to -mcmodel=large to fix kexec relocation
> errors") from Steve Wahl, which in addition to changing mcmodel also
> added back -ffreestanding (and -fno-zero-initialized-in-bss). It was
> merged on the 12th. The stackleak one is a different undefined symbol
> error.
> 
> [1] https://marc.info/?l=git-commits-head&m=156829711224800

Great, so all known kexec bugs should be fixed for now in Linus's latest 
kernel, right?

Thanks,

	Ingo
