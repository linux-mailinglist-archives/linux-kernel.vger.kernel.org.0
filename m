Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1633715FB64
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgBOAST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:18:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgBOAST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:18:19 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58089207FF;
        Sat, 15 Feb 2020 00:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581725898;
        bh=zBkIaXyCDkP0NHhzcS+nOpVULeLBaNTeUYV5b4mTysY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Ay7eKa0NhKknq7r8n5VMKeW8J10mV+eaVAPGJsR74nCIxhqxwkGOoLRjdDqyLp7vK
         VUZytnkm9+XtrNGeiZeVTvJ3xJwhp9+Nj8UeQBvuG3ZtQuBtGGzAnBRbtg6bmK9jy5
         r9CX3wW7FHxub6psEs8uArKQ3bGe2Bu6btKhDCT0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B6B023520D46; Fri, 14 Feb 2020 16:18:16 -0800 (PST)
Date:   Fri, 14 Feb 2020 16:18:16 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/5] Callback-overload update for v5.7
Message-ID: <20200215001816.GA15284@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains updates to handling of callback-overload condiitons.

1.	Clear ->core_needs_qs at GP end or self-reported QS.

2.	React to callback overload by aggressively seeking quiescent
	states.

3.	React to callback overload by boosting RCU readers.

4.	Fix spelling mistake "leval" -> "level".

5.	Update __call_rcu() comments.

								Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt |    9 ++
 kernel/rcu/tree.c                               |   97 ++++++++++++++++++++----
 kernel/rcu/tree.h                               |    4 
 kernel/rcu/tree_plugin.h                        |    6 -
 4 files changed, 99 insertions(+), 17 deletions(-)
