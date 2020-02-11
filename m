Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAA7159633
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 18:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgBKRcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 12:32:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbgBKRcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xEZn7flkyukRhdtqoKsfHjJ5Uqm8IWBX07W95P9+qgo=; b=aebLhhByFaUgdZm87khGrgzFgE
        +M4fflT3Jowlwq9xYPDPnLXnbzTVAI9YBmhjVZFFo1Rw2T0oTj+2xiSuKJI/aND8bgqCCe3iJQ8/Q
        L2MH8hqBg39qyhMcNcp7Y9mc5v/yxyC/31uuzAITeXkwB7m7yG6j0AdHd9D3uMfvoo3DnIv+8SeaF
        wt7qWBaG+RAe/xTfY91ZIWQrHW0NsabHFY7hvoRIWDoqyQolXip2jRA58snyjhR2UbProrPvB/bSl
        vMZS6AkpVco25Jx9K9yVgfm1YArYCuBIlVgQuujHNv6QDstklr5D7T8MpQTE4aw3WtrQBGqiax28p
        rJxtm3Gg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1ZOR-0001pz-T0; Tue, 11 Feb 2020 17:32:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C13F7305803;
        Tue, 11 Feb 2020 18:30:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B71B2B920215; Tue, 11 Feb 2020 18:32:13 +0100 (CET)
Date:   Tue, 11 Feb 2020 18:32:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2] tracing/perf: Move rcu_irq_enter/exit_irqson() to
 perf trace point hook
Message-ID: <20200211173213.GX14946@hirez.programming.kicks-ass.net>
References: <20200211095047.58ddf750@gandalf.local.home>
 <20200211153452.GW14914@hirez.programming.kicks-ass.net>
 <20200211111828.48058768@gandalf.local.home>
 <20200211172952.GY14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211172952.GY14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 06:29:52PM +0100, Peter Zijlstra wrote:
> +#define trace_rcu_enter()					\
> +({								\
> +	unsigned long state = 0;				\
> +	if (!rcu_is_watching())	{				\

Also, afaict rcu_is_watching() itself needs more love, the functio has
notrace, but calls other stuff that does not have notrace or inline.
