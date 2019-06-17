Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F395A48FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 21:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfFQTiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 15:38:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35653 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfFQTiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:38:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJaq3I3566030
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:36:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJaq3I3566030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800212;
        bh=U1yJ00rIq5XqPzJNUb+uYzl0ZZKpw07LOWVl8i+YHwI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Htc5Ic7pH2/5y9Fsn2VM5JTGnkKIvkiusT2xN7Cz6TbjXibglJWNeXX7wR4pVk6Qb
         QBhTLbX3tGiAXATl6x8NKchQOcqxbMSpF1dgAc5xhi6pwzPRog5AaNjiivExtputf/
         RJXHgX+BLThkgq6lhZMqLUwPOev1do5uHNn3WLcY9rYGjn0cps9OaMm1PlPw5OoBhf
         sigiK6JLJOxkd5t0W2EXeu23W8ZF0eVFQDuxnacSl03QHZz3/Ii85o7LfFQtvTWaUW
         rOz/Gyf5CAx67C/P1biVvA7Ph8XjOOEjqnae3VHyISLfJxQxdR1dGcpSerR9eiV7Yc
         eMBKWvp1rITiw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJaqit3566027;
        Mon, 17 Jun 2019 12:36:52 -0700
Date:   Mon, 17 Jun 2019 12:36:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-69pd3mqvxdlh2shddsc7yhyv@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@redhat.com, suzuki.poulose@arm.com, tglx@linutronix.de,
        peterz@infradead.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        mathieu.poirier@linaro.org, hpa@zytor.com, acme@redhat.com
Reply-To: suzuki.poulose@arm.com, peterz@infradead.org, tglx@linutronix.de,
          jolsa@redhat.com, mathieu.poirier@linaro.org, hpa@zytor.com,
          acme@redhat.com, linux-kernel@vger.kernel.org,
          leo.yan@linaro.org, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, namhyung@kernel.org
In-Reply-To: <68c1c548-33cd-31e8-100d-7ffad008c7b2@arm.com>
References: <68c1c548-33cd-31e8-100d-7ffad008c7b2@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Remove duplicate GENMASK() define, use
 linux/bits.h instead
Git-Commit-ID: 965e176f3c4ae260f21606e19dc3a58d66d8f605
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  965e176f3c4ae260f21606e19dc3a58d66d8f605
Gitweb:     https://git.kernel.org/tip/965e176f3c4ae260f21606e19dc3a58d66d8f605
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 7 Jun 2019 15:14:27 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:11 -0300

perf cs-etm: Remove duplicate GENMASK() define, use linux/bits.h instead

Suzuki noticed that this should be more useful in a generic header, and
after looking I noticed we have it already in our copy of
include/linux/bits.h in tools/include, so just use it, test built on
x86-64 and ubuntu 19.04 with:

  perfbuilder@46646c9e848e:/$ aarch64-linux-gnu-gcc --version |& head -1
  aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
  perfbuilder@46646c9e848e:/$

Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lkml.kernel.org/r/68c1c548-33cd-31e8-100d-7ffad008c7b2@arm.com
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org,
Link: https://lkml.kernel.org/n/tip-69pd3mqvxdlh2shddsc7yhyv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 33b57e748c3d..bc848fd095f4 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -9,6 +9,7 @@
 
 #include "util/event.h"
 #include "util/session.h"
+#include <linux/bits.h>
 
 /* Versionning header in case things need tro change in the future.  That way
  * decoding of old snapshot is still possible.
@@ -161,16 +162,6 @@ struct cs_etm_packet_queue {
 
 #define CS_ETM_INVAL_ADDR 0xdeadbeefdeadbeefUL
 
-/*
- * Create a contiguous bitmask starting at bit position @l and ending at
- * position @h. For example
- * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
- *
- * Carbon copy of implementation found in $KERNEL/include/linux/bitops.h
- */
-#define GENMASK(h, l) \
-	(((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
-
 #define BMVAL(val, lsb, msb)	((val & GENMASK(msb, lsb)) >> lsb)
 
 #define CS_ETM_HEADER_SIZE (CS_HEADER_VERSION_0_MAX * sizeof(u64))
