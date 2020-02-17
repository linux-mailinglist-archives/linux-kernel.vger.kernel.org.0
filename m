Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E62C161890
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 18:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgBQRLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 12:11:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgBQRLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hAkY+PHcqgUVHvVTlHhhrkpeznoFmCxKBnJE+5h2WKM=; b=rLOREUYK7Hx54iTQMj70doR7BS
        55qa4HZJnZwT8W7SO/rDdJ6eYzDXi+Xy4ZnYcsI+j9fLHfDDkyqnvPXzwc9rzKoz5VJAWsaYFklt6
        p0lVZ+Hy8kFcRcgXwGG9v2riXi4cUFAFF2I8fhzXq6m7bquRtoSOagVOiGSMkWLsSA/vyJd3rzxHN
        yLFophGX+1BDxY2AeeUfS5sR2Ey7l03o/E/tzadmJlJnedxErXGhAd/vECOCJBOfSFWZWspHulgtK
        leqEOxpnm01qR5eF3fv8kL8HEJWkhN9RR3kZSB4tqZkuynE6SRd1qPb6ORBOvfoJ8cE/zquDUFhHw
        XM2g6dWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3jvH-0007Cc-2T; Mon, 17 Feb 2020 17:11:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32B71300565;
        Mon, 17 Feb 2020 18:09:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86C5B2B92586D; Mon, 17 Feb 2020 18:11:04 +0100 (CET)
Date:   Mon, 17 Feb 2020 18:11:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 1/4] srcu: Fix __call_srcu()/process_srcu()
 datarace
Message-ID: <20200217171104.GV14914@hirez.programming.kicks-ass.net>
References: <20200215002907.GA15895@paulmck-ThinkPad-P72>
 <20200215002932.15976-1-paulmck@kernel.org>
 <20200217124231.GS14914@hirez.programming.kicks-ass.net>
 <20200217170157.GA166797@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217170157.GA166797@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 12:01:57PM -0500, Joel Fernandes wrote:

> Peter it sounds like you have a failure scenario in mind. Could you describe
> more if so?
> 
> I am curious if you were thinking of invented-stores issue here.
> 
> For educational purposes, I was trying to come up with an example where my
> compiler does something bad to code without WRITE_ONCE(). So far I only can
> reproduce a write-tearing example when write with an immediate value is split
> into 2 writes, like Will mentioned:
> http://lore.kernel.org/r/20190821103200.kpufwtviqhpbuv2n@willie-the-truck
> But that does not seem to apply to this code.

> > > -			snp->srcu_gp_seq_needed_exp = gpseq;
> > > +			WRITE_ONCE(snp->srcu_gp_seq_needed_exp, gpseq);

Yeah, store tearing. No sane compiler will actually do that, but it is
allowed to do random permutations of byte stores just to fuck with us.

WRITE_ONCE() disallows that.

In that case, the READ_ONCE()s could observe garbage and the compare
might accidentally report the wrong thing.
