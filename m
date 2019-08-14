Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 846418CFA8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 11:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfHNJce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 05:32:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725265AbfHNJcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:32:33 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7E9S7dE058422
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 05:32:30 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uce7wuy3k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 05:32:29 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mamatha4@linux.vnet.ibm.com>;
        Wed, 14 Aug 2019 10:32:27 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 14 Aug 2019 10:32:23 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7E9WMGP28442792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 09:32:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2381AAE045;
        Wed, 14 Aug 2019 09:32:22 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71770AE051;
        Wed, 14 Aug 2019 09:32:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.94])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Aug 2019 09:32:19 +0000 (GMT)
Subject: [PATCH]Perf: Return error code for perf_session__new function on
 failure
From:   Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mamatha4@linux.vnet.ibm.com, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        jeremie.galarneau@efficios.com, shawn@git.icu,
        tstoyanov@vmware.com, tglx@linutronix.de,
        alexey.budankov@linux.intel.com, adrian.hunter@intel.com,
        songliubraving@fb.com, ravi.bangoria@linux.ibm.com
Date:   Wed, 14 Aug 2019 15:02:18 +0530
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19081409-0008-0000-0000-0000030906DF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081409-0009-0000-0000-00004A271CD3
Message-Id: <20190814092654.7781.81601.stgit@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch is to return error code of perf_new_session function
on failure instead of NULL
----------------------------------------------
Test Results:

Before Fix:

$ perf c2c report -input
failed to open nput: No such file or directory

$ echo $?
0
------------------------------------------
After Fix:

$ ./perf c2c report -input
failed to open nput: No such file or directory

$ echo $?
254

Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
Tested-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
---
 tools/perf/builtin-annotate.c      |    5 +++--
 tools/perf/builtin-buildid-cache.c |    5 +++--
 tools/perf/builtin-buildid-list.c  |    5 +++--
 tools/perf/builtin-c2c.c           |    6 ++++--
 tools/perf/builtin-diff.c          |    9 +++++----
 tools/perf/builtin-evlist.c        |    5 +++--
 tools/perf/builtin-inject.c        |    5 +++--
 tools/perf/builtin-kmem.c          |    5 +++--
 tools/perf/builtin-kvm.c           |    9 +++++----
 tools/perf/builtin-lock.c          |    5 +++--
 tools/perf/builtin-mem.c           |    5 +++--
 tools/perf/builtin-record.c        |    5 +++--
 tools/perf/builtin-report.c        |    4 ++--
 tools/perf/builtin-sched.c         |   11 ++++++-----
 tools/perf/builtin-script.c        |    9 +++++----
 tools/perf/builtin-stat.c          |   11 ++++++-----
 tools/perf/builtin-timechart.c     |    5 +++--
 tools/perf/builtin-top.c           |    5 +++--
 tools/perf/builtin-trace.c         |    4 ++--
 tools/perf/util/data-convert-bt.c  |    4 +++-
 tools/perf/util/session.c          |   13 +++++++++----
 21 files changed, 80 insertions(+), 55 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index e0aa14f..d5011e0 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -33,6 +33,7 @@
 #include "util/data.h"
 #include "arch/common.h"
 #include "util/block-range.h"
+#include <linux/err.h>
 
 #include <dlfcn.h>
 #include <errno.h>
@@ -581,8 +582,8 @@ int cmd_annotate(int argc, const char **argv)
 	data.path = input_name;
 
 	annotate.session = perf_session__new(&data, false, &annotate.tool);
-	if (annotate.session == NULL)
-		return -1;
+	if (IS_ERR(annotate.session))
+		return PTR_ERR(annotate.session);
 
 	annotate.has_br_stack = perf_header__has_feat(&annotate.session->header,
 						      HEADER_BRANCH_STACK);
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 10457b1..7bab695 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -26,6 +26,7 @@
 #include "util/symbol.h"
 #include "util/time-utils.h"
 #include "util/probe-file.h"
+#include <linux/err.h>
 
 static int build_id_cache__kcore_buildid(const char *proc_dir, char *sbuildid)
 {
@@ -420,8 +421,8 @@ int cmd_buildid_cache(int argc, const char **argv)
 		data.force = force;
 
 		session = perf_session__new(&data, false, NULL);
-		if (session == NULL)
-			return -1;
+		if (IS_ERR(session))
+			return PTR_ERR(session);
 	}
 
 	if (symbol__init(session ? &session->header.env : NULL) < 0)
diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index f403e19..95036ee 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -18,6 +18,7 @@
 #include "util/symbol.h"
 #include "util/data.h"
 #include <errno.h>
