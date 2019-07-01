Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2D314EB88
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 17:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfFUPFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 11:05:46 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:40599 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfFUPFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:05:45 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c2a1c366;
        Fri, 21 Jun 2019 14:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=mail; bh=BCgOtPxwBhFl9ERxKMkR8S0mK
        lU=; b=nZ6xt4gB2O/bPt4oGCvRZJWbqW63sjiaDsP3WvxX/ZfCdRRYvFjllZONb
        KIBUN3CuXIlEDEorEGJ9MeWYmVbb/lfydMhfXAXA5XsCXVdJXCiX34z9i88IuUll
        2fBpGon9WP4jD+nWVP3nM5tm8TNVSui/Fuzl1c/DDLMQgtoWqa7q90p7vRySXNgI
        vJDgFC+xlI5dEDfZR32RIWnHM8hm4p8yFItyrmh+6nMYUGR7u7deoNqhFXbfecaD
        f9bCv+d1SNMSkIKmTAMOI5Yd8QxBfsCQjXIbp9aFVBU89euoNuGrmqShkf9ifK1H
        QR+3OXvUa9LHrDLEYuucVhqtMtYhQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 591e8a04 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 21 Jun 2019 14:32:18 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 2/4] timekeeping: use proper ktime_add when adding nsecs in coarse offset
Date:   Fri, 21 Jun 2019 17:05:19 +0200
Message-Id: <20190621150521.17687-2-Jason@zx2c4.com>
In-Reply-To: <20190621150521.17687-1-Jason@zx2c4.com>
References: <20190621150521.17687-1-Jason@zx2c4.com>
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
index 4c97c9c8c217..db0081a14b90 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -817,7 +817,7 @@ ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs)
 
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
-	return base + nsecs;
+	return ktime_add_ns(base, nsecs);
 }
 EXPORT_SYMBOL_GPL(ktime_get_coarse_with_offset);
 
-- 
2.21.0

