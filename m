Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6B2184EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 19:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgCMSe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 14:34:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:28623 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbgCMSe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:34:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 11:34:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; 
   d="scan'208";a="442506055"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.45])
  by fmsmga005.fm.intel.com with ESMTP; 13 Mar 2020 11:34:28 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 01/17] perf pmu: Add support for PMU capabilities
Date:   Fri, 13 Mar 2020 11:33:03 -0700
Message-Id: <20200313183319.17739-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313183319.17739-1-kan.liang@linux.intel.com>
References: <20200313183319.17739-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The PMU capabilities information, which is located at
/sys/bus/event_source/devices/<dev>/caps, is required by perf tool.
For example, the max LBR information is required to stitch LBR call
stack.

Add perf_pmu__caps_parse() to parse the PMU capabilities information.
The information is stored in a list.

Add perf_pmu__scan_caps() to scan the capabilities one by one.

The following patch will store the capabilities information in perf
header.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/pmu.c | 98 +++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h | 12 ++++++
 2 files changed, 110 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8b99fd312aae..4cdfbb669567 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -844,6 +844,7 @@ static struct perf_pmu *pmu_lookup(const char *name)
 
 	INIT_LIST_HEAD(&pmu->format);
 	INIT_LIST_HEAD(&pmu->aliases);
+	INIT_LIST_HEAD(&pmu->caps);
 	list_splice(&format, &pmu->format);
 	list_splice(&aliases, &pmu->aliases);
 	list_add_tail(&pmu->list, &pmus);
@@ -1565,3 +1566,100 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
 	va_end(args);
 	return ret;
 }
+
+static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
+{
+	struct perf_pmu_caps *caps;
+
+	caps = zalloc(sizeof(*caps));
+	if (!caps)
+		return -ENOMEM;
+
+	caps->name = strdup(name);
+	if (!caps->name)
+		goto free_caps;
+	caps->value = strndup(value, strlen(value) - 1);
+	if (!caps->value)
+		goto free_name;
+	list_add_tail(&caps->list, list);
+	return 0;
+
+free_name:
+	free(caps->name);
+free_caps:
+	free(caps);
+
+	return -ENOMEM;
+}
+
+/*
+ * Reading/parsing the given pmu capabilities, which should be located at:
+ * /sys/bus/event_source/devices/<dev>/caps as sysfs group attributes.
+ * Return the number of capabilities
+ */
+int perf_pmu__caps_parse(struct perf_pmu *pmu)
+{
+	struct stat st;
+	char caps_path[PATH_MAX];
+	const char *sysfs = sysfs__mountpoint();
+	DIR *caps_dir;
+	struct dirent *evt_ent;
+	int nr_caps = 0;
+
+	if (!sysfs)
+		return -1;
+
+	snprintf(caps_path, PATH_MAX,
+		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/caps", sysfs, pmu->name);
+
+	if (stat(caps_path, &st) < 0)
+		return 0;	/* no error if caps does not exist */
+
+	caps_dir = opendir(caps_path);
+	if (!caps_dir)
+		return -EINVAL;
+
+	while ((evt_ent = readdir(caps_dir)) != NULL) {
+		char path[PATH_MAX + NAME_MAX + 1];
+		char *name = evt_ent->d_name;
+		char value[128];
+		FILE *file;
+
+		if (!strcmp(name, ".") || !strcmp(name, ".."))
+			continue;
+
+		snprintf(path, sizeof(path), "%s/%s", caps_path, name);
+
+		file = fopen(path, "r");
+		if (!file)
+			break;
+
+		if (!fgets(value, sizeof(value), file) ||
+		    (perf_pmu__new_caps(&pmu->caps, name, value) < 0)) {
+			fclose(file);
+			break;
+		}
+
+		nr_caps++;
+		fclose(file);
+	}
+
+	closedir(caps_dir);
+
+	return nr_caps;
+}
+
+struct perf_pmu_caps *perf_pmu__scan_caps(struct perf_pmu *pmu,
+					  struct perf_pmu_caps *caps)
+{
+	if (!pmu)
+		return NULL;
+
+	if (!caps)
+		caps = list_prepare_entry(caps, &pmu->caps, list);
+
+	list_for_each_entry_continue(caps, &pmu->caps, list)
+		return caps;
+
+	return NULL;
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 6737e3d5d568..a228e27ae462 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -21,6 +21,12 @@ enum {
 
 struct perf_event_attr;
 
+struct perf_pmu_caps {
+	char *name;
+	char *value;
+	struct list_head list;
+};
+
 struct perf_pmu {
 	char *name;
 	__u32 type;
@@ -32,6 +38,7 @@ struct perf_pmu {
 	struct perf_cpu_map *cpus;
 	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
 	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
+	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
 	struct list_head list;    /* ELEM */
 };
 
@@ -102,4 +109,9 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
 
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
+int perf_pmu__caps_parse(struct perf_pmu *pmu);
+
+struct perf_pmu_caps *perf_pmu__scan_caps(struct perf_pmu *pmu,
+					  struct perf_pmu_caps *caps);
+
 #endif /* __PMU_H */
-- 
2.17.1

