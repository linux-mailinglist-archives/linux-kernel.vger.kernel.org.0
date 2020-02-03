Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08002150472
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 11:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgBCKlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 05:41:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52686 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbgBCKlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:41:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so15256620wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 02:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rzt4yAe3s0HBIE04/HczDDOIa4+f9r0CEH+uqzj+BDc=;
        b=vJ9AQJrI1BNhzha7OjhKAOLAwHr7Z+z7FaHE/TXavIB7TfKhs9SQePDc2R8bFtgs5t
         EVbMjFiIuIUfZfkHbLplmpieXt33rdSbtnVu2O5C1fizzkCT2brbn8/q6LwbVoW9e5wM
         imQ6Iwpzi1DfRuI0WZeC64+tvO8CUs2ymRxKzvpcSPOg8sPQb0PXKDg5kIRNfqVaGVF/
         vw/nf6lnJ/5Ct4JrxcB4ocm+V8w1/Bp7p5AFAOZlMFFJ9yc+Y0TYrpfSalLil7S35uEl
         aQ0L2yQ+h9FEpQWcgR2Avz0qbvo+YbTk303y2qWju+6m8ioFjRclKCzJTXqUywsfzasl
         ci/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rzt4yAe3s0HBIE04/HczDDOIa4+f9r0CEH+uqzj+BDc=;
        b=QpFJeURMrJW+qznPHK+4L/g9418NIRnUB2hyL9THfumEI5Z8QvEZXP3ejHkgAWVPGy
         68NbedE2MVByj3HKibZ/jnMsEOiVW3UFnf75JHazPydE42oiwRQf344dHBHGwW9h9xKx
         es505XfvRWKEoBEEdvZ7vlzKM+i7D4yncjyO6H5adfV5EHojnFJ5aQnfqe6XvE5KPET7
         un+adXnBCJq5H2jYewnpkIlvlBgclXLnzT3omK7gbRU+NzWL6sY2VPCqEzyu2fi4e0X4
         2joT2kUKXWBY0+Wffjul0wb74RTEOCdJoIHVBN+0IzGM9xluJE2bwJA1aNLTvLTyzwLF
         npXA==
X-Gm-Message-State: APjAAAXfbg7ZNLz/ZGNgQ5iHnrgGBWTgLB93VSz3ZNybADn7VYOmIhC9
        k6XXzOQwen9uq8iDvF7iMnhj5Q==
X-Google-Smtp-Source: APXvYqw515wJAJ5URUt4G4dWfEtITv3CNgLhWcem3hZCnhYkTKKDKFIe/C6Dkjwu362xwj3FjOsMkA==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr28134873wmi.21.1580726482645;
        Mon, 03 Feb 2020 02:41:22 -0800 (PST)
Received: from localhost.localdomain (84-33-65-46.dyn.eolo.it. [84.33.65.46])
        by smtp.gmail.com with ESMTPSA id i204sm23798930wma.44.2020.02.03.02.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 02:41:22 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX V2 6/7] block, bfq: get a ref to a group when adding it to a service tree
Date:   Mon,  3 Feb 2020 11:40:59 +0100
Message-Id: <20200203104100.16965-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203104100.16965-1-paolo.valente@linaro.org>
References: <20200203104100.16965-1-paolo.valente@linaro.org>
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
 block/bfq-wf2q.c    | 12 ++++++++++--
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index cae488b58049..09b69a3ed490 100644
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
index 2c7cec737b2a..d1233af9c684 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -985,6 +985,7 @@ struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
 struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg);
 struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node);
+void bfqg_and_blkg_get(struct bfq_group *bfqg);
 void bfqg_and_blkg_put(struct bfq_group *bfqg);
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 26776bdbdf36..eb0e2a6daabe 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -533,7 +533,9 @@ static void bfq_get_entity(struct bfq_entity *entity)
 		bfqq->ref++;
 		bfq_log_bfqq(bfqq->bfqd, bfqq, "get_entity: %p %d",
 			     bfqq, bfqq->ref);
-	}
+	} else
+		bfqg_and_blkg_get(container_of(entity, struct bfq_group,
+					       entity));
 }
 
 /**
@@ -647,8 +649,14 @@ static void bfq_forget_entity(struct bfq_service_tree *st,
 
 	entity->on_st_or_in_serv = false;
 	st->wsum -= entity->weight;
-	if (bfqq && !is_in_service)
+	if (is_in_service)
+		return;
+
+	if (bfqq)
 		bfq_put_queue(bfqq);
+	else
+		bfqg_and_blkg_put(container_of(entity, struct bfq_group,
+					       entity));
 }
 
 /**
-- 
2.20.1

