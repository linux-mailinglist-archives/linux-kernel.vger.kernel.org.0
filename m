Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D62EC70097
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 15:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbfGVNKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 09:10:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39919 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbfGVNKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:10:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so17642315pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=UrNlslrN8liHzMkSr61dS9Vo6ULE756aXr3wsWluV9g=;
        b=sTWhn9PxWbhK839hc00cr7mXR3PAg7IJBOZdEQ3yWz0jcnV2L5DSAZTRCNfZ3R3d54
         S6lUKT9NOdU/eoqkabViw9sqI3eKK1TunpvowbjZMkQ3m+4my1dYN/MpifvTFguoJKxA
         JWD1MkHiP2Gh2FQF05boPObIjc3o18u4gzsxPaui+37HoJXU1rTum2aNvjhprkGHnddC
         rsELA6KESDEcSm345tA941PvgOu8ntB+1Jh/H37feV61ct7+ygRTTHnvsRyljp7q/PAq
         nv9TB8HPiWJupf7g4msnq+RXVaqFOKrcw7bYzwMzA6z3HUvhO4RP/Lt+5eWDsO075gW6
         uWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=UrNlslrN8liHzMkSr61dS9Vo6ULE756aXr3wsWluV9g=;
        b=Mo3EUUpjLrWGHQtt92rCWzQZM7iWy9Y3G0zNTQ2KFK0RoIgr3FNqXMj9zq+5mas52E
         BN/mE7A6R9o2h9dvwOitwuZHXC54V5X8jCrmQVUoQ3CBNApcA4IYZW2pho51KMb5dIhN
         LaP8QVKc/1fThIUpHQiwKNfinKNchn1KmdvTUQF4X8JcjujNh8Qu+NO1gRVXFCamOISB
         2Kl8oNmN7QPpmwHEtt79piJ4Z2Z7dZZm8lq8vnM8QVlzVmniJl9UCDNUn7V/A5ESUNrS
         3y9FXfZ4kIwmwoCJ7O23m8N9N0Lw+lEEcWcndq0i8tsmHz9Y2OjHO6p4+QJ3rin3jI0Z
         pTCQ==
X-Gm-Message-State: APjAAAWCVo0N95On6o5Bn58LJALKwnD/ME5uMELo46q41kvJAXNrIcL7
        0K7p3I+CleANsYGsqqWff4R4Ng==
X-Google-Smtp-Source: APXvYqzRcxWpErvDH9emY38XtTGLIfJLxdrGbWv/jZZGNuzN2nNOtcSfgjzeFVKvDTcKg0wIuHMY2Q==
X-Received: by 2002:a17:90a:8985:: with SMTP id v5mr76073955pjn.136.1563801009693;
        Mon, 22 Jul 2019 06:10:09 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p19sm47013192pfn.99.2019.07.22.06.10.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 06:10:09 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     axboe@kernel.dk, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     zhang.lyra@gmail.com, orsonzhai@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [RFC PATCH 1/7] blk-mq: Export blk_mq_hctx_has_pending() function
Date:   Mon, 22 Jul 2019 21:09:36 +0800
Message-Id: <94a0d20e6304b909391abd9a425c71c376cad964.1563782844.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SD/MMC host controllers can support packed command or packed request,
that means we can package several requests to host controller at one time
to improve performence. And this patch set will introduce MMC packed function
to support this feature by following patches.

To support MMC packed function, the MMC layer need to know if there are
requests are pending now in hardware queue to help to combine requests
as much as possible. If we know there are requests pending in hardware
queue, then we should not package requests to host controller immediately,
instead we should collect more requests into MMC packed queue to be packed
to host controller with packed condition.

Thus export this function for MMC packed function.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 block/blk-mq.c         |    3 ++-
 include/linux/blk-mq.h |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b038ec6..5bd4ef9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -63,12 +63,13 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
  * Check if any of the ctx, dispatch list or elevator
  * have pending work in this hardware queue.
  */
-static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
+bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
 {
 	return !list_empty_careful(&hctx->dispatch) ||
 		sbitmap_any_bit_set(&hctx->ctx_map) ||
 			blk_mq_sched_has_work(hctx);
 }
+EXPORT_SYMBOL_GPL(blk_mq_hctx_has_pending);
 
 /*
  * Mark this ctx as having pending work in this hardware queue
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 3fa1fa5..15a2b7b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -334,6 +334,7 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
 
 unsigned int blk_mq_rq_cpu(struct request *rq);
+bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx);
 
 /*
  * Driver command data is immediately after the request. So subtract request
-- 
1.7.9.5

