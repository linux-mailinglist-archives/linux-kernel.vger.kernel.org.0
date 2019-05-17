Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A56042150D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 10:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfEQIE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 04:04:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40192 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbfEQIE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 04:04:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0B4C80D;
        Fri, 17 May 2019 01:04:28 -0700 (PDT)
Received: from blommer (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96FA63F575;
        Fri, 17 May 2019 01:04:26 -0700 (PDT)
Date:   Fri, 17 May 2019 09:04:20 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Raphael Gault <raphael.gault@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
        acme@kernel.org
Subject: Re: [PATCH 4/6] arm64: pmu: Add hook to handle pmu-related undefined
 instructions
Message-ID: <20190517080419.dziz4iqc7t4mpoej@blommer>
References: <20190516132148.10085-1-raphael.gault@arm.com>
 <20190516132148.10085-5-raphael.gault@arm.com>
 <20190517071018.GH2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517071018.GH2623@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 09:10:18AM +0200, Peter Zijlstra wrote:
> On Thu, May 16, 2019 at 02:21:46PM +0100, Raphael Gault wrote:
> > In order to prevent the userspace processes which are trying to access
> > the registers from the pmu registers on a big.LITTLE environment we
> > introduce a hook to handle undefined instructions.
> > 
> > The goal here is to prevent the process to be interrupted by a signal
> > when the error is caused by the task being scheduled while accessing
> > a counter, causing the counter access to be invalid. As we are not able
> > to know efficiently the number of counters available physically on both
> > pmu in that context we consider that any faulting access to a counter
> > which is architecturally correct should not cause a SIGILL signal if
> > the permissions are set accordingly.
> 
> The other approach is using rseq for this; with that you can guarantee
> it will never issue the instruction on a wrong CPU.
> 
> That said; emulating the thing isn't horrible either.

Yup. Attempting to use rseq is on the todo list.

> > +	/*
> > +	 * We put 0 in the target register if we
> > +	 * are reading from pmu register. If we are
> > +	 * writing, we do nothing.
> > +	 */
> 
> Wait _what_ ?!? userspace can _WRITE_ to these registers?

Remember that this is in an undefined (trap) handler.

If userspace _attempts_ to write to the registers, the CPU will trap to the
kernel. The comment is perhaps misleading; when we "do nothing", the common
trap handling code will send a SIGILL to userspace.

It would probably be better to say something like:

	/*
	 * If userspace is tries to read a counter that doesn't exist on this
	 * CPU, we emulate it as reading as zero. This happens if userspace is
	 * preempted between reading the idx and actually reading the counter,
	 * and the seqlock and idx have already changed, so it's as-if the
	 * counter has been reprogrammed with a different event.
	 *
	 * We don't permit userspace to write to these registers, and will
	 * inject a SIGILL.
	 */

There is one caveat: userspace can write to PMSELR without trapping, so we will
have to context-switch with the task. That only affects indirect addressing of
PMU registers, and doesn't have a functional effect on the behaviour of the
PMU, so that's benign from the PoV of perf.

Thanks,
Mark.
