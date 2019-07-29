Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA2E797E6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 22:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbfG2UDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 16:03:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50528 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390053AbfG2TqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=arjAFJhp7h7y5/Rhm9vbvSAfd/7R4cvilJkOjN26CHs=; b=SN8oRnKNdwiYVQc5vagAqPbm+
        nhxf5g6kbo+jKIaT6WgKBcfCA8UcqWtLb5tfvvfPr0DnCW4uPrM2lOtfI2Fox14O7d9d/Bl0Hvb2X
        OQBjh31Ya9sBlmKEvwiddNcyOKFWtTMswOB+Iobowmyi48gpJUkxMGD1ABNN7QrOWfmR4/zORTOjr
        ePtw/rxjoexYv6kZpzSRnYMWA6r+WBQxmFTho+98N2VB2Z6XXL5C1yglMxjq2KMDaoGzdMBu049b2
        c8uWJ1RE7Qal8WtUdrLdzFAuyUPkktjOOqxfaZPtxSJvHqAhYYRA9B+mApJCjR2WJH+7hqvKtJp6r
        gwnx5hhLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsBaj-0006AY-6P; Mon, 29 Jul 2019 19:45:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C45020C9B161; Mon, 29 Jul 2019 21:45:50 +0200 (CEST)
Date:   Mon, 29 Jul 2019 21:45:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 00/12] (hr)timers: Prepare for PREEMPT_RT support
Message-ID: <20190729194550.GP31398@hirez.programming.kicks-ass.net>
References: <20190726183048.982726647@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726183048.982726647@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 08:30:48PM +0200, Thomas Gleixner wrote:
> The following series brings the bulk of PREEMPT_RT specific changes for the
> (hr)timer code:
> 
>   - Handle timer deletion correctly under RT to avoid priority inversion
>     and life locks
> 
>     This mechanism might be useful for VMs as well when a vCPU
>     executing a timer callback gets scheduled out and on another vCPU
>     del_timer_sync() or hrtimer_cancel() is invoked.
> 
>     The mitigation would only work when paravirt spinlocks are
>     enabled. I've not implemented that, as I don't know whether this is a
>     real world issue. I just noticed that it is basically the same
>     problem. Adding it would be trivial.
> 
>   - Prepare for moving most hrtimer callbacks into softirq context and mark
>     timers which need to expire in hard interrupt context even on RT so
>     they don't get moved.
> 

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
