Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 894AA14015
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2019 16:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfEEOLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 May 2019 10:11:06 -0400
Received: from relay13.nicmail.ru ([195.208.6.7]:17864 "EHLO
        relay13.nicmail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfEEOLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 10:11:05 -0400
Received: from [109.70.25.215] (port=50276 helo=sghpc.hn.golosunov.pp.ru)
        by f17.mail.nic.ru with esmtp (Exim 5.55)
        (envelope-from <stepan@golosunov.pp.ru>)
        id 1hNHr1-000Cyp-4E; Sun, 05 May 2019 17:10:59 +0300
Received: from [46.0.182.93] (account sghpc@golosunov.pp.ru HELO sghpc.hn.golosunov.pp.ru)
        by proxy02.mail.nic.ru (Exim 5.55)
        with id 1hNHr1-0003hd-7i; Sun, 05 May 2019 17:10:59 +0300
Received: from stepan by sghpc.hn.golosunov.pp.ru with local (Exim 4.89)
        (envelope-from <stepan@golosunov.pp.ru>)
        id 1hNHqw-0007fF-2F; Sun, 05 May 2019 18:10:54 +0400
Date:   Sun, 5 May 2019 18:10:54 +0400
From:   Stepan Golosunov <stepan@golosunov.pp.ru>
To:     Joseph Myers <joseph@codesourcery.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>, libc-alpha@sourceware.org,
        Arnd Bergmann <arnd@arndb.de>, Paul Eggert <eggert@cs.ucla.edu>
Subject: Re: [PATCH v2 2/7] y2038: Introduce __ASSUME_64BIT_TIME define
Message-ID: <20190505141053.gzff6q4j33x5vpiy@sghpc.golosunov.pp.ru>
References: <20190414220841.20243-1-lukma@denx.de>
 <20190429104613.16209-1-lukma@denx.de>
 <20190429104613.16209-3-lukma@denx.de>
 <alpine.DEB.2.21.1904292138430.21580@digraph.polyomino.org.uk>
 <20190430110505.2a0c7d1a@jawa>
 <alpine.DEB.2.21.1905021431060.4027@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1905021431060.4027@digraph.polyomino.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

02.05.2019 в 15:04:18 +0000 Joseph Myers написал:
> On Tue, 30 Apr 2019, Lukasz Majewski wrote:
> 
> >  - The need for explicit clearing padding when calling syscalls (as to
> >    be better safe than sorry in the future - there was related
> >    discussion started by Stepan).
> 
> This really isn't a difficult question.  What it comes down to is whether 
> the Linux kernel, in the first release version with these syscalls (we 
> don't care about old -rc versions; what matters is the actual 5.1 
> release), ignores the padding.
> 
> If 5.1 *release* ignores the padding, that is part of the kernel/userspace 
> ABI, in accordance with the kernel principle of not breaking userspace.  
> Thus, it is something userspace can rely on, now and in the future.
> 
> If 5.1 release does not ignore the padding, syscall presence does not mean 
> the padding is ignored by the kernel and so glibc needs to clear padding.  
> Of course, it needs to clear padding in a *copy* of the value provided by 
> the user unless the glibc API in question requires the timespec value in 
> question to be in writable memory.
> 
> So, which is (or will be) the case in 5.1 release?  Padding ignored or 
> not?  If more complicated (ignored for some architectures / ABIs but not 
> for others, or depending on whether compat syscalls are in use), then say 
> so - give a precise description of the exact circumstances under which the 
> padding around a 32-bit tv_nsec will or will not be ignored by the kernel 
> on input from userspace.

In current linux git it looks like padding is correctly ignored in
32-bit kernels (because kernel itself has 32-bit tv_nsec there) but
the code to clear it on compat syscalls in 64-bit kernels seems to be
broken.

The patch to fix this is at

https://lore.kernel.org/lkml/20190429131951.471701-1-arnd@arndb.de/

but it doesn't seem like it has reached Linus yet.


(Hmm.  I think that old ipc and socketcall syscalls in 32-bit kernels
are broken without that patch too.  They would try to read
__kernel_timespec when callers are passing old_timespec32.)
