Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDF859D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 15:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfF1Nzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 09:55:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43412 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfF1Nz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wYcNOsgWlh/Ecvl7SnDlME5ey9iGCA4wqtawTfBrfA4=; b=RIDEBwrIx6GsUKo+FjlwKVVjj
        1P2Fr1cfIItpXAzZ+4UY5WxaxqmQ/o+Z+v/ydg9fsdVq/HkRs5lUvb/Jn9f9J1UbYaJjecj3lcqbm
        qkgmYhKsDCwxq9KUb0hM9Y3hIyNsBu5RZEhu7WIxoyeouCLclHYxcnTibmqFuabcFth3VkVDuvSAu
        3HFy+O+sAvC/6C+qKv8RF61/hezoa2L4qM7/f2/1fF0KpNJnpxbdvqEGRRqvuYPTGLXBiYwBr73wy
        oBSVr66FtiU41RsooPhKpBhFddbWbY+WLoPhBtSpTveZVc12mMblXdLM/yhaLb003Ni6cA6NZEVSv
        sWXHf0JEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgrKm-0000rK-8L; Fri, 28 Jun 2019 13:54:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C8642010DE3A; Fri, 28 Jun 2019 15:54:33 +0200 (CEST)
Date:   Fri, 28 Jun 2019 15:54:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190628135433.GE3402@hirez.programming.kicks-ass.net>
References: <20190626135447.y24mvfuid5fifwjc@linutronix.de>
 <20190626162558.GY26519@linux.ibm.com>
 <20190627142436.GD215968@google.com>
 <20190627103455.01014276@gandalf.local.home>
 <20190627153031.GA249127@google.com>
 <20190627155506.GU26519@linux.ibm.com>
 <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627184107.GA26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 11:41:07AM -0700, Paul E. McKenney wrote:
> Or just don't do the wakeup at all, if it comes to that.  I don't know
> of any way to determine whether rcu_read_unlock() is being called from
> the scheduler, but it has been some time since I asked Peter Zijlstra
> about that.

There (still) is no 'in-scheduler' state.
