Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD6CE14EA08
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 10:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgAaJZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 04:25:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34535 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgAaJZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 04:25:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id s144so8344248wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 01:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uWgUp93q0TxBVqmJmgne8WprxYrbN7oKCMa4FCVu+FE=;
        b=cZvFOVTG2wAkUzmD+l5ISrTahaofiW5nU3Lah/OikxnKfbOzrSdIhM3GhA0jVmgEIs
         w/9AKwzF702bVUW1oFkXq92YlJNZbmPcEaMJXw2ESM1hJqBiHGCq9I+D4io7LCrDa+76
         Uvm63wGfl/zTuhQqEoOvDoJYr2MsHdZEK6YMyEB+4RvG22VRKJYW2KUnRvwCfkvcyGFL
         jqwJA07ybsiAVFg5SLggI1sFD1cWweG4rZf9yW6SlokSyB89pO7uIZF0f7c+zkJML9tw
         Adrsozr0AqOYY/t6qomr9CyC6nw8xEgshG9yVUeSgHH0AeRHmwJwj3VqQ4JZ8kU1YthK
         a3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uWgUp93q0TxBVqmJmgne8WprxYrbN7oKCMa4FCVu+FE=;
        b=s2yOYmT66y82H9ZPl8rRLxNrtIEuNzcAU3xTW56kI46K8SDjl9fho+ySe5wIIDNvJA
         ReoBtp7YgNTrEpXpnb4vFYqx3Hpe+Ms3g4wYpvxcPTixcYwWRYJUnYYJeq9RMIuXPUnU
         WVSdl35ilc5wR3wkuaGE4CmGSkwxNhbQZfjSOsY39aHTPQ1PODFFnacv/FcD41IL5P81
         fYZEwuWq1ptbLHzfBYIrMig8TZhgw/8co/6C3t7YBJXg6K2smEFXA/oI8CawxsafPE3s
         EeEmXA+hepTRtSdYQWMCA/xHqamopJn8jOkX63JG3PbXpjVQMVKtQZN55xwHB8JH9MXJ
         V9yg==
X-Gm-Message-State: APjAAAWHcPqRM5RXkPYeU/+bovRHdR7BtzFq+pFFmZTPf6XJrw+ibQXp
        1pNQlOLGfkxeS/2rdQAZz1z+Xw==
X-Google-Smtp-Source: APXvYqxEJphFjQzJzYlTW6+ZjuBCQ4jxe8AA1Oejq3lY8Mp34gOMX+FS3cy7WyrtheyMRpt2O7Oiow==
X-Received: by 2002:a7b:c7c9:: with SMTP id z9mr11423354wmk.175.1580462701852;
        Fri, 31 Jan 2020 01:25:01 -0800 (PST)
Received: from localhost.localdomain (88-147-73-186.dyn.eolo.it. [88.147.73.186])
        by smtp.gmail.com with ESMTPSA id 16sm10144364wmi.0.2020.01.31.01.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 01:25:01 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 5/6] block, bfq: get a ref to a group when adding it to a service tree
Date:   Fri, 31 Jan 2020 10:24:08 +0100
Message-Id: <20200131092409.10867-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200131092409.10867-1-paolo.valente@linaro.org>
References: <20200131092409.10867-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BFQ schedules generic entities, which may represent either bfq_queues
or groups of bfq_queues. When an entity is inserted into a service
tree, a reference must be taken, to make sure that the entity does not
disappear while still referred in the tree. Unfortunately, such a
reference is mistakenly taken only if the entity represents a
bfq_queue. This commit takes a reference also in case the entity
represents a group.

Tested-by: Chris Evich <cevich@redhat.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c  |  2 +-
 block/bfq-iosched.h |  1 +
 block/bfq-wf2q.c    | 16 +++++++++++++++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index c818c64766e5..f85b25fd06f2 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -332,7 +332,7 @@ static void bfqg_put(struct bfq_group *bfqg)
 		kfree(bfqg);
 }
 
-static void bfqg_and_blkg_get(struct bfq_group *bfqg)
+void bfqg_and_blkg_get(struct bfq_group *bfqg)
 {
 	/* see comments in bfq_bic_update_cgroup for why refcounting bfqg */
 	bfqg_get(bfqg);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index f1cb89def7f8..b9627ec7007b 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -984,6 +984,7 @@ struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
 struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg);
 struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node);
+void bfqg_and_blkg_get(struct bfq_group *bfqg);
 void bfqg_and_blkg_put(struct bfq_group *bfqg);
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 26776bdbdf36..ef06e0d34b5b 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -533,7 +533,13 @@ static void bfq_get_entity(struct bfq_entity *entity)
 		bfqq->ref++;
 		bfq_log_bfqq(bfqq->bfqd, bfqq, "get_entity: %p %d",
 			     bfqq, bfqq->ref);
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	} else
+		bfqg_and_blkg_get(container_of(entity, struct bfq_group,
+					       entity));
+#else
 	}
+#endif
 }
 
 /**
@@ -647,8 +653,16 @@ static void bfq_forget_entity(struct bfq_service_tree *st,
 
 	entity->on_st_or_in_serv = false;
 	st->wsum -= entity->weight;
-	if (bfqq && !is_in_service)
+	if (is_in_service)
+		return;
+
+	if (bfqq)
 		bfq_put_queue(bfqq);
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	else
+		bfqg_and_blkg_put(container_of(entity, struct bfq_group,
+					       entity));
+#endif
 }
 
 /**
-- 
2.20.1

