Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9702D197285
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 04:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgC3CeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 22:34:17 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42015 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbgC3Cdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id t9so13906453qto.9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 19:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i7es2W9CEqIB4GMVROiAy2JZJ57uZN4pFanE1V1uKhA=;
        b=fxT0FW2SkmPY/tTctVOOiNEaCQkEJhYBD9Ljg3DTwuJpXM6Z+pQuU2xjzrWckST7Wt
         kTky1ILPKzjvatfadFjqzTvUwv+sQZt7v+UsnxOvCkxsgAJran4D5XewUjyU9oT8+Jl+
         E6huwFcNFYQ0MuaqQftjvXLOI6/gzgK68TEnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i7es2W9CEqIB4GMVROiAy2JZJ57uZN4pFanE1V1uKhA=;
        b=bny1Le64W5paaL53I6m71sOF5m8Yr/DBhW6dTSyn59laNU8rApw/RpEy4/xt0Pn4B1
         4LZVE/Uc7KgGvcGDCT8bAtAgruMi2TNw6lPl5UcgOQkiGDC0Pog8N7oAy43bHoZdLP0a
         dwmMADmwXrBuWazVjA3t/QZe5+gEQ1K6apeLK6lBoQ5dFrBNrWQPmoa/4EmjOpZrb7Jm
         loCcT+bJ33Mlaat9F9uQLed0ahy8KLV1R22LdlbORxcY8kjiNt2pQens12bCp7GI5gzr
         p2CuUzCtCn6djiRnFcnq3/ax780+s4ewM4FI7/PyN5c1S6bxJice/EM/LA/qteik6l3d
         h9gg==
X-Gm-Message-State: ANhLgQ0LyFyiwgF3lYzoZtYzC69v4N9f2c5limvc9rN+qCsyC32JoUHS
        muLAmdeY/oaruRktntFgupC/jVKriRI=
X-Google-Smtp-Source: ADFU+vs2ndobSCzogyfpMzEQcEldd3+b0TiV6qhu47wRBO4t65Nlw0iw94d+x/RbDFy/qTpIQuCBmQ==
X-Received: by 2002:aed:3c4b:: with SMTP id u11mr9819279qte.208.1585535616115;
        Sun, 29 Mar 2020 19:33:36 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:35 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 05/18] rcu: Rename kfree_call_rcu() to the kvfree_call_rcu().
Date:   Sun, 29 Mar 2020 22:32:35 -0400
Message-Id: <20200330023248.164994-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200330023248.164994-1-joel@joelfernandes.org>
References: <20200330023248.164994-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The reason is, it is capable of freeing vmalloc()
memory now.

Do the same with __kfree_rcu() macro, it becomes
__kvfree_rcu(), the reason is the same as pointed
above.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcupdate.h | 8 ++++----
 include/linux/rcutiny.h  | 2 +-
 include/linux/rcutree.h  | 2 +-
 kernel/rcu/tree.c        | 8 ++++----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index c6f6a195cb1cd..edb6eeba49f83 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -830,10 +830,10 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 /*
  * Helper macro for kfree_rcu() to prevent argument-expansion eyestrain.
  */
-#define __kfree_rcu(head, offset) \
+#define __kvfree_rcu(head, offset) \
 	do { \
 		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offset)); \
-		kfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
+		kvfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
 	} while (0)
 
 /**
@@ -852,7 +852,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * Because the functions are not allowed in the low-order 4096 bytes of
  * kernel virtual memory, offsets up to 4095 bytes can be accommodated.
  * If the offset is larger than 4095 bytes, a compile-time error will
- * be generated in __kfree_rcu().  If this error is triggered, you can
+ * be generated in __kvfree_rcu(). If this error is triggered, you can
  * either fall back to use of call_rcu() or rearrange the structure to
  * position the rcu_head structure into the first 4096 bytes.
  *
@@ -867,7 +867,7 @@ do {									\
 	typeof (ptr) ___p = (ptr);					\
 									\
 	if (___p)							\
-		__kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
+		__kvfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
 } while (0)
 
 /**
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index d77e11186afd1..5ba0bcb231976 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -34,7 +34,7 @@ static inline void synchronize_rcu_expedited(void)
 	synchronize_rcu();
 }
 
-static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	call_rcu(head, func);
 }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 45f3f66bb04df..3a7829d69fef8 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -33,7 +33,7 @@ static inline void rcu_virt_note_context_switch(int cpu)
 }
 
 void synchronize_rcu_expedited(void);
-void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
+void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
 
 void rcu_barrier(void);
 bool rcu_eqs_special_set(int cpu);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1209945a34bfd..3fb19ea039912 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3082,18 +3082,18 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
 }
 
 /*
- * Queue a request for lazy invocation of kfree_bulk()/kfree() after a grace
+ * Queue a request for lazy invocation of kfree_bulk()/kvfree() after a grace
  * period. Please note there are two paths are maintained, one is the main one
  * that uses kfree_bulk() interface and second one is emergency one, that is
  * used only when the main path can not be maintained temporary, due to memory
  * pressure.
  *
- * Each kfree_call_rcu() request is added to a batch. The batch will be drained
+ * Each kvfree_call_rcu() request is added to a batch. The batch will be drained
  * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch will
  * be free'd in workqueue context. This allows us to: batch requests together to
  * reduce the number of grace periods during heavy kfree_rcu() load.
  */
-void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
@@ -3142,7 +3142,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		spin_unlock(&krcp->lock);
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL_GPL(kfree_call_rcu);
+EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
 static unsigned long
 kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
-- 
2.26.0.rc2.310.g2932bb562d-goog