+#include <linux/err.h>
 
 static int sysfs__fprintf_build_id(FILE *fp)
 {
@@ -65,8 +66,8 @@ static int perf_session__list_build_ids(bool force, bool with_hits)
 		goto out;
 
 	session = perf_session__new(&data, false, &build_id__mark_dso_hit_ops);
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	/*
 	 * We take all buildids when the file contains AUX area tracing data
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index e3776f5..bece5d8 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -18,6 +18,7 @@
 #include <linux/zalloc.h>
 #include <asm/bug.h>
 #include <sys/param.h>
+#include <linux/err.h>
 #include "debug.h"
 #include "builtin.h"
 #include <subcmd/parse-options.h>
@@ -2774,8 +2775,9 @@ static int perf_c2c__report(int argc, const char **argv)
 	}
 
 	session = perf_session__new(&data, 0, &c2c.tool);
-	if (session == NULL) {
-		pr_debug("No memory for session\n");
+	if (IS_ERR(session)) {
+		err = PTR_ERR(session);
+		pr_debug("Error creating perf session\n");
 		goto out;
 	}
 
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index f6f5dd1..9e205e1 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -22,6 +22,7 @@
 #include "util/annotate.h"
 #include "util/map.h"
 #include <linux/zalloc.h>
+#include <linux/err.h>
 
 #include <errno.h>
 #include <inttypes.h>
@@ -1149,9 +1150,9 @@ static int check_file_brstack(void)
 
 	data__for_each_file(i, d) {
 		d->session = perf_session__new(&d->data, false, &pdiff.tool);
-		if (!d->session) {
+		if (IS_ERR(d->session)) {
 			pr_err("Failed to open %s\n", d->data.path);
-			return -1;
+			return PTR_ERR(d->session);
 		}
 
 		has_br_stack = perf_header__has_feat(&d->session->header,
@@ -1181,9 +1182,9 @@ static int __cmd_diff(void)
 
 	data__for_each_file(i, d) {
 		d->session = perf_session__new(&d->data, false, &pdiff.tool);
-		if (!d->session) {
+		if (IS_ERR(d->session)) {
+			ret = PTR_ERR(d->session);
 			pr_err("Failed to open %s\n", d->data.path);
-			ret = -1;
 			goto out_delete;
 		}
 
diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
index 6e4f63b..36069ac 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -17,6 +17,7 @@
 #include "util/session.h"
 #include "util/data.h"
 #include "util/debug.h"
+#include <linux/err.h>
 
 static int __cmd_evlist(const char *file_name, struct perf_attr_details *details)
 {
@@ -30,8 +31,8 @@ static int __cmd_evlist(const char *file_name, struct perf_attr_details *details
 	bool has_tracepoint = false;
 
 	session = perf_session__new(&data, 0, NULL);
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	evlist__for_each_entry(session->evlist, pos) {
 		perf_evsel__fprintf(pos, details, stdout);
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index f4591a1..b82ad14 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -22,6 +22,7 @@
 #include "util/jit.h"
 #include "util/symbol.h"
 #include "util/thread.h"
+#include <linux/err.h>
 
 #include <subcmd/parse-options.h>
 
@@ -834,8 +835,8 @@ int cmd_inject(int argc, const char **argv)
 
 	data.path = inject.input_name;
 	inject.session = perf_session__new(&data, true, &inject.tool);
-	if (inject.session == NULL)
-		return -1;
+	if (IS_ERR(inject.session))
+		return PTR_ERR(inject.session);
 
 	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
 		pr_warning("Decompression initialization failed.\n");
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 9e5e608..7fd48373 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -13,6 +13,7 @@
 #include "util/tool.h"
 #include "util/callchain.h"
 #include "util/time-utils.h"
+#include <linux/err.h>
 
 #include <subcmd/parse-options.h>
 #include "util/trace-event.h"
@@ -1953,8 +1954,8 @@ int cmd_kmem(int argc, const char **argv)
 	data.path = input_name;
 
 	kmem_session = session = perf_session__new(&data, false, &perf_kmem);
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	ret = -1;
 
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index b33c834..0b3306f 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -19,6 +19,7 @@
 #include "util/top.h"
 #include "util/data.h"
 #include "util/ordered-events.h"
+#include <linux/err.h>
 
 #include <sys/prctl.h>
 #ifdef HAVE_TIMERFD_SUPPORT
@@ -1087,9 +1088,9 @@ static int read_events(struct perf_kvm_stat *kvm)
 
 	kvm->tool = eops;
 	kvm->session = perf_session__new(&file, false, &kvm->tool);
-	if (!kvm->session) {
+	if (IS_ERR(kvm->session)) {
 		pr_err("Initializing perf session failed\n");
-		return -1;
+		return PTR_ERR(kvm->session);
 	}
 
 	symbol__init(&kvm->session->header.env);
@@ -1442,8 +1443,8 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 	 * perf session
 	 */
 	kvm->session = perf_session__new(&data, false, &kvm->tool);
-	if (kvm->session == NULL) {
-		err = -1;
+	if (IS_ERR(kvm->session)) {
+		err = PTR_ERR(kvm->session);
 		goto out;
 	}
 	kvm->session->evlist = kvm->evlist;
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 574e30e..b393e4c 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -30,6 +30,7 @@
 #include <linux/hash.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
+#include <linux/err.h>
 
 static struct perf_session *session;
 
@@ -872,9 +873,9 @@ static int __cmd_report(bool display_info)
 	};
 
 	session = perf_session__new(&data, false, &eops);
-	if (!session) {
+	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
-		return -1;
+		return PTR_ERR(session);
 	}
 
 	symbol__init(&session->header.env);
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index f45c8b5..b2f8c12 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -15,6 +15,7 @@
 #include "util/debug.h"
 #include "util/map.h"
 #include "util/symbol.h"
+#include <linux/err.h>
 
 #define MEM_OPERATION_LOAD	0x1
 #define MEM_OPERATION_STORE	0x2
@@ -247,8 +248,8 @@ static int report_raw_events(struct perf_mem *mem)
 	struct perf_session *session = perf_session__new(&data, false,
 							 &mem->tool);
 
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	if (mem->cpu_list) {
 		ret = perf_session__cpu_bitmap(session, mem->cpu_list,
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8779cee..9721c08 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -42,6 +42,7 @@
 #include "util/units.h"
 #include "util/bpf-event.h"
 #include "asm/bug.h"
+#include <linux/err.h>
 
 #include <errno.h>
 #include <inttypes.h>
@@ -1337,9 +1338,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 
 	session = perf_session__new(data, false, tool);
-	if (session == NULL) {
+	if (IS_ERR(session)) {
 		pr_err("Perf session creation failed.\n");
-		return -1;
+		return PTR_ERR(session);
 	}
 
 	fd = perf_data__fd(data);
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index abf0b9b..b57eb80 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1254,8 +1254,8 @@ int cmd_report(int argc, const char **argv)
 
 repeat:
 	session = perf_session__new(&data, false, &report.tool);
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	if (zstd_init(&(session->zstd_data), 0) < 0)
 		pr_warning("Decompression initialization failed. Reported data may be incomplete.\n");
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 56d1907..d17a75e 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -36,6 +36,7 @@
 #include <math.h>
 #include <api/fs/fs.h>
 #include <linux/time64.h>
+#include <linux/err.h>
 
 #include <linux/ctype.h>
 
@@ -1793,9 +1794,9 @@ static int perf_sched__read_events(struct perf_sched *sched)
 	int rc = -1;
 
 	session = perf_session__new(&data, false, &sched->tool);
-	if (session == NULL) {
-		pr_debug("No Memory for session\n");
-		return -1;
+	if (IS_ERR(session)) {
+		pr_debug("Error creating perf session");
+		return PTR_ERR(session);
 	}
 
 	symbol__init(&session->header.env);
@@ -2985,8 +2986,8 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	symbol_conf.use_callchain = sched->show_callchain;
 
 	session = perf_session__new(&data, false, &sched->tool);
-	if (session == NULL)
-		return -ENOMEM;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	evlist = session->evlist;
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 0140ddb..381a10d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -48,6 +48,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <subcmd/pager.h>
+#include <linux/err.h>
 
 #include <linux/ctype.h>
 
@@ -3072,8 +3073,8 @@ int find_scripts(char **scripts_array, char **scripts_path_array, int num,
 	int i = 0;
 
 	session = perf_session__new(&data, false, NULL);
-	if (!session)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	snprintf(scripts_path, MAXPATHLEN, "%s/scripts", get_argv_exec_path());
 
@@ -3742,8 +3743,8 @@ int cmd_script(int argc, const char **argv)
 	}
 
 	session = perf_session__new(&data, false, &script.tool);
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	if (header || header_only) {
 		script.tool.show_feat_hdr = SHOW_FEAT_HEADER;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 352cf39..9fd0a3b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -81,6 +81,7 @@
 #include <unistd.h>
 #include <sys/time.h>
 #include <sys/resource.h>
+#include <linux/err.h>
 
 #include <linux/ctype.h>
 
@@ -1445,9 +1446,9 @@ static int __cmd_record(int argc, const char **argv)
 	}
 
 	session = perf_session__new(data, false, NULL);
-	if (session == NULL) {
-		pr_err("Perf session creation failed.\n");
-		return -1;
+	if (IS_ERR(session)) {
+		pr_err("Perf session creation failed\n");
+		return PTR_ERR(session);
 	}
 
 	init_features(session);
@@ -1644,8 +1645,8 @@ static int __cmd_report(int argc, const char **argv)
 	perf_stat.data.mode = PERF_DATA_MODE_READ;
 
 	session = perf_session__new(&perf_stat.data, false, &perf_stat.tool);
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	perf_stat.session  = session;
 	stat_config.output = stderr;
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 4bde3fa..a18cd43 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -36,6 +36,7 @@
 #include "util/tool.h"
 #include "util/data.h"
 #include "util/debug.h"
+#include <linux/err.h>
 
 #ifdef LACKS_OPEN_MEMSTREAM_PROTOTYPE
 FILE *open_memstream(char **ptr, size_t *sizeloc);
@@ -1605,8 +1606,8 @@ static int __cmd_timechart(struct timechart *tchart, const char *output_name)
 							 &tchart->tool);
 	int ret = -EINVAL;
 
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	symbol__init(&session->header.env);
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index b46b3c9..4cc4c0b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -75,6 +75,7 @@
 #include <linux/stringify.h>
 #include <linux/time64.h>
 #include <linux/types.h>
+#include <linux/err.h>
 
 #include <linux/ctype.h>
 
@@ -1642,8 +1643,8 @@ int cmd_top(int argc, const char **argv)
 	}
 
 	top.session = perf_session__new(NULL, false, NULL);
-	if (top.session == NULL) {
-		status = -1;
+	if (IS_ERR(top.session)) {
+		status = PTR_ERR(top.session);
 		goto out_delete_evlist;
 	}
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4f0bbff..4567f82 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3253,8 +3253,8 @@ static int trace__replay(struct trace *trace)
 	trace->multiple_threads = true;
 
 	session = perf_session__new(&data, false, &trace->tool);
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	if (trace->opts.target.pid)
 		symbol_conf.pid_list_str = strdup(trace->opts.target.pid);
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index ddbcd59..dbc6dc2 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1619,8 +1619,10 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 	err = -1;
 	/* perf.data session */
 	session = perf_session__new(&data, 0, &c.tool);
-	if (!session)
+	if (IS_ERR(session)) {
+		err = PTR_ERR(session);
 		goto free_writer;
+	}
 
 	if (c.queue_size) {
 		ordered_events__set_alloc_size(&session->ordered_events,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 37efa1f..a784ce6 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -28,6 +28,7 @@
 #include "sample-raw.h"
 #include "stat.h"
 #include "arch/common.h"
+#include <linux/err.h>
 
 #ifdef HAVE_ZSTD_SUPPORT
 static int perf_session__process_compressed_event(struct perf_session *session,
@@ -181,6 +182,7 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 struct perf_session *perf_session__new(struct perf_data *data,
 				       bool repipe, struct perf_tool *tool)
 {
+	int ret = 0;
 	struct perf_session *session = zalloc(sizeof(*session));
 
 	if (!session)
@@ -195,13 +197,15 @@ struct perf_session *perf_session__new(struct perf_data *data,
 
 	perf_env__init(&session->header.env);
 	if (data) {
-		if (perf_data__open(data))
+		ret = perf_data__open(data);
+		if (ret < 0)
 			goto out_delete;
 
 		session->data = data;
 
 		if (perf_data__is_read(data)) {
-			if (perf_session__open(session) < 0)
+			ret = perf_session__open(session);
+			if (ret < 0)
 				goto out_delete;
 
 			/*
@@ -216,7 +220,8 @@ struct perf_session *perf_session__new(struct perf_data *data,
 			perf_evlist__init_trace_event_sample_raw(session->evlist);
 
 			/* Open the directory data. */
-			if (data->is_dir && perf_data__open_dir(data))
+			ret = data->is_dir && perf_data__open_dir(data);
+			if (ret)
 				goto out_delete;
 		}
 	} else  {
@@ -250,7 +255,7 @@ struct perf_session *perf_session__new(struct perf_data *data,
  out_delete:
 	perf_session__delete(session);
  out:
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 static void perf_session__delete_threads(struct perf_session *session)

