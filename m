Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 794C69D6F7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 21:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732855AbfHZTqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 15:46:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44324 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732484AbfHZTqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 15:46:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so11201066pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 12:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=to1oeNA++JDNSoQZ9+DGa/c6NmOGbTyxF1scobzI6zQ=;
        b=vy0jQd6ibfmNAqxqvIGEsgIqX8AWCCtFxStWZJcseWo1cqp/4a7MfZnKyIqzuaGZ1k
         ayaqhNJzN7fzAy0ym5mFYWWNIyM8oDwrzZ0BXGss/dz37lVhtL5VPjKvRu2HBP4IUDkr
         kHzxYmU1B62NgZI6Kd5eSZk5ipg1afqrdau02VSA+EwC5U+Uw1YhGBN46qWgUGLc1mO0
         6pgYzCjRkSOjtrhWe8Nfl99nWhtllWgG5VKo2yXy0YO5/nrwIM1sVdX8hpSJX/oE65ax
         UFWurs+ypKJnLH/rb5nuVWTAaSR6LjdvPshy0uBw/2rNsvpgIYffvI/nMKgVO+ZQFXzH
         6CQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=to1oeNA++JDNSoQZ9+DGa/c6NmOGbTyxF1scobzI6zQ=;
        b=Jl46iAip9pevW7Sb6z5+j9VDU7HFm7F4i/Khvflm48MqAGEREbdPNq7ES19npOp0xF
         t03KnEtldf319SkQbwjjYjswTYf4DgiA6+gygvlqEUmpsxq7dWpS8kYPkhPxH37eQu+T
         UoOM88N5O8wDFUAyWOmO0wFETMB5nlgUc8qsBo/SEHOJEpwQEVIZ2LWxFWpw74LeTEfa
         /jvmPfJVCr3iN4Q/uiWRmHRj/Y51e26SDGKSyNdlh4g7z/IuPAV/2tHrgO3cU4RY9YUF
         xPFkFojDJ2RuAA0aZnYP8RInx44SvxAMwHVyp8yXT+tw/VQaRCBJuwg2FQ3ySP7ZKr73
         5OvA==
X-Gm-Message-State: APjAAAWwh39eEpDhLgaC9SIkir2GlCUCLKbLn9o0n9OdxRDEVCnXWIw1
        5PEMawIyw/CjtKbyJGA++x3wFw==
X-Google-Smtp-Source: APXvYqyWitdKUoiHYjEAp6ufI6puptwr+/IHwRzNNQMvnMMuB9gnLsh5IW5tBtZxfpFaaNbaEC8eoQ==
X-Received: by 2002:a65:4507:: with SMTP id n7mr17258859pgq.86.1566848769060;
        Mon, 26 Aug 2019 12:46:09 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c35sm13214789pgl.72.2019.08.26.12.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 12:46:08 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     suzuki.poulose@arm.com, leo.yan@linaro.org, mike.leach@arm.com
Cc:     yabinc@google.com, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] coresight: tmc-etr: Decouple buffer sync and barrier packet insertion
Date:   Mon, 26 Aug 2019 13:46:04 -0600
Message-Id: <20190826194605.3791-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826194605.3791-1-mathieu.poirier@linaro.org>
References: <20190826194605.3791-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If less space is available in the perf ring buffer than the ETR buffer,
barrier packets inserted in the trace stream by tmc_sync_etr_buf() are
skipped over when the head of the buffer is moved forward, resulting in
traces that can't be decoded.

This patch decouples the process of syncing ETR buffers and the addition
of barrier packets in order to perform the latter once the offset in the
trace buffer has been properly computed.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-tmc-etr.c    | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 4f000a03152e..bae47272de98 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -946,10 +946,6 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
 	WARN_ON(!etr_buf->ops || !etr_buf->ops->sync);
 
 	etr_buf->ops->sync(etr_buf, rrp, rwp);
-
-	/* Insert barrier packets at the beginning, if there was an overflow */
-	if (etr_buf->full)
-		tmc_etr_buf_insert_barrier_packet(etr_buf, etr_buf->offset);
 }
 
 static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
@@ -1086,6 +1082,13 @@ static void tmc_etr_sync_sysfs_buf(struct tmc_drvdata *drvdata)
 		drvdata->sysfs_buf = NULL;
 	} else {
 		tmc_sync_etr_buf(drvdata);
+		/*
+		 * Insert barrier packets at the beginning, if there was
+		 * an overflow.
+		 */
+		if (etr_buf->full)
+			tmc_etr_buf_insert_barrier_packet(etr_buf,
+							  etr_buf->offset);
 	}
 }
 
@@ -1502,11 +1505,16 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 	CS_LOCK(drvdata->base);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
+	lost = etr_buf->full;
 	size = etr_buf->len;
 	if (!etr_perf->snapshot && size > handle->size) {
 		size = handle->size;
 		lost = true;
 	}
+
+	/* Insert barrier packets at the beginning, if there was an overflow */
+	if (lost)
+		tmc_etr_buf_insert_barrier_packet(etr_buf, etr_buf->offset);
 	tmc_etr_sync_perf_buffer(etr_perf, size);
 
 	/*
@@ -1517,8 +1525,6 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 	 */
 	if (etr_perf->snapshot)
 		handle->head += size;
-
-	lost |= etr_buf->full;
 out:
 	/*
 	 * Don't set the TRUNCATED flag in snapshot mode because 1) the
-- 
2.17.1

