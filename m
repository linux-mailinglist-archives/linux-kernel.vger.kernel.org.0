Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 968F5117E6A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 04:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfLJDlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 22:41:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:60112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727274AbfLJDlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:41:20 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A102420692;
        Tue, 10 Dec 2019 03:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575949279;
        bh=DY6Mgd1bV3eKe7dD6rRjdTCDg7hrEmmsv83if/ODO+A=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=yX7efwEvgFLso8YyZeWALcH3/4deB0wNLdtTdpUtb0gNDkjZBrZv/ZcrJUB16kGSQ
         Upab0Yt4VmJ8ZLJpocbG9/RCCXyA8t5mMuw181p1Fe4Ge6N3Icm3tQVUpZNVauKVNE
         V1Tv8093X1w5bwDp1UNcP2bc/FsTWD5TNM/+E2hw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3030E3522768; Mon,  9 Dec 2019 19:41:19 -0800 (PST)
Date:   Mon, 9 Dec 2019 19:41:19 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/12] Torture-test updates for v5.6
Message-ID: <20191210034119.GA32711@paulmck-ThinkPad-P72>
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

This series provides torture-test updates.

1.	Use gawk instead of awk for systime() function.

2.	Dispense with Dracut for initrd creation.

3.	Handle jitter for CPUs that cannot be offlined.

4.	Handle systems lacking the mpstat command.

5.	Add worst-case call_rcu() forward-progress results.

6.	Pull callback forward-progress data into rcu_fwd struct.

7.	Thread rcu_fwd pointer through forward-progress functions.

8.	Move to dynamic initialization of rcu_fwds.

9.	Complete threading rcu_fwd pointers through functions.

10.	Dynamically allocate rcu_fwds structure.

11.	Allow "CFLIST" to specify default list of scenarios.

12.	Hoist calls to lscpu to higher-level kvm.sh script.

							Thanx, Paul

------------------------------------------------------------------------

 kernel/rcu/rcutorture.c                                   |  241 +++++++-------
 tools/testing/selftests/rcutorture/bin/cpus2use.sh        |   11 
 tools/testing/selftests/rcutorture/bin/jitter.sh          |   30 +
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh |    3 
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh  |   13 
 tools/testing/selftests/rcutorture/bin/kvm.sh             |   30 +
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh        |   55 ---
 7 files changed, 194 insertions(+), 189 deletions(-)
