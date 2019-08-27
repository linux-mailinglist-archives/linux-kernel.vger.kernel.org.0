Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFCD9F570
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 23:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfH0Voq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 17:44:46 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:3554 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbfH0Vof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:44:35 -0400
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7RLaua4024670;
        Tue, 27 Aug 2019 21:44:29 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 2umx0s71tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 21:44:28 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 0B18F57;
        Tue, 27 Aug 2019 21:44:28 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
        id CA139201564D7; Tue, 27 Aug 2019 16:44:27 -0500 (CDT)
From:   Kyle Meyer <meyerk@hpe.com>
Cc:     Kyle Meyer <meyerk@hpe.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Russ Anderson <russ.anderson@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH v4 7/7] perf/lib/cpumap: Warn when exceeding MAX_NR_CPUS
Date:   Tue, 27 Aug 2019 16:43:52 -0500
Message-Id: <20190827214352.94272-8-meyerk@stormcage.eag.rdlabs.hpecorp.net>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190827214352.94272-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
References: <20190827214352.94272-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-27_04:2019-08-27,2019-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908270202
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display a warning when attempting to profile more than MAX_NR_CPU CPUs.
This patch should not change any behavior.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Russ Anderson <russ.anderson@hpe.com>
Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
---
 tools/perf/lib/cpumap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index 2834753576b2..1f0e6f334237 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -100,6 +100,9 @@ struct perf_cpu_map *perf_cpu_map__read(FILE *file)
 		if (prev >= 0) {
 			int new_max = nr_cpus + cpu - prev - 1;
 
+			WARN_ONCE(new_max >= MAX_NR_CPUS, "Perf can support %d CPUs. "
+							  "Consider raising MAX_NR_CPUS\n", MAX_NR_CPUS);
+
 			if (new_max >= max_entries) {
 				max_entries = new_max + MAX_NR_CPUS / 2;
 				tmp = realloc(tmp_cpus, max_entries * sizeof(int));
@@ -192,6 +195,9 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 			end_cpu = start_cpu;
 		}
 
+		WARN_ONCE(end_cpu >= MAX_NR_CPUS, "Perf can support %d CPUs. "
+						  "Consider raising MAX_NR_CPUS\n", MAX_NR_CPUS);
+
 		for (; start_cpu <= end_cpu; start_cpu++) {
 			/* check for duplicates */
 			for (i = 0; i < nr_cpus; i++)
-- 
2.12.3

