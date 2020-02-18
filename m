Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96D8C1636FF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 00:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgBRXN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 18:13:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:38846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727216AbgBRXN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:13:26 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9469A24125;
        Tue, 18 Feb 2020 23:13:24 +0000 (UTC)
Date:   Tue, 18 Feb 2020 18:13:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/3] rcu-tasks: *_ONCE() for
 rcu_tasks_cbs_head
Message-ID: <20200218181323.4a102fe7@gandalf.local.home>
In-Reply-To: <20200218225455.GN2935@paulmck-ThinkPad-P72>
References: <20200215002446.GA15663@paulmck-ThinkPad-P72>
        <20200215002520.15746-1-paulmck@kernel.org>
        <20200217123851.GR14914@hirez.programming.kicks-ass.net>
        <20200217181615.GP2935@paulmck-ThinkPad-P72>
        <20200218075648.GW14914@hirez.programming.kicks-ass.net>
        <20200218162719.GE2935@paulmck-ThinkPad-P72>
        <20200218201142.GF11457@worktop.programming.kicks-ass.net>
        <20200218202226.GJ2935@paulmck-ThinkPad-P72>
        <20200218174503.3d4e4750@gandalf.local.home>
        <20200218225455.GN2935@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 14:54:55 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

>     This data race was reported by KCSAN.  Not appropriate for backporting
>     due to failure being unlikely and due to the mild consequences of the
>     failure, namely a confusing rcutorture console message.
>     

I've seen patches backported for less. :-/

Really, any statement that says something may go awry with the code,
will be an argument to backport it.

-- Steve
