Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3244163786
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 00:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgBRXyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 18:54:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbgBRXyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:54:07 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F1CA2068F;
        Tue, 18 Feb 2020 23:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582070047;
        bh=sVFef4PzqftuGRief/QBL+AuxajuMta5Rk9EY8Z0RIg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ysC1+TgxWDsLsphReqqFT1BVqWJ9vnlLOGNZQt3e1XxQH4rY6Li/ezz7z0Evioru1
         bDn/h6UG/J7T5F1SL3FFSpKqswxoNaCvn8qXP7KnY5Up9WAVAkNEs5KLF1ad5dhuUN
         v1yHV1aqaNPY34IMZoPTKF2QuGCIq0qmZT2XRdw0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DBF4F3520856; Tue, 18 Feb 2020 15:54:06 -0800 (PST)
Date:   Tue, 18 Feb 2020 15:54:06 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/3] rcu-tasks: *_ONCE() for
 rcu_tasks_cbs_head
Message-ID: <20200218235406.GO2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200215002520.15746-1-paulmck@kernel.org>
 <20200217123851.GR14914@hirez.programming.kicks-ass.net>
 <20200217181615.GP2935@paulmck-ThinkPad-P72>
 <20200218075648.GW14914@hirez.programming.kicks-ass.net>
 <20200218162719.GE2935@paulmck-ThinkPad-P72>
 <20200218201142.GF11457@worktop.programming.kicks-ass.net>
 <20200218202226.GJ2935@paulmck-ThinkPad-P72>
 <20200218174503.3d4e4750@gandalf.local.home>
 <20200218225455.GN2935@paulmck-ThinkPad-P72>
 <20200218181323.4a102fe7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218181323.4a102fe7@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 06:13:23PM -0500, Steven Rostedt wrote:
> On Tue, 18 Feb 2020 14:54:55 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> >     This data race was reported by KCSAN.  Not appropriate for backporting
> >     due to failure being unlikely and due to the mild consequences of the
> >     failure, namely a confusing rcutorture console message.
> >     
> 
> I've seen patches backported for less. :-/
> 
> Really, any statement that says something may go awry with the code,
> will be an argument to backport it.

You aren't kidding!  Rumor has it that someone tried backporting the
RCU flavor-consolidation work, for but one example.  Though I cannot
help but salute the level of insanity represented by that attempt.  ;-)

							Thanx, Paul
