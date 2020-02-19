Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63D15164E8B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 20:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgBSTKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 14:10:33 -0500
Received: from mga05.intel.com ([192.55.52.43]:7642 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbgBSTKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:10:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 11:10:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,461,1574150400"; 
   d="scan'208";a="408536205"
Received: from otc-lr-04.jf.intel.com ([10.54.39.48])
  by orsmga005.jf.intel.com with ESMTP; 19 Feb 2020 11:10:31 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, namhyung@kernel.org,
        ravi.bangoria@linux.ibm.com, yao.jin@linux.intel.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/5] perf jevents: Support metric constraint
Date:   Wed, 19 Feb 2020 11:08:36 -0800
Message-Id: <1582139320-75181-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582139320-75181-1-git-send-email-kan.liang@linux.intel.com>
References: <1582139320-75181-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A new field "MetricConstraint" is introduced in JSON event list.

Extend jevents to parse the field and save the value in
metric_constraint.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/pmu-events/jevents.c    | 19 +++++++++++++------
 tools/perf/pmu-events/jevents.h    |  2 +-
 tools/perf/pmu-events/pmu-events.h |  1 +
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 079c77b..6d0f61f 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -323,7 +323,7 @@ static int print_events_table_entry(void *data, char *name, char *event,
 				    char *pmu, char *unit, char *perpkg,
 				    char *metric_expr,
 				    char *metric_name, char *metric_group,
-				    char *deprecated)
+				    char *deprecated, char *metric_constraint)
 {
 	struct perf_entry_data *pd = data;
 	FILE *outfp = pd->outfp;
@@ -357,6 +357,8 @@ static int print_events_table_entry(void *data, char *name, char *event,
 		fprintf(outfp, "\t.metric_group = \"%s\",\n", metric_group);
 	if (deprecated)
 		fprintf(outfp, "\t.deprecated = \"%s\",\n", deprecated);
+	if (metric_constraint)
+		fprintf(outfp, "\t.metric_constraint = \"%s\",\n", metric_constraint);
 	fprintf(outfp, "},\n");
 
 	return 0;
@@ -375,6 +377,7 @@ struct event_struct {
 	char *metric_name;
 	char *metric_group;
 	char *deprecated;
+	char *metric_constraint;
 };
 
 #define ADD_EVENT_FIELD(field) do { if (field) {		\
@@ -422,7 +425,7 @@ static int save_arch_std_events(void *data, char *name, char *event,
 				char *desc, char *long_desc, char *pmu,
 				char *unit, char *perpkg, char *metric_expr,
 				char *metric_name, char *metric_group,
-				char *deprecated)
+				char *deprecated, char *metric_constraint)
 {
 	struct event_struct *es;
 
@@ -486,7 +489,7 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
 	  char **name, char **long_desc, char **pmu, char **filter,
 	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
 	  char **metric_group, unsigned long long eventcode,
-	  char **deprecated)
+	  char **deprecated, char **metric_constraint)
 {
 	/* try to find matching event from arch standard values */
 	struct event_struct *es;
@@ -515,7 +518,7 @@ int json_events(const char *fn,
 		      char *pmu, char *unit, char *perpkg,
 		      char *metric_expr,
 		      char *metric_name, char *metric_group,
-		      char *deprecated),
+		      char *deprecated, char *metric_constraint),
 	  void *data)
 {
 	int err;
@@ -545,6 +548,7 @@ int json_events(const char *fn,
 		char *metric_name = NULL;
 		char *metric_group = NULL;
 		char *deprecated = NULL;
+		char *metric_constraint = NULL;
 		char *arch_std = NULL;
 		unsigned long long eventcode = 0;
 		struct msrmap *msr = NULL;
@@ -629,6 +633,8 @@ int json_events(const char *fn,
 				addfield(map, &metric_name, "", "", val);
 			} else if (json_streq(map, field, "MetricGroup")) {
 				addfield(map, &metric_group, "", "", val);
+			} else if (json_streq(map, field, "MetricConstraint")) {
+				addfield(map, &metric_constraint, "", "", val);
 			} else if (json_streq(map, field, "MetricExpr")) {
 				addfield(map, &metric_expr, "", "", val);
 				for (s = metric_expr; *s; s++)
@@ -670,13 +676,13 @@ int json_events(const char *fn,
 					&long_desc, &pmu, &filter, &perpkg,
 					&unit, &metric_expr, &metric_name,
 					&metric_group, eventcode,
-					&deprecated);
+					&deprecated, &metric_constraint);
 			if (err)
 				goto free_strings;
 		}
 		err = func(data, name, real_event(name, event), desc, long_desc,
 			   pmu, unit, perpkg, metric_expr, metric_name,
-			   metric_group, deprecated);
+			   metric_group, deprecated, metric_constraint);
 free_strings:
 		free(event);
 		free(desc);
@@ -691,6 +697,7 @@ int json_events(const char *fn,
 		free(metric_expr);
 		free(metric_name);
 		free(metric_group);
+		free(metric_constraint);
 		free(arch_std);
 
 		if (err)
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
index 5cda49a4..2afc830 100644
--- a/tools/perf/pmu-events/jevents.h
+++ b/tools/perf/pmu-events/jevents.h
@@ -8,7 +8,7 @@ int json_events(const char *fn,
 				char *pmu,
 				char *unit, char *perpkg, char *metric_expr,
 				char *metric_name, char *metric_group,
-				char *deprecated),
+				char *deprecated, char *metric_constraint),
 		void *data);
 char *get_cpu_str(void);
 
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index caeb577..53e76d5 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -18,6 +18,7 @@ struct pmu_event {
 	const char *metric_name;
 	const char *metric_group;
 	const char *deprecated;
+	const char *metric_constraint;
 };
 
 /*
-- 
2.7.4

