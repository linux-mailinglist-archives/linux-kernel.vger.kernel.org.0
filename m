Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFC11048B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 03:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKUCo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 21:44:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:54516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbfKUCoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 21:44:54 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7122A20895;
        Thu, 21 Nov 2019 02:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574304293;
        bh=OPg+OWIL7YrZ7aK6JFMMVO6jtqfg0GHKfu/eH8lWhWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2PaYhEZUfA9w930bqaZRhNfIfGG1tnHvxoFy2Zr9v86JwLfKAbDNyhlUU0Pqz+rM7
         yqIZ9uu4Nr75v9X4dFfKnzYcRVVZPjvHOGgiOENBAsZFU+NkHVGf96pnp19IcOCz0I
         VsqsmVHMIPlagO67kVpbd0GmrowCGoxoPjixL2A8=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 6/6] rackmeter: Use vtime aware kcpustat accessor
Date:   Thu, 21 Nov 2019 03:44:30 +0100
Message-Id: <20191121024430.19938-7-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121024430.19938-1-frederic@kernel.org>
References: <20191121024430.19938-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a vtime safe kcpustat accessor, use it to fetch
CPUTIME_NICE and fix frozen kcpustat values on nohz_full CPUs.

Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 drivers/macintosh/rack-meter.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 4134e580f786..60311e8d6240 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -81,13 +81,14 @@ static int rackmeter_ignore_nice;
  */
 static inline u64 get_cpu_idle_time(unsigned int cpu)
 {
+	struct kernel_cpustat *kcpustat = &kcpustat_cpu(cpu);
 	u64 retval;
 
-	retval = kcpustat_cpu(cpu).cpustat[CPUTIME_IDLE] +
-		 kcpustat_cpu(cpu).cpustat[CPUTIME_IOWAIT];
+	retval = kcpustat->cpustat[CPUTIME_IDLE] +
+		 kcpustat->cpustat[CPUTIME_IOWAIT];
 
 	if (rackmeter_ignore_nice)
-		retval += kcpustat_cpu(cpu).cpustat[CPUTIME_NICE];
+		retval += kcpustat_field(kcpustat, CPUTIME_NICE, cpu);
 
 	return retval;
 }
-- 
2.23.0

