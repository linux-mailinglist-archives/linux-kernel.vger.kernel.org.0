Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47F7618C56B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 03:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCTCly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 22:41:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbgCTClx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 22:41:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A316206D7;
        Fri, 20 Mar 2020 02:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584672113;
        bh=VaOaDt5Ar0V7JbMhnQVSEdqQlneMYlnyedn/NWqYcWs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xteT3owz/emReDP4O3F7ndguFft5jjMAIb3GMNfc4G5m/jsNl4bjFnjRV2z2x4CW/
         Dv8ryhEPcFjqfQAMTxSKRr5WcX+myTI4RkMZ+6AydU++Ab7LEhkEh0WNVU+mGMhq6E
         MjYAGIXU7/hrqjSVZvybcQrmEWTAdSetImVgfVlA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 04F7835226B9; Thu, 19 Mar 2020 19:41:53 -0700 (PDT)
Date:   Thu, 19 Mar 2020 19:41:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH RFC v2 tip/core/rcu 14/22] rcu-tasks: Add an RCU Tasks
 Trace to simplify protection of tracing hooks
Message-ID: <20200320024152.GM3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
 <20200319001100.24917-14-paulmck@kernel.org>
 <20200319154239.6d67877d@gandalf.local.home>
 <20200320002813.GL3199@paulmck-ThinkPad-P72>
 <20200319204838.1f78152a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319204838.1f78152a@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 08:48:38PM -0400, Steven Rostedt wrote:
> On Thu, 19 Mar 2020 17:28:13 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > Good point.  If interrupts are disabled, it will need to use some
> > other mechanism.  One approach is irqwork.  Another is a timer.
> > 
> > Suggestions?
> 
> Ftrace and perf use irq_work, I would think that should work here too.

Sounds good, will give it a go!  And thank you for catching this!

							Thans, Paul
