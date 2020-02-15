Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5C615FB8D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgBOAlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:41:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgBOAlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:41:39 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0871420848;
        Sat, 15 Feb 2020 00:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581727299;
        bh=C6WX9LIBr/cuKR3mI/lfTm6nRYEGR1atD6ddskVekeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eP47xYeV3NBMRuYJEBA03l482IDhoV5ZI7sOT2PFrVpcaQfZhtQuTGGoK5RcIbNxv
         pCytnGOIzW3na+d5NWANA2HnAKROz6Z/ZwdLSVGly5KSnjYCw0KjL4ZMMaDmln9kpa
         LasLw3NNkQTeHenuTyT2HMBbAgr2atEuFEeFptWY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/18] rcutorture: Summarize summary of build and run results
Date:   Fri, 14 Feb 2020 16:41:16 -0800
Message-Id: <20200215004125.16953-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215003634.GA16227@paulmck-ThinkPad-P72>
References: <20200215003634.GA16227@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

When running the default list of tests, the run summary of a successful
(that is, failed to find any errors) run fits easily on a 24-line screen.
But a run with something like "--configs '5*CFLIST'" will be 80 lines long,
and it is all too easy to miss a failure message when scrolling back.
This commit therefore prints out the number of runs with failing builds
or runtime failures, but only if there are any such failures.

For example, a run with a single build error and a single runtime error
would print two lines like this:

1 runs with build errors.
1 runs with runtime errors.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index e5edd51..0326f4a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -13,6 +13,9 @@
 #
 # Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
+T=/tmp/kvm-recheck.sh.$$
+trap 'rm -f $T' 0 2
+
 PATH=`pwd`/tools/testing/selftests/rcutorture/bin:$PATH; export PATH
 . functions.sh
 for rd in "$@"
@@ -68,4 +71,16 @@ do
 		fi
 	done
 done
-EDITOR=echo kvm-find-errors.sh "${@: -1}" > /dev/null 2>&1
+EDITOR=echo kvm-find-errors.sh "${@: -1}" > $T 2>&1
+ret=$?
+builderrors="`tr ' ' '\012' < $T | grep -c '/Make.out.diags'`"
+if test "$builderrors" -gt 0
+then
+	echo $builderrors runs with build errors.
+fi
+runerrors="`tr ' ' '\012' < $T | grep -c '/console.log.diags'`"
+if test "$runerrors" -gt 0
+then
+	echo $runerrors runs with runtime errors.
+fi
+exit $ret
-- 
2.9.5

