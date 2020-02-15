Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76F8D15FB7D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgBOAgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:36:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:47194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgBOAgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:36:37 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64216206CC;
        Sat, 15 Feb 2020 00:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581726996;
        bh=XDmB0fzZx2g4HWiPoJ/T+BNmxX+vs22yK6L6RWm/DVw=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Zd7EL7Iwo9YQ/ZGJ8nNqidTkHZVexjneMd1CpgZdZ4aAxpuTtP++nScZoXI5o2pSm
         peqV0TySNbZoa/x4S3UqTYb0M84OAtWZK8CmBodyPOr6V8GcgiczhyjrRh/e0KWapL
         4aooINxN20BGPr1BOXo+7MLthAVFT1aDPWi9F/0Q=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A43083520D46; Fri, 14 Feb 2020 16:36:34 -0800 (PST)
Date:   Fri, 14 Feb 2020 16:36:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/18] Torture-test updates for v5.7
Message-ID: <20200215003634.GA16227@paulmck-ThinkPad-P72>
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

This series contains torture-test updates.

1.	Suppress forward-progress complaints during early boot.

2.	Make results-directory date format completion-friendly.

3.	Refrain from callback flooding during boot.

4.	Forgive -EBUSY from boottime CPU-hotplug operations.

5.	Allow boottime stall warnings to be suppressed.

6.	Suppress boottime bad-sequence warnings.

7.	Allow disabling of boottime CPU-hotplug torture operations.

8.	Add 100-CPU configuration.

9.	Summarize summary of build and run results.

10.	Make kvm-find-errors.sh abort on bad directory.

11.	Fix rcu_torture_one_read()/rcu_torture_writer() data race.

12.	Fix stray access to rcu_fwd_cb_nodelay.

13.	Add READ_ONCE() to rcu_torture_count and rcu_torture_batch.

14.	Annotation lockless accesses to rcu_torture_current.

15.	Measure memory footprint during kfree_rcu() test.

16.	Make rcu_torture_barrier_cbs() post from corresponding CPU.

17.	Manually clean up after rcu_barrier() failure.

18.	Set KCSAN Kconfig options to detect more data races.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt           |   10 +
 include/linux/rcutiny.h                                   |    1 
 include/linux/rcutree.h                                   |    1 
 kernel/rcu/rcu.h                                          |   17 +++
 kernel/rcu/rcuperf.c                                      |   14 ++
 kernel/rcu/rcutorture.c                                   |   73 ++++++++++----
 kernel/rcu/tree_exp.h                                     |    9 +
 kernel/rcu/tree_stall.h                                   |    6 -
 kernel/rcu/update.c                                       |   20 +++
 kernel/torture.c                                          |   29 ++++-
 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh |    2 
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh     |   17 +++
 tools/testing/selftests/rcutorture/bin/kvm.sh             |    2 
 tools/testing/selftests/rcutorture/configs/rcu/CFcommon   |    2 
 tools/testing/selftests/rcutorture/configs/rcu/TREE10     |   18 +++
 15 files changed, 187 insertions(+), 34 deletions(-)
