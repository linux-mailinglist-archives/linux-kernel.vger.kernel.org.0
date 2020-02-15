Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5FE15FB81
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgBOAhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:37:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:47446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbgBOAhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:37:22 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F89C2082F;
        Sat, 15 Feb 2020 00:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581727041;
        bh=KRyEqHcSoQivOOigLQPaMIaV3ohS5HPQMg4IQsAzVUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZeILJ/IsXtT7xkwPWVa66soNQdw3Q5IoGu+/EBRr1MSzWGPP8e/EDuWHHkoZjRcOi
         BIvIjEjhzgZu+oJMekekqLCWK1OiA7Z1BD7vLdas2AelHbV9aKshJDmgeojm6/UWW0
         URMKAD/DPJDsfcyDtc2ZHj6x1XOBDcnk4OHHY9Tg=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/18] torture: Make results-directory date format completion-friendly
Date:   Fri, 14 Feb 2020 16:36:55 -0800
Message-Id: <20200215003711.16463-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215003634.GA16227@paulmck-ThinkPad-P72>
References: <20200215003634.GA16227@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The names of the per-test results directories are of the form
2019.11.29-20:42:19.  This works, but the ":" characters make
tab-based shell name completion a bit onerous because the user must
remember to include a quote character somewhere before the first ":".
This commit therefore changes the ":" characters to periods, as in
2019.12.01-20.48.01", which allows tab-based completion to work more
naturally.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 78d18ab..2315e2e 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -39,7 +39,7 @@ TORTURE_TRUST_MAKE=""
 resdir=""
 configs=""
 cpus=0
-ds=`date +%Y.%m.%d-%H:%M:%S`
+ds=`date +%Y.%m.%d-%H.%M.%S`
 jitter="-1"
 
 usage () {
-- 
2.9.5

