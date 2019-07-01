Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 289712E238
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 18:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfE2QZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 12:25:34 -0400
Received: from foss.arm.com ([217.140.101.70]:49016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfE2QZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 12:25:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6340715AD;
        Wed, 29 May 2019 09:25:33 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D9723F5AF;
        Wed, 29 May 2019 09:25:30 -0700 (PDT)
Date:   Wed, 29 May 2019 17:25:28 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Young Xiao <92siuyang@gmail.com>, linux@armlinux.org.uk,
        mark.rutland@arm.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, kan.liang@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.vnet.ibm.com, mpe@ellerman.id.au,
        acme@redhat.com, eranian@google.com, fweisbec@gmail.com,
        jolsa@redhat.com
Subject: Re: [PATCH] perf: Fix oops when kthread execs user process
Message-ID: <20190529162528.GB12420@fuggles.cambridge.arm.com>
References: <20190528153224.GE20758@fuggles.cambridge.arm.com>
 <20190528173228.GW2623@hirez.programming.kicks-ass.net>
 <20190529091733.GA4485@fuggles.cambridge.arm.com>
 <20190529101042.GN2623@hirez.programming.kicks-ass.net>
 <20190529102022.GC4485@fuggles.cambridge.arm.com>
 <20190529125557.GU2623@hirez.programming.kicks-ass.net>
 <20190529130521.GA11023@fuggles.cambridge.arm.com>
 <20190529132515.GW2623@hirez.programming.kicks-ass.net>
 <20190529143510.GA11154@fuggles.cambridge.arm.com>
 <20190529161955.GZ2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529161955.GZ2623@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 06:19:55PM +0200, Peter Zijlstra wrote:
> On Wed, May 29, 2019 at 03:35:10PM +0100, Will Deacon wrote:
> > On Wed, May 29, 2019 at 03:25:15PM +0200, Peter Zijlstra wrote:
> > > On Wed, May 29, 2019 at 02:05:21PM +0100, Will Deacon wrote:
> > > > On Wed, May 29, 2019 at 02:55:57PM +0200, Peter Zijlstra wrote:
> > > 
> > > > >  	if (user_mode(regs)) {
> > > > 
> > > > Hmm, so it just occurred to me that Mark's observation is that the regs
> > > > can be junk in some cases. In which case, should we be checking for
> > > > kthreads first?
> > > 
> > > task_pt_regs() can return garbage, but @regs is the exception (or
> > > perf_arch_fetch_caller_regs()) regs, and for those user_mode() had
> > > better be correct.
> > 
> > So what should we report for the idle task?
> 
> If an interrupt hits the idle task, @regs would be !user_mode(regs),
> we'll find current->flags & PF_KTHREAD (idle not having passed through
> exec()) and therefore we'll take ABI_NONE for the user regs.
> 
> Or am I not getting it?

Sorry, I'm not trying to catch you out! Just trying to understand what the
semantics are supposed to be.

I do find the concept of user_mode(regs) bizarre for the idle task. By the
above, we definitely have a bug on arm64 (user_mode(regs) tends to be
true for the idle task), and I couldn't figure out how you avoided it on
x86. I guess it happens to work because the stack is zero-initialised or
something?

Will
