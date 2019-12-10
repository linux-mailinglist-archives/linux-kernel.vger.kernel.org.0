Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7B6117E82
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 04:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfLJDnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 22:43:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfLJDmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:42:23 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A47520836;
        Tue, 10 Dec 2019 03:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575949343;
        bh=Tu/7gUtpU1cBxmPQ1sfJOyv68J2ruAoA+a7c4SVI5Ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vhA1X2YpTVtS5HuYlUvBBAb88P/8B1o9a13jfapK0cMr5jzo4M3KoxbodeC2ayzQ1
         rEEOWp9DKo90qTldA3uDlGKmvsspsA7YGKBW6BAlk+VqsB+wO1zmu19BKk+hEXzmbK
         0c6vRuP/p4NmMuuQZ+OmlI6a2jGabwOkz7BWT1ck=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/12] torture: Handle systems lacking the mpstat command
Date:   Mon,  9 Dec 2019 19:42:09 -0800
Message-Id: <20191210034217.405-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210034119.GA32711@paulmck-ThinkPad-P72>
References: <20191210034119.GA32711@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcutorture scripting uses the mpstat command to determine how much
the system is being used, and adjusts make's -j argument accordingly.
However, mpstat isn't installed by default, so it would be good if the
scripting does something useful when mpstat isn't present.

This commit therefore makes the scripts assumes that if mpstat is not
present, they are free to use all the CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/cpus2use.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/cpus2use.sh b/tools/testing/selftests/rcutorture/bin/cpus2use.sh
index 4e94855..1dbfb62 100755
--- a/tools/testing/selftests/rcutorture/bin/cpus2use.sh
+++ b/tools/testing/selftests/rcutorture/bin/cpus2use.sh
@@ -15,8 +15,15 @@ then
 	exit 0
 fi
 ncpus=`grep '^processor' /proc/cpuinfo | wc -l`
-idlecpus=`mpstat | tail -1 | \
-	awk -v ncpus=$ncpus '{ print ncpus * ($7 + $NF) / 100 }'`
+if mpstat -V > /dev/null 2>&1
+then
+	idlecpus=`mpstat | tail -1 | \
+		awk -v ncpus=$ncpus '{ print ncpus * ($7 + $NF) / 100 }'`
+else
+	# No mpstat command, so use all available CPUs.
+	echo The mpstat command is not available, so greedily using all CPUs.
+	idlecpus=$ncpus
+fi
 awk -v ncpus=$ncpus -v idlecpus=$idlecpus < /dev/null '
 BEGIN {
 	cpus2use = idlecpus;
-- 
2.9.5

