Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB9B71438B2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 09:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgAUIs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 03:48:59 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:55675 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbgAUIs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:48:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0ToHY-kd_1579596536;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHY-kd_1579596536)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:48:57 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block/bfq: remove unused bfq_class_rt which never used
Date:   Tue, 21 Jan 2020 16:48:54 +0800
Message-Id: <1579596534-257642-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro is never used after introduced from commit aee69d78dec0
("block, bfq: introduce the BFQ-v0 I/O scheduler as an extra scheduler")

Better to remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Paolo Valente <paolo.valente@linaro.org> 
Cc: Jens Axboe <axboe@kernel.dk> 
Cc: linux-block@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 block/bfq-iosched.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ad4af4aaf2ce..4686b68b48b4 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -427,7 +427,6 @@ void bfq_schedule_dispatch(struct bfq_data *bfqd)
 }
 
 #define bfq_class_idle(bfqq)	((bfqq)->ioprio_class == IOPRIO_CLASS_IDLE)
-#define bfq_class_rt(bfqq)	((bfqq)->ioprio_class == IOPRIO_CLASS_RT)
 
 #define bfq_sample_valid(samples)	((samples) > 80)
 
-- 
1.8.3.1

