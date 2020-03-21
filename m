Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7C518DF40
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 10:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgCUJpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 05:45:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55881 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgCUJpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 05:45:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id 6so8937492wmi.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 02:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cdw3Jk/AH3aPTxIWA1ECRCyWdOQJNXNVF8wpPDgyPN8=;
        b=H7CXwvgvlikXWm2OU7FFaknqW7yU3usmnqwnHiLMYZ2bKFnZqm2G+S9YMSkC5cxHtG
         sD6WprWxh/CLduwjgZA0zewGWw13VLmbfS92PgwgjNCXvZYxydf4NglpP4WQEr1CQnL5
         y0V2579wllnZUQU0raaeqU7DWd8QDaQL8MjqGQ3iM+pItsMsLCmzLJt6oxDuYo7HO/FT
         Qxz9jH9PDC++VDsJ5jvcy2YPv0x+0eXJkyNOA+p/WEMMRHY+wWa04mf/QyRMIv1ZikbS
         UuZwKEKB93S961rs+nyhzHmOXSLl6jm5zP7amwJWuOUOeLJOyMXFn7fQK5lg2/Eg16NR
         tixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cdw3Jk/AH3aPTxIWA1ECRCyWdOQJNXNVF8wpPDgyPN8=;
        b=ju/zsU7kOSsvq3aTOLEnuzZgpjZUcMYCyPyidlKnZ4Ka/pthCLwMBJSl3g36LONMeg
         pV3CW3b9hZEUSAREV6esflnjvIgYmdpW/EciP6F/0JqUhpM6ot5jCA5R+iMOOnivFiPL
         zV2+8rOkigH3INEGLpwviznzWYpB7aQFz2v7FoOpczCglAdV9vLjU/ma5phDI+rSk26D
         jlKCHDzGWzIGrD6TOvujcUEyzsELilCfJVVcpcGpdXLyOGKCCG1r933y2oczhFo6fpyz
         Hy+CwtmOBEI7Mne9JiOSxg8gREnPSntiVMQEKOE0X3oBQRhDI0f40dXW3hYvc9FeBtcM
         M6TQ==
X-Gm-Message-State: ANhLgQ18rvDOckqgxHYEhBjN9HvcoTc+w7Outv4u+zvOtorleZkOd8R5
        hNoqtNmXOchs5HzmmKtdQfJPzprNoV8=
X-Google-Smtp-Source: ADFU+vtpSs1hWZbNJ6MMyxkZ/2yT/xobzl37JvigJkVu2u0PIYUyOF4QS/0H3i4yXUZz3lTYHL1XWA==
X-Received: by 2002:a1c:3d6:: with SMTP id 205mr16222392wmd.155.1584783916449;
        Sat, 21 Mar 2020 02:45:16 -0700 (PDT)
Received: from localhost.localdomain ([84.33.129.193])
        by smtp.gmail.com with ESMTPSA id z203sm5396378wmg.12.2020.03.21.02.45.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 02:45:15 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        rasibley@redhat.com, vkabatov@redhat.com, xzhou@redhat.com,
        jstancek@redhat.com, Paolo Valente <paolo.valente@linaro.org>,
        cki-project@redhat.com
Subject: [PATCH BUGFIX 3/4] block, bfq: make reparent_leaf_entity actually work only on leaf entities
Date:   Sat, 21 Mar 2020 10:45:20 +0100
Message-Id: <20200321094521.85986-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200321094521.85986-1-paolo.valente@linaro.org>
References: <20200321094521.85986-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bfq_reparent_leaf_entity() reparents the input leaf entity (a leaf
entity represents just a bfq_queue in an entity tree). Yet, the input
entity is guaranteed to always be a leaf entity only in two-level
entity trees. In this respect, because of the error fixed by
commit 14afc5936197 ("block, bfq: fix overwrite of bfq_group pointer
in bfq_find_set_group()"), all (wrongly collapsed) entity trees happened
to actually have only two levels. After the latter commit, this does not
hold any longer.

This commit fixes this problem by modifying
bfq_reparent_leaf_entity(), so that it searches an active leaf entity
down the path that stems from the input entity. Such a leaf entity is
guaranteed to exist when bfq_reparent_leaf_entity() is invoked.

Tested-by: cki-project@redhat.com
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c | 48 ++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 72c6151ace96..efb89db7ba24 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -815,39 +815,53 @@ static void bfq_flush_idle_tree(struct bfq_service_tree *st)
 /**
  * bfq_reparent_leaf_entity - move leaf entity to the root_group.
  * @bfqd: the device data structure with the root group.
- * @entity: the entity to move.
+ * @entity: the entity to move, if entity is a leaf; or the parent entity
+ *	    of an active leaf entity to move, if entity is not a leaf.
  */
 static void bfq_reparent_leaf_entity(struct bfq_data *bfqd,
-				     struct bfq_entity *entity)
+				     struct bfq_entity *entity,
+				     int ioprio_class)
 {
-	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+	struct bfq_queue *bfqq;
+	struct bfq_entity *child_entity = entity;
+
+	while (child_entity->my_sched_data) { /* leaf not reached yet */
+		struct bfq_sched_data *child_sd = child_entity->my_sched_data;
+		struct bfq_service_tree *child_st = child_sd->service_tree +
+			ioprio_class;
+		struct rb_root *child_active = &child_st->active;
 
+		child_entity = bfq_entity_of(rb_first(child_active));
+
+		if (!child_entity)
+			child_entity = child_sd->in_service_entity;
+	}
+
+	bfqq = bfq_entity_to_bfqq(child_entity);
 	bfq_bfqq_move(bfqd, bfqq, bfqd->root_group);
 }
 
 /**
- * bfq_reparent_active_entities - move to the root group all active
- *                                entities.
+ * bfq_reparent_active_queues - move to the root group all active queues.
  * @bfqd: the device data structure with the root group.
  * @bfqg: the group to move from.
- * @st: the service tree with the entities.
+ * @st: the service tree to start the search from.
  */
-static void bfq_reparent_active_entities(struct bfq_data *bfqd,
-					 struct bfq_group *bfqg,
-					 struct bfq_service_tree *st)
+static void bfq_reparent_active_queues(struct bfq_data *bfqd,
+				       struct bfq_group *bfqg,
+				       struct bfq_service_tree *st,
+				       int ioprio_class)
 {
 	struct rb_root *active = &st->active;
-	struct bfq_entity *entity = NULL;
-
-	if (!RB_EMPTY_ROOT(&st->active))
-		entity = bfq_entity_of(rb_first(active));
+	struct bfq_entity *entity;
 
-	for (; entity ; entity = bfq_entity_of(rb_first(active)))
-		bfq_reparent_leaf_entity(bfqd, entity);
+	while ((entity = bfq_entity_of(rb_first(active))))
+		bfq_reparent_leaf_entity(bfqd, entity, ioprio_class);
 
 	if (bfqg->sched_data.in_service_entity)
 		bfq_reparent_leaf_entity(bfqd,
-			bfqg->sched_data.in_service_entity);
+					 bfqg->sched_data.in_service_entity,
+					 ioprio_class);
 }
 
 /**
@@ -898,7 +912,7 @@ static void bfq_pd_offline(struct blkg_policy_data *pd)
 		 * There is no need to put the sync queues, as the
 		 * scheduler has taken no reference.
 		 */
-		bfq_reparent_active_entities(bfqd, bfqg, st);
+		bfq_reparent_active_queues(bfqd, bfqg, st, i);
 	}
 
 	__bfq_deactivate_entity(entity, false);
-- 
2.20.1

