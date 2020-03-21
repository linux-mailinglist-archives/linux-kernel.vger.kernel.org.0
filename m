Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4307918DF3E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 10:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgCUJpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 05:45:18 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:38438 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgCUJpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 05:45:17 -0400
Received: by mail-wm1-f43.google.com with SMTP id l20so8918399wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 02:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CI7HoertAKDvDZptslfp0+rHp2j/ODCsoGqu9t32OVA=;
        b=xIzznXjBpVqlsSgITTHirE1Sy4Fs9Eq0jjeti/9RQ34hINQMBNDK45QbyL71xMp1Ga
         UdQJfcu3yepa89j8aNhVmA/ptVz0hvsnsEGrSx0LeM0tqygBQOcefDXfkCwFTIPyuIq6
         1J5OoJIF2Em+DVvFEDxdDMPbJvAYcYylVLqqo+QyHKQ1qcjfW4KpIeY+qsippp4ia7jN
         HQHq+uviEZynA1ENrrotZ0+cD6kCTNrK1hfVZecnnd0yXnlbdxfzVhbmxXtUIPSLCxma
         7utrhXJ70hzBOWNmvB0JF2mR1Daro2EzT3y2esVTTPLC/3idnISqZHMjTtVkhGNx7P1I
         Dhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CI7HoertAKDvDZptslfp0+rHp2j/ODCsoGqu9t32OVA=;
        b=b6p6cbuoqYXTUGq1B7/v7rIP1EFreu2LYOQ/9bVq1CG4kN2+7tXV4JnWP7FvKhKJwo
         FKVbXdNMGdrdVHem+r2H1L3YIJQj+MFmzK49qiVvIVxmwY6+DiWQLBPbOCRWuRU45thB
         khgEKqLcNkpm65X2ELXvS83nepoqIjiLsZl3mniuNtV5xJlYLvODfG0xsF/AO4xKjzkf
         3UQJHfuQIknMziZx7MywjGg7Rkk+LEvdfFYtdTEdQxqnJ+0HMru7tt1ZRl8V5KnlSQXH
         Pla70mI1cBhYH31jLYDuHF0aZvbZvgJRuPJWf6sXeYlCsZvcbtHCbPyYGRA7rJjoexni
         9FIg==
X-Gm-Message-State: ANhLgQ0azXDvr8k3Gb4g7kiBJ7AGC9VJ/Lh0uxQXFkVuiBEM3aSgii7F
        m/wcgauqDE1fnn/D61Wm8Ty8xg==
X-Google-Smtp-Source: ADFU+vv6bvYY4jRRrfXkVi6gsEcDn8amDvUoHr2R0oWUCp2iV/CPK3ppMwEW4FRSSww4KLKpWABAnQ==
X-Received: by 2002:a1c:f607:: with SMTP id w7mr911618wmc.162.1584783914934;
        Sat, 21 Mar 2020 02:45:14 -0700 (PDT)
Received: from localhost.localdomain ([84.33.129.193])
        by smtp.gmail.com with ESMTPSA id z203sm5396378wmg.12.2020.03.21.02.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 02:45:14 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        rasibley@redhat.com, vkabatov@redhat.com, xzhou@redhat.com,
        jstancek@redhat.com, Paolo Valente <paolo.valente@linaro.org>,
        cki-project@redhat.com
Subject: [PATCH BUGFIX 2/4] block, bfq: turn put_queue into release_process_ref in __bfq_bic_change_cgroup
Date:   Sat, 21 Mar 2020 10:45:19 +0100
Message-Id: <20200321094521.85986-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200321094521.85986-1-paolo.valente@linaro.org>
References: <20200321094521.85986-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bfq_put_queue() may be invoked in __bfq_bic_change_cgroup(). The
goal of this put is to release a process reference to a bfq_queue. But
process-reference releases may trigger also some extra operation, and,
to this goal, are handled through bfq_release_process_ref(). So, turn
the invocation of bfq_put_queue() into an invocation of
bfq_release_process_ref().

Tested-by: cki-project@redhat.com
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c  | 5 +----
 block/bfq-iosched.c | 2 --
 block/bfq-iosched.h | 1 +
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 9d963ed518d1..72c6151ace96 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -714,10 +714,7 @@ static struct bfq_group *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
 
 		if (entity->sched_data != &bfqg->sched_data) {
 			bic_set_bfqq(bic, NULL, 0);
-			bfq_log_bfqq(bfqd, async_bfqq,
-				     "bic_change_group: %p %d",
-				     async_bfqq, async_bfqq->ref);
-			bfq_put_queue(async_bfqq);
+			bfq_release_process_ref(bfqd, async_bfqq);
 		}
 	}
 
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 8c436abfaf14..d9c1899cf05b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2716,8 +2716,6 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 	}
 }
 
-
-static
 void bfq_release_process_ref(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 {
 	/*
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index d1233af9c684..cd224aaf9f52 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -955,6 +955,7 @@ void bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		     bool compensate, enum bfqq_expiration reason);
 void bfq_put_queue(struct bfq_queue *bfqq);
 void bfq_end_wr_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg);
+void bfq_release_process_ref(struct bfq_data *bfqd, struct bfq_queue *bfqq);
 void bfq_schedule_dispatch(struct bfq_data *bfqd);
 void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg);
 
-- 
2.20.1

