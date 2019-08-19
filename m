Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 511E8927D1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 17:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfHSPCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 11:02:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45252 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfHSPCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:02:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id w26so1311320pfq.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 08:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+9CFzHn8s+laxI8BbiaNVGIUIea83s76+v8r3smRCVQ=;
        b=IIWESImL05HMdmUWCk7CdXrrVK8p5KTTQdpU+vD0tyj6k4l5CVrh7/SOYo0/Nh+qgE
         fb/MR66i9vge+5vwNE6dzWU9Xw/R3JCtnaV+N351JYa8E6+N5+Zd+g7zhq/JYrpy+ZMM
         29J2lx5q6HOXKXBvJVA+P3JdMJrF+Jw+NEhIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+9CFzHn8s+laxI8BbiaNVGIUIea83s76+v8r3smRCVQ=;
        b=CbHbc9+31eyjgf8oXHX37jAgmvzlr4H3BMhM2Au7a5M5CtmkOEj0jDvmg1WktyEGnX
         /b5lpAgK+H7yMgd4A3S2iWsGpVC2m2NNsnNlwogO/Rhy9KJC5ECsJHBFnnfLfnoLG4zQ
         oLn50tziEGuA2lttuqg2zni6WHoyo8QdMEea6vmfKhzHXQHI9NfVwfIkuTtjH38p4m6/
         Y9qCSuv1b0N1B6AJbiwktnqn8+jBQKZa4N+EDY3Tk4eFtCRPwiKHgfGscVKVb+72xej8
         pGeYUuHbBWbgq44l4GfDivOG3g3dRtc/iWiPiCsYzheCTeGRP7pEh/EzRI3YAZpzs8V6
         Ec7A==
X-Gm-Message-State: APjAAAVhh7qlNZrp5yV1f+vVEtSJKT8MbRE29DDGaDfue0Nm17FQV9Bt
        RQuJ/uwmjshqiNwp6Xl6ccVvNw==
X-Google-Smtp-Source: APXvYqzs2lOTNxW35ufSm0/m7vXPfoTFMAUBPDgN2Ry7bYC+9vBffiCW4vSFFWlMZJF4Wsf0xiGRKw==
X-Received: by 2002:a63:c03:: with SMTP id b3mr20765485pgl.23.1566226966877;
        Mon, 19 Aug 2019 08:02:46 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w2sm22773353pjr.27.2019.08.19.08.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 08:02:46 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        linux-crypto@vger.kernel.org, Matt Mackall <mpm@selenic.com>,
        Keerthy <j-keerthy@ti.com>
Subject: [PATCH] random: Support freezable kthreads in add_hwgenerator_randomness()
Date:   Mon, 19 Aug 2019 08:02:45 -0700
Message-Id: <20190819150245.176587-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kthread calling this function is freezable after commit 03a3bb7ae631
("hwrng: core - Freeze khwrng thread during suspend") is applied.
Unfortunately, this function uses wait_event_interruptible() but doesn't
check for the kthread being woken up by the fake freezer signal. When a
user suspends the system, this kthread will wake up and if it fails the
entropy size check it will immediately go back to sleep and not go into
the freezer. Eventually, suspend will fail because the task never froze
and a warning message like this may appear:

 PM: suspend entry (deep)
 Filesystems sync: 0.000 seconds
 Freezing user space processes ... (elapsed 0.001 seconds) done.
 OOM killer disabled.
 Freezing remaining freezable tasks ...
 Freezing of tasks failed after 20.003 seconds (1 tasks refusing to freeze, wq_busy=0):
 hwrng           R  running task        0   289      2 0x00000020
 [<c08c64c4>] (__schedule) from [<c08c6a10>] (schedule+0x3c/0xc0)
 [<c08c6a10>] (schedule) from [<c05dbd8c>] (add_hwgenerator_randomness+0xb0/0x100)
 [<c05dbd8c>] (add_hwgenerator_randomness) from [<bf1803c8>] (hwrng_fillfn+0xc0/0x14c [rng_core])
 [<bf1803c8>] (hwrng_fillfn [rng_core]) from [<c015abec>] (kthread+0x134/0x148)
 [<c015abec>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)

Check for a freezer signal here and skip adding any randomness if the
task wakes up because it was frozen. This should make the kthread freeze
properly and suspend work again.

Fixes: 03a3bb7ae631 ("hwrng: core - Freeze khwrng thread during suspend")
Reported-by: Keerthy <j-keerthy@ti.com>
Tested-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Probably needs to go via Herbert who routed the patch this is fixing.

 drivers/char/random.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 5d5ea4ce1442..e2e85ca16410 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2429,6 +2429,7 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
 				size_t entropy)
 {
 	struct entropy_store *poolp = &input_pool;
+	bool frozen = false;
 
 	if (unlikely(crng_init == 0)) {
 		crng_fast_load(buffer, count);
@@ -2439,9 +2440,12 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
 	 * We'll be woken up again once below random_write_wakeup_thresh,
 	 * or when the calling thread is about to terminate.
 	 */
-	wait_event_interruptible(random_write_wait, kthread_should_stop() ||
+	wait_event_interruptible(random_write_wait,
+			kthread_freezable_should_stop(&frozen) ||
 			ENTROPY_BITS(&input_pool) <= random_write_wakeup_bits);
-	mix_pool_bytes(poolp, buffer, count);
-	credit_entropy_bits(poolp, entropy);
+	if (!frozen) {
+		mix_pool_bytes(poolp, buffer, count);
+		credit_entropy_bits(poolp, entropy);
+	}
 }
 EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
-- 
Sent by a computer through tubes

