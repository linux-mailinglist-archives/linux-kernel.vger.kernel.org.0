Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9238B8566E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 01:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388600AbfHGX1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 19:27:19 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39979 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbfHGX1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:27:19 -0400
Received: by mail-ot1-f68.google.com with SMTP id l15so53969926oth.7;
        Wed, 07 Aug 2019 16:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ptsN0pKGjspYax7sMd3DV0UE0ign/6FOn3Xkm6nIgtg=;
        b=Xbs82/Kp6Uslw87FjoUjS/yMLoEwH3/2IopZZ5p+CSpU2BT9X50Ygg616F/IkmCKsW
         +5LbBzbmyNmgFtL+s8QWbFcDhhaYLlRBd6W6jAduJREoZD4jMjRknCBe1juE6J1r2Cg+
         k4VOtdrmAqVF7Y0G6C9ANPEFsM3trFFKi9AiYviRUIb2lnVPiqCcrougqW/yR4pjpNSd
         rZkdDhyLZYeS82QviPS+Uq785jLoKr2av9yu6IyIVWL7ayRZum72kLRpk7HpmD8fzNpk
         b/slvFNXz0Ek+Xc/PBDL2JvB8dL6/RS19Wk5S4c6euo5BRG6S6uMA4m79uodSh+VTDa8
         iA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ptsN0pKGjspYax7sMd3DV0UE0ign/6FOn3Xkm6nIgtg=;
        b=sAQsi3FmBZ0BQKHgT+A5Ob8e2b2sE9BflxZadZSS8xX9qGMX0G0EdMWgoL30bil4Bo
         XZMlIit3knhbmme/C8M2bl7fhBQZgXewD4kZf2PvDCdFkM4vr+gmOMuGNMX1zTMgz9CZ
         lURzhNYaeSdg+b5ll4o2a3bbYYWiU2yuuEpKB3inUXlumtMX22yy9qFLEHWhiKIDpNWq
         xPkwpBZFqGU54wX187e1202s0l+dIQ8T5LqbEyHI5IScLnZD8vDhVLCzKA1G8IR/CZAf
         /EVa0/G+kL57orwZt2bP1WY//4KGhXHdPNI4D1ipbyY+rL//GzanUt4y+7P5XkRjioHF
         T97w==
X-Gm-Message-State: APjAAAUrBRdutW981My2UGKQg5qPc6tuVC7d0S3NALj9Xk6oW4F6mCa7
        DyUF9WdzdLAUs6ugHGusOTQFY+3RbUA=
X-Google-Smtp-Source: APXvYqyVZSqqaua3CweR97UPjnwSDQ9AOTAtfEPrrcS06k/L985nKuwRM1MfcgL6vmYKo0vh8eJZyA==
X-Received: by 2002:a6b:7909:: with SMTP id i9mr11646977iop.8.1565220437747;
        Wed, 07 Aug 2019 16:27:17 -0700 (PDT)
Received: from oc2825805254.ibm.com ([32.97.110.54])
        by smtp.gmail.com with ESMTPSA id b14sm103425056iod.33.2019.08.07.16.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 16:27:17 -0700 (PDT)
From:   Ethan Hansen <1ethanhansen@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dave@stgolabs.net,
        paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, Ethan Hansen <1ethanhansen@gmail.com>
Subject: [PATCH tip/core/rcu 1/1] rcu: Remove unused variable rcu_perf_writer_state
Date:   Wed,  7 Aug 2019 16:26:55 -0700
Message-Id: <1565220415-3070-1-git-send-email-1ethanhansen@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable rcu_perf_writer_state is declared and initialized,
but is never actually referenced. Remove it to clean code.

Signed-off-by: Ethan Hansen <1ethanhansen@gmail.com>
---
 kernel/rcu/rcuperf.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 5a879d0..ff02936 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -109,7 +109,6 @@
 static unsigned long b_rcu_perf_writer_finished;
 static DEFINE_PER_CPU(atomic_t, n_async_inflight);
 
-static int rcu_perf_writer_state;
 #define RTWS_INIT		0
 #define RTWS_ASYNC		1
 #define RTWS_BARRIER		2
@@ -404,25 +403,20 @@ static void rcu_perf_async_cb(struct rcu_head *rhp)
 			if (!rhp)
 				rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
 			if (rhp && atomic_read(this_cpu_ptr(&n_async_inflight)) < gp_async_max) {
-				rcu_perf_writer_state = RTWS_ASYNC;
 				atomic_inc(this_cpu_ptr(&n_async_inflight));
 				cur_ops->async(rhp, rcu_perf_async_cb);
 				rhp = NULL;
 			} else if (!kthread_should_stop()) {
-				rcu_perf_writer_state = RTWS_BARRIER;
 				cur_ops->gp_barrier();
 				goto retry;
 			} else {
 				kfree(rhp); /* Because we are stopping. */
 			}
 		} else if (gp_exp) {
-			rcu_perf_writer_state = RTWS_EXP_SYNC;
 			cur_ops->exp_sync();
 		} else {
-			rcu_perf_writer_state = RTWS_SYNC;
 			cur_ops->sync();
 		}
-		rcu_perf_writer_state = RTWS_IDLE;
 		t = ktime_get_mono_fast_ns();
 		*wdp = t - *wdp;
 		i_max = i;
@@ -463,10 +457,8 @@ static void rcu_perf_async_cb(struct rcu_head *rhp)
 		rcu_perf_wait_shutdown();
 	} while (!torture_must_stop());
 	if (gp_async) {
-		rcu_perf_writer_state = RTWS_BARRIER;
 		cur_ops->gp_barrier();
 	}
-	rcu_perf_writer_state = RTWS_STOPPING;
 	writer_n_durations[me] = i_max;
 	torture_kthread_stopping("rcu_perf_writer");
 	return 0;
-- 
1.8.3.1

