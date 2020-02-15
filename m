Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A428715FB4A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgBOADu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:03:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbgBOADt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:03:49 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BED024649;
        Sat, 15 Feb 2020 00:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581725028;
        bh=RWUpJokn+ItyNP1dp+jrWZfxIN6Wh7hz2VquOr9PtkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMrsYNvhj4vGwzysw/CmL95Memr9by27VwO6GGUc9qWcQst4ZW7WNdXZDzX7Q61KD
         Ke5ox544JcuBfrFZqnxGji5T/THlWxlRyvocNjHLLaO2oUO6c7EHxcNsmiBxINpUU4
         EHBsfRjVKR22WA4FZzoX6UNPwHYmKe/AfEXe38N4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/4] locktorture: Allow CPU-hotplug to be disabled via --bootargs
Date:   Fri, 14 Feb 2020 16:03:35 -0800
Message-Id: <20200215000337.14667-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215000312.GA14585@paulmck-ThinkPad-P72>
References: <20200215000312.GA14585@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The bootparam_hotplug_cpu() bash function was checking for CPU-hotplug
kernel-boot parameters from --bootargs, but that check was specific to
rcutorture ("rcutorture\.onoff_").  This commit therefore makes this
check also work for locktorture ("torture\.onoff_").

Note that rcuperf does not do CPU-hotplug operations, so it is not
necessary to make a similar change for rcuperf.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index c3a49fb..1281022 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -12,7 +12,7 @@
 # Returns 1 if the specified boot-parameter string tells rcutorture to
 # test CPU-hotplug operations.
 bootparam_hotplug_cpu () {
-	echo "$1" | grep -q "rcutorture\.onoff_"
+	echo "$1" | grep -q "torture\.onoff_"
 }
 
 # checkarg --argname argtype $# arg mustmatch cannotmatch
-- 
2.9.5

