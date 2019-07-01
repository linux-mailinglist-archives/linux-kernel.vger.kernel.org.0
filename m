Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AACA4F005
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 22:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfFUUdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 16:33:08 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:42643 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbfFUUdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 16:33:07 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id a658ee5d;
        Fri, 21 Jun 2019 19:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=HXEG48TtoQvEtc5LwJNKwDlPUwc=; b=Qk4S+rNJY5A6713JF8Hq
        q4+qdqDlRRN11jFoSlCtCOwBVxbK9X9fmM7tJQF7GrNwcg0eOkyGb05lxbyt4mb0
        RmubUEL63SIA6y2pLcE8m+aj1ilIxTOWWbnHCGMwb5MsB/5aO1NkQJoZcl+5RBfa
        27naxIiIw4UuEAisjYp2YnxSZ/2zk8g/E+ffhuRuO1zNC5qu6sK/CXUOAc1J7YVj
        pM9bgOdvtiUkS3rj9+sPg8ZhV9R+7sVtybHI5K1epKD4krcu7rMwwIY2v4Z+z6jb
        MzrziO7gnHMaYHOpL3ATlTVsGhlVQd5Y7tCrRV3WDwd3nfa6CSvcRh0e7+do69lW
        kQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 35acfb10 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 21 Jun 2019 19:59:39 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5 1/3] timekeeping: use proper ktime_add when adding nsecs in coarse offset
Date:   Fri, 21 Jun 2019 22:32:47 +0200
Message-Id: <20190621203249.3909-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While this doesn't actually amount to a real difference, since the macro
evaluates to the same thing, every place else operates on ktime_t using
these functions, so let's not break the pattern.

Fixes: e3ff9c3678b4 ("timekeeping: Repair ktime_get_coarse*() granularity")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 44b726bab4bd..d911c8470149 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -819,7 +819,7 @@ ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs)
 
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
-	return base + nsecs;
+	return ktime_add_ns(base, nsecs);
 }
 EXPORT_SYMBOL_GPL(ktime_get_coarse_with_offset);
 
-- 
2.21.0

