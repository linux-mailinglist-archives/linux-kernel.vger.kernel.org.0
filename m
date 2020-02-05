Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 475D1153181
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 14:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgBENOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 08:14:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:60144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbgBENOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:14:16 -0500
Received: from oasis.local.home (unknown [212.187.182.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1266217BA;
        Wed,  5 Feb 2020 13:14:13 +0000 (UTC)
Date:   Wed, 5 Feb 2020 08:14:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Amol Grover <frextrite@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: Re: [PATCH] tracing: Annotate ftrace_graph_hash pointer with __rcu
Message-ID: <20200205081409.4550aa67@oasis.local.home>
In-Reply-To: <20200205131110.GT2935@paulmck-ThinkPad-P72>
References: <20200201072703.17330-1-frextrite@gmail.com>
        <20200203163301.GB85781@google.com>
        <20200204200116.479f0c60@oasis.local.home>
        <20200205131110.GT2935@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2020 05:11:10 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> I strongly recommend a comment stating why disabling preemption prevents
> ftrace_graph_hash from going away.  I see the synchronize_rcu() after
> the rcu_assign_pointer() in ftrace_graph_release(), but I don't see
> anything that waits on CPUs that RCU is not watching.
> 
> Of course, event tracing -makes- RCU watch when needed, but if that
> was set up, then lockdep would not have complained.
> 
> So what am I missing?

Keep looking in your INBOX and look at the patch I asked you to ack or
complain about ;-) 

-- Steve
