Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3A221872BC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 19:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbgCPSwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 14:52:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732298AbgCPSwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:52:01 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC37920658;
        Mon, 16 Mar 2020 18:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584384720;
        bh=2ucCiq+vrp0FXX3LIhi0+Y+3BKE6y3mqtF0yHFzPsK8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NNzYNXxxeBlVaq4hnG3GZNrsfbmO6VSq/FLBewk7zKcjkBrhK0jeQMYvzxF4Gw2ol
         pYZsihRQ0VZ3ezW8AV+kCoCfHylYeniiggXZEY+9tg2pyXz2LvEhffzBY2tFQfr+Oi
         yOLEfEA6gKenZ0YdP5Cl5iWfxtiiBqFS794WQriM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 557863522DE1; Mon, 16 Mar 2020 11:52:00 -0700 (PDT)
Date:   Mon, 16 Mar 2020 11:52:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>
Subject: Re: [PATCH RFC tip/core/rcu 0/16] Prototype RCU usable from idle,
 exception, offline
Message-ID: <20200316185200.GZ3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
 <20200313144145.GA31604@lenoir>
 <20200313154243.GU3199@paulmck-ThinkPad-P72>
 <2062731308.28584.1584294305768.JavaMail.zimbra@efficios.com>
 <20200315175921.GT3199@paulmck-ThinkPad-P72>
 <20200316143606.605ddd68@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316143606.605ddd68@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 02:36:06PM -0400, Steven Rostedt wrote:
> On Sun, 15 Mar 2020 10:59:21 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > Nothing survives real life
> 
>   #coronavirus!

Heh!

But something will eventually do coronavirus in.  Hopefully one of those
things is my immune system.  :-/

							Thanx, Paul
