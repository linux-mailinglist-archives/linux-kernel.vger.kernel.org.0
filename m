Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3CD117EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 05:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfLJELU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 23:11:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:44644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfLJELT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:11:19 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51DA72071E;
        Tue, 10 Dec 2019 04:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951079;
        bh=cLDeA+wrF3WYK7fsmV00W4JKsOtkiaUGuSWUs4Si49I=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=CE5XShxfTcatuFNxXCJ7gtHM2KpvL6OZD0+/zxBenM4mRlFCgDtN+Xxmt8IBOSCrc
         W1R6ltJim4g6/ZOy1ICnGCw0oYnWX/AUb9NM72RWqLkSs3gkCdD4lyS5bbWvNf0bUG
         T+twvtdU/BQT19c4M00LywKJsOClM/e/GyTJD4MY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E5A3A3522768; Mon,  9 Dec 2019 20:11:18 -0800 (PST)
Date:   Mon, 9 Dec 2019 20:11:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/7] kfree_rcu() updates for v5.6
Message-ID: <20191210041118.GA3115@paulmck-ThinkPad-P72>
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

The following series disentangles kfree_rcu() from core RCU and also
provides batching, all courtesy of Joel Fernandes:

1.	Add basic support for kfree_rcu() batching.

2.	Add kfree_rcu() performance tests.

3.	Make kfree_rcu() use a non-atomic ->monitor_todo.

4.	Add multiple in-flight batches of kfree_rcu() work.

5.	Add support for debug_objects debugging for kfree_rcu().

6.	Remove kfree_rcu() special casing and lazy-callback handling.

7.	Remove kfree_call_rcu_nobatch().

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/stallwarn.txt                 |   11 
 Documentation/admin-guide/kernel-parameters.txt |   21 +
 include/linux/rcu_segcblist.h                   |    2 
 include/linux/rcutiny.h                         |   11 
 include/linux/rcutree.h                         |    3 
 include/trace/events/rcu.h                      |   32 --
 kernel/rcu/rcu.h                                |   27 -
 kernel/rcu/rcu_segcblist.c                      |   25 -
 kernel/rcu/rcu_segcblist.h                      |   25 -
 kernel/rcu/rcuperf.c                            |  191 ++++++++++++--
 kernel/rcu/srcutree.c                           |    4 
 kernel/rcu/tiny.c                               |   28 +-
 kernel/rcu/tree.c                               |  327 ++++++++++++++++++++----
 kernel/rcu/tree.h                               |    1 
 kernel/rcu/tree_plugin.h                        |   48 ---
 kernel/rcu/tree_stall.h                         |    6 
 kernel/rcu/update.c                             |   10 
 17 files changed, 548 insertions(+), 224 deletions(-)
