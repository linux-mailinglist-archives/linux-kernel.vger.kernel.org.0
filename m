Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5B4B161EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 03:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgBRC2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 21:28:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:32442 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgBRC2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 21:28:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 18:28:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,454,1574150400"; 
   d="scan'208";a="348602156"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga001.fm.intel.com with ESMTP; 17 Feb 2020 18:28:47 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [REPOST][PATCH 2/2] platform/x86/intel-uncore-freq: Add release callback
Date:   Mon, 17 Feb 2020 18:28:44 -0800
Message-Id: <20200218022844.179988-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200218022844.179988-1-srinivas.pandruvada@linux.intel.com>
References: <20200218022844.179988-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On module unload wait for relese callback for each packag_die entry
and then free the memory. This is done by waiting on a completion
object, till release() callback.

While here, also change to kobject_init_and_add() to
kobject_create_and_add() to simplify.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel-uncore-frequency.c | 36 ++++++++++++-------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel-uncore-frequency.c b/drivers/platform/x86/intel-uncore-frequency.c
index c83ec95e8f3e..82f2de7c4112 100644
--- a/drivers/platform/x86/intel-uncore-frequency.c
+++ b/drivers/platform/x86/intel-uncore-frequency.c
@@ -38,6 +38,7 @@
  */
 struct uncore_data {
 	struct kobject kobj;
+	struct completion kobj_unregister;
 	u64 stored_uncore_data;
 	u32 initial_min_freq_khz;
 	u32 initial_max_freq_khz;
@@ -52,7 +53,7 @@ static int uncore_max_entries __read_mostly;
 /* Storage for uncore data for all instances */
 static struct uncore_data *uncore_instances;
 /* Root of the all uncore sysfs kobjs */
-struct kobject uncore_root_kobj;
+struct kobject *uncore_root_kobj;
 /* Stores the CPU mask of the target CPUs to use during uncore read/write */
 static cpumask_t uncore_cpu_mask;
 /* CPU online callback register instance */
@@ -225,15 +226,19 @@ static struct attribute *uncore_attrs[] = {
 	NULL
 };
 
+static void uncore_sysfs_entry_release(struct kobject *kobj)
+{
+	struct uncore_data *data = to_uncore_data(kobj);
+
+	complete(&data->kobj_unregister);
+}
+
 static struct kobj_type uncore_ktype = {
+	.release = uncore_sysfs_entry_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_attrs = uncore_attrs,
 };
 
-static struct kobj_type uncore_root_ktype = {
-	.sysfs_ops = &kobj_sysfs_ops,
-};
-
 /* Caller provides protection */
 static struct uncore_data *uncore_get_instance(unsigned int cpu)
 {
@@ -271,8 +276,10 @@ static void uncore_add_die_entry(int cpu)
 		uncore_read_ratio(data, &data->initial_min_freq_khz,
 				  &data->initial_max_freq_khz);
 
+		init_completion(&data->kobj_unregister);
+
 		ret = kobject_init_and_add(&data->kobj, &uncore_ktype,
-					   &uncore_root_kobj, str);
+					   uncore_root_kobj, str);
 		if (!ret) {
 			data->control_cpu = cpu;
 			data->valid = true;
@@ -391,11 +398,12 @@ static int __init intel_uncore_init(void)
 	if (!uncore_instances)
 		return -ENOMEM;
 
-	ret = kobject_init_and_add(&uncore_root_kobj, &uncore_root_ktype,
-				   &cpu_subsys.dev_root->kobj,
-				   "intel_uncore_frequency");
-	if (ret)
+	uncore_root_kobj = kobject_create_and_add("intel_uncore_frequency",
+						  &cpu_subsys.dev_root->kobj);
+	if (!uncore_root_kobj) {
+		ret = -ENOMEM;
 		goto err_free;
+	}
 
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				"platform/x86/uncore-freq:online",
@@ -415,7 +423,7 @@ static int __init intel_uncore_init(void)
 err_rem_state:
 	cpuhp_remove_state(uncore_hp_state);
 err_rem_kobj:
-	kobject_put(&uncore_root_kobj);
+	kobject_put(uncore_root_kobj);
 err_free:
 	kfree(uncore_instances);
 
@@ -430,10 +438,12 @@ static void __exit intel_uncore_exit(void)
 	unregister_pm_notifier(&uncore_pm_nb);
 	cpuhp_remove_state(uncore_hp_state);
 	for (i = 0; i < uncore_max_entries; ++i) {
-		if (uncore_instances[i].valid)
+		if (uncore_instances[i].valid) {
 			kobject_put(&uncore_instances[i].kobj);
+			wait_for_completion(&uncore_instances[i].kobj_unregister);
+		}
 	}
-	kobject_put(&uncore_root_kobj);
+	kobject_put(uncore_root_kobj);
 	kfree(uncore_instances);
 }
 module_exit(intel_uncore_exit)
-- 
2.20.1

