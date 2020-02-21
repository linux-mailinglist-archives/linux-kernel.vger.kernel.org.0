Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3A55168190
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 16:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgBUP2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 10:28:46 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:43828 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgBUP2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:28:45 -0500
Received: by isilmar-4.linta.de (Postfix, from userid 1000)
        id 19552200B44; Fri, 21 Feb 2020 15:28:44 +0000 (UTC)
Date:   Fri, 21 Feb 2020 16:28:44 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 0/5] Enable pt_regs based syscalls for x86-32 native
Message-ID: <20200221152843.rxz4ptfi5lh3udud@isilmar-4.linta.de>
References: <20200221050934.719152-1-brgerst@gmail.com>
 <20200221060756.GA3368@light.dominikbrodowski.net>
 <CAMzpN2iQuaNdTdL6G1rGbUFo+r16iRFo1zbiD_VMrrjtGf0acw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2iQuaNdTdL6G1rGbUFo+r16iRFo1zbiD_VMrrjtGf0acw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 08:15:19AM -0500, Brian Gerst wrote:
> On Fri, Feb 21, 2020 at 2:07 AM Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> >
> > Brian,
> >
> > On Fri, Feb 21, 2020 at 12:09:29AM -0500, Brian Gerst wrote:
> > > This patch series cleans up the x86 syscall wrapper code and converts
> > > the 32-bit native kernel over to pt_regs based syscalls.
> >
> > thanks for your patchset. Could you explain a bit more what the rationale
> > is. Due to asmlinkage, it doesn't leak "random user-provided register
> > content down the call chain" (as was the case for x86-64). But it may be
> > cleaner, and you mention in patch 5/5 that the new way is "a bit more
> > efficient" -- do you have numbers?
> 
> The main rationale for this patch set is to make the 32-bit native
> kernel consistent with the 64-bit kernel.  It's also slightly more
> efficient because the old code pushed all 6 arguments onto the stack
> whereas the new code only reads the args the syscall needs, with the
> pt_regs pointer passed in through a register.  By efficient I mean
> that it uses fewer instructions and stack accesses, not that it will
> actually have a significant difference on a benchmark.

OK, could you add such an explanation to the patchset then, please? Thanks,
Dominik
