Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F269C51B88
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 21:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbfFXTlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 15:41:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35393 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730404AbfFXTlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:41:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id c6so535892wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jFdPqD3TBf44a7c2W86e+D5nf2bSFpU6DQYW7s1Xtyc=;
        b=jUz3pIK7GFLYzyZZC1NLM+qmBubKD0cR/ksXweLYxKtD6meQ2jRbJtvdVHenpdSe5h
         SxEErNwcmnsz62OBV3TPzqQd+x0zxqhF1UFlCDFLJPFXmVMshLuI7zYRWEPue7bSyXGg
         CC2Zl+gZjmxDeP3gVJMd/Xfc22sMsFvft1DcMuJluj3TVPmmq/EN3xDeN8ZbW8i7gUZz
         IkcWUe82yllfLovacQzbIin5axowhDCoF5fyMhSfXUVg+88PQsEnavEGi92WVc/Y4kaD
         5SlZSuExJuMXfFqLR+xYOqqUB/wcKjUdsoAoHU0pYRkqmXUgXg1ZCggRbyTgTmGKrri4
         5f/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jFdPqD3TBf44a7c2W86e+D5nf2bSFpU6DQYW7s1Xtyc=;
        b=Ww3Cn2240JxYaEiXHnypZjlHm8reDw+G6F1HU/yUsi4oq01MnmBvCCeo3WLCWHd9yR
         0waNyQ7zDPyMw3jXRAH20plHHbxw+PMPCR1m7IL7MYUco5OZsgAdK8TOC7Fd5fw5wEEJ
         suf1djzxfA+6hVJXN2aKow/2bkxGRUJceI5mWp39N3U/zO2i+Gm1JG13/n1jb3PQKe74
         3DyGIRxn9LCwwTsgICTbkhiQSpXIByoEisYRZzcXCofoGPLHlC6smy4v9uNn2BnsBPlh
         fefwSDwArPAynVmPHHu7jeZv2WPHSU7il61qUqXHTYzzthS1+z5x9wihjiY4CPV5/hFD
         sBgw==
X-Gm-Message-State: APjAAAWR8SPYl88+oUGukx8DqdybLdbDefgQLo5TzPvbZZ5Y8B1Ls3eH
        ckorNySo+WkS7IBh1N+Xv3cGFg==
X-Google-Smtp-Source: APXvYqw5BDG/KxnETCwgHcWNNFORB2nJcwBnAbM0CYqBtkprJrxohc9+YIkIZCm2UUlrcx7NuoUwbw==
X-Received: by 2002:a7b:cb84:: with SMTP id m4mr18108832wmi.50.1561405269151;
        Mon, 24 Jun 2019 12:41:09 -0700 (PDT)
Received: from localhost.localdomain (146-241-101-27.dyn.eolo.it. [146.241.101.27])
        by smtp.gmail.com with ESMTPSA id q25sm17615395wrc.68.2019.06.24.12.41.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 12:41:08 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        bottura.nicola95@gmail.com, srivatsa@csail.mit.edu,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 3/7] block, bfq: update base request service times when possible
Date:   Mon, 24 Jun 2019 21:40:38 +0200
Message-Id: <20190624194042.38747-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624194042.38747-1-paolo.valente@linaro.org>
References: <20190624194042.38747-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I/O injection gets reduced if it increases the request service times
of the victim queue beyond a certain threshold.  The threshold, in its
turn, is computed as a function of the base service time enjoyed by
the queue when it undergoes no injection.

As a consequence, for injection to work properly, the above base value
has to be accurate. In this respect, such a value may vary over
time. For example, it varies if the size or the spatial locality of
the I/O requests in the queue change. It is then important to update
this value whenever possible. This commit performs this update.

Tested-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 05041f84b8da..62442083b147 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5496,7 +5496,18 @@ static void bfq_update_inject_limit(struct bfq_data *bfqd,
 		 * start trying injection.
 		 */
 		bfqq->inject_limit = max_t(unsigned int, 1, old_limit);
-	}
+	} else if (!bfqd->rqs_injected && bfqd->rq_in_driver == 1)
+		/*
+		 * No I/O injected and no request still in service in
+		 * the drive: these are the exact conditions for
+		 * computing the base value of the total service time
+		 * for bfqq. So let's update this value, because it is
+		 * rather variable. For example, it varies if the size
+		 * or the spatial locality of the I/O requests in bfqq
+		 * change.
+		 */
+		bfqq->last_serv_time_ns = tot_time_ns;
+
 
 	/* update complete, not waiting for any request completion any longer */
 	bfqd->waited_rq = NULL;
-- 
2.20.1

