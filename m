Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 390BB2AB59
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2019 19:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfEZR0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 May 2019 13:26:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53611 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbfEZR0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 13:26:10 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 021E4803F7; Sun, 26 May 2019 19:25:57 +0200 (CEST)
Date:   Sun, 26 May 2019 19:25:09 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] mm/gup: continue VM_FAULT_RETRY processing event for
 pre-faults
Message-ID: <20190526172509.GC1282@xo-6d-61-c0.localdomain>
References: <1557844195-18882-1-git-send-email-rppt@linux.ibm.com>
 <20190522122113.a2edc8aba32f0fad189bae21@linux-foundation.org>
 <20190522194322.5k52docwgp5zkdcj@linutronix.de>
 <alpine.LSU.2.11.1905241429460.1141@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1905241429460.1141@eggly.anvils>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-05-24 15:22:51, Hugh Dickins wrote:
> On Wed, 22 May 2019, Sebastian Andrzej Siewior wrote:
> > On 2019-05-22 12:21:13 [-0700], Andrew Morton wrote:
> > > On Tue, 14 May 2019 17:29:55 +0300 Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > 
> > > > When get_user_pages*() is called with pages = NULL, the processing of
> > > > VM_FAULT_RETRY terminates early without actually retrying to fault-in all
> > > > the pages.
> > > > 
> > > > If the pages in the requested range belong to a VMA that has userfaultfd
> > > > registered, handle_userfault() returns VM_FAULT_RETRY *after* user space
> > > > has populated the page, but for the gup pre-fault case there's no actual
> > > > retry and the caller will get no pages although they are present.
> > > > 
> > > > This issue was uncovered when running post-copy memory restore in CRIU
> > > > after commit d9c9ce34ed5c ("x86/fpu: Fault-in user stack if
> > > > copy_fpstate_to_sigframe() fails").
> 
> I've been getting unexplained segmentation violations, and "make" giving
> up early, when running kernel builds under swapping memory pressure: no
> CRIU involved.
> 
> Bisected last night to that same x86/fpu commit, not itself guilty, but
> suffering from the odd behavior of get_user_pages_unlocked() giving up
> too early.
> 
> (I wondered at first if copy_fpstate_to_sigframe() ought to retry if
> non-negative ret < nr_pages, but no, that would be wrong: a present page
> followed by an invalid area would repeatedly return 1 for nr_pages 2.)
> 
> Cc'ing Pavel, who's been having segfault trouble in emacs: maybe same?

The emacs segfault was always during process exit. This sounds different...

I don't see problems with make.

But its true that at least one of affected machines uses swap heavily.

Best regards,
								Pavel
