Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D914F453E9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 07:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbfFNFT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 01:19:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46763 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfFNFT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 01:19:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id 81so664704pfy.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 22:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nskhfJQuIY7GF0zjhR2dKbT25UZTtER3vtr2UfHLkl0=;
        b=YDO9pFM8Osq93VSo2f3tLfUq86JpUfsiv1X1siRWgaiWymHC7MRXwP56QUxsFHRv3H
         SKCzR0zRWWIU5aRmc/2nEN3bRodhtEo4Zx4gbF9YAeLAQ7MkrR9ImCkLSMhntm06ER6o
         kwKZQJszlo4xYiui9CzoeVonWOJLucEs1S7dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nskhfJQuIY7GF0zjhR2dKbT25UZTtER3vtr2UfHLkl0=;
        b=aWF84iEzgOayENmCuZCR4CBpWBLJzOq6eU3YPGnIgj6P7nuWONrPes9MAYXNnr3BV2
         ltj8F7782F3tJ2ZLKbjXarhNWiiRotAvnEm4tUYS70bsn/A9xpLMaIdwA8gg4iAqG1AB
         dbs0qhsQHcHTuMbnw99OLqmNZwj7hr7mXYB+fCRLJcId9NoBjbY8AHxGrbkRFAfK/+oS
         Sl/VfJSlf8cZXPDqEeJvDRE4tQxRbTIadL1Ta2bUqeeGfeEw8PJqrFSExzbbdtYfcWYF
         XBsEYBYfi38CEQ6pLytb1S0uvWi8z6lpnI4Gxhexeu5VvYzvT2pv/2i7988jJJ8ONzCA
         6NhQ==
X-Gm-Message-State: APjAAAWvwBM8JDX2wGJ7NBfxAWDwvG5CZCUcdjBh4Yt+CaKFZYg1Wc0n
        vHvjXcJ+iNEPxUBrfDR8421qtg==
X-Google-Smtp-Source: APXvYqxrnfq+JKGiO2MZ5LrxEthLtuHyFKWQHWwvD7llZNQrcCIKzBfSJFqibnh9dhqVgmZUEBd3tQ==
X-Received: by 2002:a63:4c:: with SMTP id 73mr32496569pga.134.1560489565544;
        Thu, 13 Jun 2019 22:19:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d7sm1472339pfn.89.2019.06.13.22.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 22:19:24 -0700 (PDT)
Date:   Thu, 13 Jun 2019 22:19:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/5] x86/vsyscall: Change the default vsyscall mode to
 xonly
Message-ID: <201906132218.E923F38F@keescook>
References: <cover.1560198181.git.luto@kernel.org>
 <25fd7036cefca16c68ecd990e05e05a8ad8fe8b2.1560198181.git.luto@kernel.org>
 <201906101344.018BE4C5C1@keescook>
 <CALCETrUYNavL8pu4jQqJjoT=PdeRyjeoLDn=0r7h=2XsHDMezQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUYNavL8pu4jQqJjoT=PdeRyjeoLDn=0r7h=2XsHDMezQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 12:14:50PM -0700, Andy Lutomirski wrote:
> On Mon, Jun 10, 2019 at 1:44 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Jun 10, 2019 at 01:25:31PM -0700, Andy Lutomirski wrote:
> > > The use case for full emulation over xonly is very esoteric.  Let's
> > > change the default to the safer xonly mode.
> >
> > Perhaps describe the esoteric cases here (and maybe in the Kconfig help
> > text)? That should a user determine if they actually need it. (What
> > would the failure under xonly look like for someone needing emulate?)
> 
> I added it to the Kconfig text.
> 
> Right now, the failure will just be a segfault.  I could add some
> logic so that it would log "invalid read to vsyscall page -- fix your
> userspace or boot with vsyscall=emulate".  Do you think that's
> important?

I think it would be a friendly way to help anyone wondering why
something suddenly started segfaulting, yeah. Just a pr_warn_once() or
something (not a WARN() since it's "intentionally" reachable by
userspace).

-- 
Kees Cook
