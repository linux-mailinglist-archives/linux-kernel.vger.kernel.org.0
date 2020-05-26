Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83797199739
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 15:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbgCaNQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 09:16:39 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:41905 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730703AbgCaNQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:16:38 -0400
Received: by mail-qv1-f67.google.com with SMTP id t4so6603588qvz.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 06:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lWOY1a83oyzd8Wyzxobl7iyPgPSxUcv8H4rfgpi9Go0=;
        b=w9G5xdSJi2pwxLkw+UUYa9uD0cxKepK7FyN8BvxBNr7Qf28I7LNKazNm+grZ85uOZ3
         YUp0H2DrxVoI8h+nOVinbooeJqV2zQ511twVls7fYGH+dwXNRxXxr3T3VCoRZ5/DGzhD
         eyZwCzRDkNzu/rI9nxQFLCQ6LvJiGX5snuiD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lWOY1a83oyzd8Wyzxobl7iyPgPSxUcv8H4rfgpi9Go0=;
        b=d5wz7cHo3YljJpLZRhAUOdVOBeeYY2dH8r5SK1Ook2b0t6TmBLlVrQ+7MTbkt9gh60
         vYqS1fWH/Lmt5xrNlyKWg/IXLgGSj3XnggZUrjo8I3MC/2jtNhCuzEu3CZS8KNlIv7LP
         GE3dcX52IxukTUSugsdCT96o5XTwTWcSPg4M1o4p9a6JOxADTDT9JhW66h+p7k+L8kw8
         F2a1CaHkMphUeM6QkmBLoyhmIgPABzNvQy/GPyqR/GbPuMc5QYVbM5gi0CKvA+0Nrhad
         +8xKYcO07hi/2rweSnuVw711jiTRUsLWUopMG78d5aJq9UR6dtx+9bQmHWzCEZeyAb20
         kQMw==
X-Gm-Message-State: ANhLgQ3aimPOcQ3c285tFngWg7/6iiO6fpCguYTbbFg7YM6o9xQZbezg
        4AVvm55oOPFwgwZLLMOcU68lUlQWXok=
X-Google-Smtp-Source: ADFU+vtXVj0qnZ925oHCMNMkIOnLjNT9wF24VWwCVSa51Qddhb1QgyuPqNP67rntZT+wlEmt8BzhpQ==
X-Received: by 2002:a0c:f7d0:: with SMTP id f16mr16609830qvo.206.1585660597163;
        Tue, 31 Mar 2020 06:16:37 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l16sm13731476qtc.73.2020.03.31.06.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 06:16:36 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-mm@kvack.org, rcu@vger.kernel.org, willy@infradead.org,
        peterz@infradead.org, neilb@suse.com, vbabka@suse.cz,
        mgorman@suse.de, Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free memory pattern
Date:   Tue, 31 Mar 2020 09:16:28 -0400
Message-Id: <20200331131628.153118-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kfree_rcu() headless implementation (where the caller need not pass
an rcu_head, but rather directly pass a pointer to an object), we have
a fall-back where we allocate a rcu_head wrapper for the caller (not the
common case). This brings the pattern of needing to allocate some memory
to free some memory.  Currently we use GFP_ATOMIC flag to try harder for
this allocation, however the GFP_MEMALLOC flag is more tailored to this
pattern. We need to try harder not only during atomic context, but also
during non-atomic context anyway. So use the GFP_MEMALLOC flag instead.

Also remove the __GFP_NOWARN flag simply because although we do have a
synchronize_rcu() fallback for absolutely worst case, we still would
like to not enter that path and atleast trigger a warning to the user.

Cc: linux-mm@kvack.org
Cc: rcu@vger.kernel.org
Cc: willy@infradead.org
Cc: peterz@infradead.org
Cc: neilb@suse.com
Cc: vbabka@suse.cz
Cc: mgorman@suse.de
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---

This patch is based on the (not yet upstream) code in:
git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (branch rcu/kfree)

It is a follow-up to the posted series:
https://lore.kernel.org/lkml/20200330023248.164994-1-joel@joelfernandes.org/


 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4be763355c9fb..965deefffdd58 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3149,7 +3149,7 @@ static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
 
 	if (!ptr)
 		ptr = kmalloc(sizeof(unsigned long *) +
-				sizeof(struct rcu_head), GFP_ATOMIC | __GFP_NOWARN);
+				sizeof(struct rcu_head), GFP_MEMALLOC);
 
 	if (!ptr)
 		return NULL;
-- 
2.26.0.rc2.310.g2932bb562d-goog
