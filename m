Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5FD797C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 22:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389440AbfG2UCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 16:02:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389868AbfG2TsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zzcP4I/goZHDVfJXWOZ0ZR8llcddHlHoO7PLqf6pRVc=; b=paAeo85eyveVhvF3PvCr0gLul
        N4tE2hr/ulUCH6rCdBtQx6AAqXUFZPDbMfuESM9eAHKPeM2ASegUoDVOmBfvfzUPIWySv/Fh9Ke38
        Vju0hZWjPPPdCjoOYrWHW/ttnN46zitw618lMV849kuYRuOKBVGCAR3u3Kd7J2KvjPK7pUWD4pF1g
        mKL1prjQ9Em8SYPBK/5bMGkkUkuZnYT8xnDbaLu6qKwzUJqhmB3qIQVpnXtg278n829UzBhqlaC6P
        u5p7PdlIwYycn9LKFueufo3y0FdxVx2+5a9blEkhA9f8zXfdTPGfo5pdu0i903WjP2rjwlttXDNUN
        GQ8Rfn+qw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsBcv-0001d4-CN; Mon, 29 Jul 2019 19:48:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 473E020C9B163; Mon, 29 Jul 2019 21:48:07 +0200 (CEST)
Date:   Mon, 29 Jul 2019 21:48:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch 0/8] core, x86: Preparatory steps for RT
Message-ID: <20190729194807.GQ31398@hirez.programming.kicks-ass.net>
References: <20190726211936.226129163@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726211936.226129163@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 11:19:36PM +0200, Thomas Gleixner wrote:
> CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by
> CONFIG_PREEMPT_RT. Both PREEMPT and PREEMPT_RT require the same
> functionality which today depends on CONFIG_PREEMPT.
> 
> The following series adjusts the core and x86 code to use
> CONFIG_PREEMPTION where appropriate and extends the x86 dumpstack
> implementation to display PREEMPT_RT instead of PREEMPT on a RT
> enabled kernel.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
