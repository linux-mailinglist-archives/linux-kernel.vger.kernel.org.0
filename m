Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D978F9F56D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 23:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfH0Vof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 17:44:35 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:64866 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbfH0Vof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:44:35 -0400
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7RLauPS020627;
        Tue, 27 Aug 2019 21:44:25 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0a-002e3701.pphosted.com with ESMTP id 2un7hmj7nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 21:44:25 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 8335157;
        Tue, 27 Aug 2019 21:44:24 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
        id 4D232201564D7; Tue, 27 Aug 2019 16:44:24 -0500 (CDT)
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
Subject: [PATCH v4 3/7] perf/util/stat: Replace MAX_NR_CPUS with cpu__max_cpu
Date:   Tue, 27 Aug 2019 16:43:48 -0500
Message-Id: <20190827214352.94272-4-meyerk@stormcage.eag.rdlabs.hpecorp.net>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190827214352.94272-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
References: <20190827214352.94272-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-27_04:2019-08-27,2019-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908270202
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function cpu__max_cpu returns the possible number of CPUs as defined
in the sysfs and can be used as an alternative for MAX_NR_CPUS in
zero_per_pkg and check_per_pkg.

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
 tools/perf/util/stat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 0cbfd1eca1dd..b754686b684d 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -209,7 +209,7 @@ void perf_evlist__reset_stats(struct evlist *evlist)
 static void zero_per_pkg(struct evsel *counter)
 {
 	if (counter->per_pkg_mask)
-		memset(counter->per_pkg_mask, 0, MAX_NR_CPUS);
+		memset(counter->per_pkg_mask, 0, cpu__max_cpu());
 }
 
 static int check_per_pkg(struct evsel *counter,
@@ -228,7 +228,7 @@ static int check_per_pkg(struct evsel *counter,
 		return 0;
 
 	if (!mask) {
-		mask = zalloc(MAX_NR_CPUS);
+		mask = zalloc(cpu__max_cpu());
 		if (!mask)
 			return -ENOMEM;
 
-- 
2.12.3

