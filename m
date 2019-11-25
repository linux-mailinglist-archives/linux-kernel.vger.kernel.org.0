Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA86B1088A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 07:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfKYGHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 01:07:05 -0500
Received: from mga04.intel.com ([192.55.52.120]:6576 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfKYGHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 01:07:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 22:07:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,240,1571727600"; 
   d="scan'208";a="202245372"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 24 Nov 2019 22:07:02 -0800
Received: from [10.251.82.176] (abudanko-mobl.ccr.corp.intel.com [10.251.82.176])
        by linux.intel.com (Postfix) with ESMTP id 0252B580577;
        Sun, 24 Nov 2019 22:07:00 -0800 (PST)
Subject: [PATCH v2 1/3] tools bitmap: implement bitmap_equal() operation at
 bitmap API
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <fb356fe9-ac87-71ab-9845-075b3fac3199@linux.intel.com>
Organization: Intel Corp.
Message-ID: <ffa845c2-fdcd-6687-0151-95f6f6370e20@linux.intel.com>
Date:   Mon, 25 Nov 2019 09:06:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <fb356fe9-ac87-71ab-9845-075b3fac3199@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Extend tools bitmap API with bitmap_equal() implementation.
The implementation has been derived from the kernel.

Extend tools bitmap API with bitmap_free() implementation for
symmetry with bitmap_alloc() function.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v2:
- implemented bitmap_free() for symmetry with bitmap_alloc()

---
 tools/include/linux/bitmap.h | 30 ++++++++++++++++++++++++++++++
 tools/lib/bitmap.c           | 15 +++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 05dca5c203f3..477a1cae513f 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -15,6 +15,8 @@ void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, int bits);
 int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, unsigned int bits);
+int __bitmap_equal(const unsigned long *bitmap1,
+		   const unsigned long *bitmap2, unsigned int bits);
 void bitmap_clear(unsigned long *map, unsigned int start, int len);
 
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
@@ -123,6 +125,15 @@ static inline unsigned long *bitmap_alloc(int nbits)
 	return calloc(1, BITS_TO_LONGS(nbits) * sizeof(unsigned long));
 }
 
+/*
+ * bitmap_free - Free bitmap
+ * @bitmap: pointer to bitmap
+ */
+static inline void bitmap_free(unsigned long *bitmap)
+{
+	free(bitmap);
+}
+
 /*
  * bitmap_scnprintf - print bitmap list into buffer
  * @bitmap: bitmap
@@ -148,4 +159,23 @@ static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
 	return __bitmap_and(dst, src1, src2, nbits);
 }
 
+#ifdef __LITTLE_ENDIAN
+#define BITMAP_MEM_ALIGNMENT 8
+#else
+#define BITMAP_MEM_ALIGNMENT (8 * sizeof(unsigned long))
+#endif
+#define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
+#define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) == 0)
+
+static inline int bitmap_equal(const unsigned long *src1,
+			const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return !((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
+	if (__builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
+	    IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
+		return !memcmp(src1, src2, nbits / 8);
+	return __bitmap_equal(src1, src2, nbits);
+}
+
 #endif /* _PERF_BITOPS_H */
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index 38494782be06..5043747ef6c5 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -71,3 +71,18 @@ int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 			   BITMAP_LAST_WORD_MASK(bits));
 	return result != 0;
 }
+
+int __bitmap_equal(const unsigned long *bitmap1,
+		const unsigned long *bitmap2, unsigned int bits)
+{
+	unsigned int k, lim = bits/BITS_PER_LONG;
+	for (k = 0; k < lim; ++k)
+		if (bitmap1[k] != bitmap2[k])
+			return 0;
+
+	if (bits % BITS_PER_LONG)
+		if ((bitmap1[k] ^ bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
+			return 0;
+
+	return 1;
+}
-- 
2.20.1

