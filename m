Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE5A31632B5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 21:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgBRUMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 15:12:32 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35028 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgBRUMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JUY9aCZNkGp5r3GhAmz34nl2t/YX1uUl7G5Ml5dOHcY=; b=J+op2zkhQrmmZG0CHmPk1/T3Kh
        O/GGJe4A5octVekXAoFs3Qp/NxM8W/vsthAB3yFUP8TqgbFjuQh/gPj5wNWLWS8zoOXQNqqReRtE7
        9oiA/69drvLkRivZl/J81Y3OCoZ1OaYf6H+VOEmSIfuSUjWDS/GqFn0nab6ZSStW9p/ORciSXLVL6
        1hS//7tFMZ3ecIXAR5sNlEeqSN7BRUlugD48vXsm6GVlIxluASNfl0swbmoFGYDn+oTtFOhn/KF/P
        10oTe+MeeaR904MMBDg5Y1zpvF7OLCOLufdUQGMX8VSdMjbcVfnetbi8sMdEb0UgdxCrux76b9dgg
        HeR1Fq3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j49DZ-0005mU-Ks; Tue, 18 Feb 2020 20:11:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 58E7D980E53; Tue, 18 Feb 2020 21:11:42 +0100 (CET)
Date:   Tue, 18 Feb 2020 21:11:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/3] rcu-tasks: *_ONCE() for
 rcu_tasks_cbs_head
Message-ID: <20200218201142.GF11457@worktop.programming.kicks-ass.net>
References: <20200215002446.GA15663@paulmck-ThinkPad-P72>
 <20200215002520.15746-1-paulmck@kernel.org>
 <20200217123851.GR14914@hirez.programming.kicks-ass.net>
 <20200217181615.GP2935@paulmck-ThinkPad-P72>
 <20200218075648.GW14914@hirez.programming.kicks-ass.net>
 <20200218162719.GE2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218162719.GE2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 08:27:19AM -0800, Paul E. McKenney wrote:
> On Tue, Feb 18, 2020 at 08:56:48AM +0100, Peter Zijlstra wrote:

> > I just took offence at the Changelog wording. It seems to suggest there
> > actually is a problem, there is not.
> 
> Quoting the changelog: "Not appropriate for backporting due to failure
> being unlikely."

That implies there is failure, however unlikely.

In this particular case there is absolutely no failure, except perhaps
in KCSAN. This patch is a pure annotation such that KCSAN can understand
the code.

Like said, I don't object to the actual patch, but I do think it is
important to call out false negatives or to describe the actual problem
found.
