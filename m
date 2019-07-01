Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78C414D9DC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 20:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfFTS4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 14:56:17 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:50064 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbfFTS4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:56:17 -0400
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KIhVgc010117;
        Thu, 20 Jun 2019 18:55:41 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0a-002e3701.pphosted.com with ESMTP id 2t8fnxr2mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 18:55:41 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 529274F;
        Thu, 20 Jun 2019 18:55:40 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
        id 13C64201FBE59; Thu, 20 Jun 2019 13:55:40 -0500 (CDT)
From:   Kyle Meyer <meyerk@hpe.com>
To:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH] Increase MAX_NR_CPUS and MAX_CACHES
Date:   Thu, 20 Jun 2019 13:55:28 -0500
Message-Id: <20190620185528.109896-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
X-Mailer: git-send-email 2.12.3
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyle Meyer <kyle.meyer@hpe.com>

Attempting to profile 1024 or more CPUs with perf causes two errors:

perf record -a
[ perf record: Woken up X times to write data ]
way too many cpu caches..
[ perf record: Captured and wrote X MB perf.data (X samples) ]

perf report -C 1024
Error: failed to set  cpu bitmap
Requested CPU 1024 too large. Consider raising MAX_NR_CPUS

Increasing MAX_NR_CPUS from 1024 to 2048 and redefining MAX_CACHES as
MAX_NR_CPUS * 4 returns normal functionality to perf:

perf record -a
[ perf record: Woken up X times to write data ]
[ perf record: Captured and wrote X MB perf.data (X samples) ]

perf report -C 1024
...
---
 samples/bpf/map_perf_test_kern.c | 2 +-
 samples/bpf/map_perf_test_user.c | 2 +-
 tools/perf/perf.h                | 2 +-
 tools/perf/util/header.c         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/samples/bpf/map_perf_test_kern.c b/samples/bpf/map_perf_test_kern.c
index 2b2ffb97018b..342738a1e386 100644
--- a/samples/bpf/map_perf_test_kern.c
+++ b/samples/bpf/map_perf_test_kern.c
@@ -11,7 +11,7 @@
 #include "bpf_helpers.h"
 
 #define MAX_ENTRIES 1000
-#define MAX_NR_CPUS 1024
+#define MAX_NR_CPUS 2048
 
 struct bpf_map_def SEC("maps") hash_map = {
 	.type = BPF_MAP_TYPE_HASH,
diff --git a/samples/bpf/map_perf_test_user.c b/samples/bpf/map_perf_test_user.c
index fe5564bff39b..da3c101ca776 100644
--- a/samples/bpf/map_perf_test_user.c
+++ b/samples/bpf/map_perf_test_user.c
@@ -22,7 +22,7 @@
 #include "bpf_load.h"
 
 #define TEST_BIT(t) (1U << (t))
-#define MAX_NR_CPUS 1024
+#define MAX_NR_CPUS 2048
 
 static __u64 time_get_ns(void)
 {
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 711e009381ec..74d0124d38f3 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -26,7 +26,7 @@ static inline unsigned long long rdclock(void)
 }
 
 #ifndef MAX_NR_CPUS
-#define MAX_NR_CPUS			1024
+#define MAX_NR_CPUS			2048
 #endif
 
 extern const char *input_name;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 06ddb6618ef3..bf017901f75c 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1121,7 +1121,7 @@ static int build_caches(struct cpu_cache_level caches[], u32 size, u32 *cntp)
 	return 0;
 }
 
-#define MAX_CACHES 2000
+#define MAX_CACHES MAX_NR_CPUS * 4
 
 static int write_cache(struct feat_fd *ff,
 		       struct perf_evlist *evlist __maybe_unused)
-- 
2.20.1

