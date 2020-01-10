Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E89C136D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 14:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgAJNQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 08:16:23 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:46508 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbgAJNQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578662172; x=1610198172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=8zMTaLamMq4cV9+UX/hrWODp0qS6rAWD6pCOH/jGU+0=;
  b=mnO5Ro9p/PD8MPWv8g8MIbHeN7GE47uTWe/CcBPA9h07CSpHWBrvaXTX
   Sg7La9329TmjiC8C9ZuJseqXgEyTbKhbq0tQUiieMPZbFFgy0qv/odkzk
   HehVWm8DFkw5SDIpv8OvZlSMdrsuGtODgwXYfxMm7Hw0xkPYVDdWNZkxH
   E=;
IronPort-SDR: o6eASaivlF13dR8QnqhgoUdM0/29B+hwRuacWtdu0vYCHjjWjqoVBXXrnMze2SYGKCTjRTuR4X
 85j/3ZlutbGA==
X-IronPort-AV: E=Sophos;i="5.69,417,1571702400"; 
   d="scan'208";a="17962739"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 10 Jan 2020 13:16:05 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 7AE70A1DB4;
        Fri, 10 Jan 2020 13:16:02 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Fri, 10 Jan 2020 13:16:01 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.115) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 10 Jan 2020 13:15:56 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <corbet@lwn.net>, <linux-doc@vger.kernel.org>, <mgorman@suse.de>,
        <brendanhiggins@google.com>, <sj38.park@gmail.com>,
        SeongJae Park <sjpark@amazon.de>
Subject: [RFC PATCH 2/5] mm/damon: Add debugfs interface
Date:   Fri, 10 Jan 2020 14:15:19 +0100
Message-ID: <20200110131522.29964-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110131522.29964-1-sjpark@amazon.com>
References: <20200110131522.29964-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.115]
X-ClientProxiedBy: EX13D10UWA001.ant.amazon.com (10.43.160.216) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds a debugfs interface for DAMON.

DAMON exports three files, ``attrs``, ``pids``, and ``monitor_on`` under
its debugfs directory, ``<debugfs>/damon/``.

Attributes
----------

Users can read and write the ``sampling interval``, ``aggregation
interval``, ``regions update interval``, min/max number of regions, and
the path to ``result file`` by reading from and writing to the ``attrs``
file.  For example, below commands set those values to 5 ms, 100 ms,
1,000 ms, 10, 1000, and ``/damon.data`` and check it again::

    # cd <debugfs>/damon
    # echo 5000 100000 1000000 10 1000 /damon.data > attrs
    # cat attrs
    5000 100000 1000000 10 1000 /damon.data

Target PIDs
-----------

Users can read and write the pids of current monitoring target processes
by reading from and writing to the `pids` file.  For example, below
commands set processes having pids 42 and 4242 as the processes to be
monitored and check it again::

    # cd <debugfs>/damon
    # echo 42 4242 > pids
    # cat pids
    42 4242

Note that setting the pids doesn't starts the monitoring.

Turning On/Off
--------------

You can check current status, start and stop the monitoring by reading
from and writing to the ``monitor_on`` file.  Writing ``on`` to the file
starts DAMON to monitor the target processes with the attributes.
Writing ``off`` to the file stops DAMON.  DAMON also stops if every
target processes is be terminated.  Below example commands turn on, off,
and check status of DAMON::

    # cd <debugfs>/damon
    # echo on > monitor_on
    # echo off > monitor_on
    # cat monitor_on
    off

Please note that you cannot write to the ``attrs`` and ``pids`` files
while the monitoring is turned on.  If you write to the files while
DAMON is running, ``-EINVAL`` will be returned.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon.c | 229 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 228 insertions(+), 1 deletion(-)

diff --git a/mm/damon.c b/mm/damon.c
index 9a603c3f966a..0e99b4875700 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt) "damon: " fmt
 
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/mm.h>
@@ -1023,6 +1024,232 @@ static long damon_set_attrs(unsigned long sample_int,
 	return 0;
 }
 
+/*
+ * debugfs functions
+ */
+
+static ssize_t debugfs_monitor_on_read(struct file *file,
+		char __user *buf, size_t count, loff_t *ppos)
+{
+	char monitor_on_buf[5];
+	bool monitor_on;
+
+	spin_lock(&kdamond_lock);
+	monitor_on = kdamond != NULL;
+	spin_unlock(&kdamond_lock);
+
+	snprintf(monitor_on_buf, 5, monitor_on ? "on\n" : "off\n");
+
+	return simple_read_from_buffer(buf, count, ppos, monitor_on_buf,
+			monitor_on ? 3 : 4);
+}
+
+static ssize_t debugfs_monitor_on_write(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
+{
+	ssize_t ret;
+	bool on = false;
+	char cmdbuf[5];
+
+	ret = simple_write_to_buffer(cmdbuf, 5, ppos, buf, count);
+	if (ret < 0)
+		return ret;
+
+	if (sscanf(cmdbuf, "%s", cmdbuf) != 1)
+		return -EINVAL;
+	if (!strncmp(cmdbuf, "on", 5))
+		on = true;
+	else if (!strncmp(cmdbuf, "off", 5))
+		on = false;
+	else
+		return -EINVAL;
+
+	if (damon_turn_kdamond(on))
+		return -EINVAL;
+
+	return ret;
+}
+
+static ssize_t damon_sprint_pids(char *buf, ssize_t len)
+{
+	char *cursor = buf;
+	struct damon_task *t;
+
+	damon_for_each_task(t) {
+		snprintf(cursor, len, "%lu ", t->pid);
+		cursor += strnlen(cursor, len);
+	}
+	if (cursor != buf)
+		cursor--;
+	snprintf(cursor, len, "\n");
+	return strnlen(buf, len);
+}
+
+static ssize_t debugfs_pids_read(struct file *file,
+		char __user *buf, size_t count, loff_t *ppos)
+{
+	ssize_t len;
+	char pids_buf[512];
+
+	len = damon_sprint_pids(pids_buf, 512);
+
+	return simple_read_from_buffer(buf, count, ppos, pids_buf, len);
+}
+
+/*
+ * Converts a string into an array of unsigned long integers
+ *
+ * Returns an array of unsigned long integers that converted, or NULL if the
+ * input is wrong.
+ */
+static unsigned long *str_to_pids(const char *str, ssize_t len,
+				ssize_t *nr_pids)
+{
+	unsigned long *pids;
+	unsigned long pid;
+	int pos = 0, parsed, ret;
+
+	*nr_pids = 0;
+	pids = kmalloc_array(256, sizeof(unsigned long), GFP_KERNEL);
+	while (*nr_pids < 256 && pos < len) {
+		ret = sscanf(&str[pos], "%lu%n", &pid, &parsed);
+		pos += parsed;
+		if (ret != 1)
+			break;
+		pids[*nr_pids] = pid;
+		*nr_pids += 1;
+	}
+	if (*nr_pids == 0) {
+		kfree(pids);
+		pids = NULL;
+	}
+
+	return pids;
+}
+
+static ssize_t debugfs_pids_write(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
+{
+	ssize_t ret;
+	unsigned long *targets;
+	ssize_t nr_targets;
+	char pids_buf[512];
+
+	ret = simple_write_to_buffer(pids_buf, 512, ppos, buf, count);
+	if (ret < 0)
+		return ret;
+
+	targets = str_to_pids(pids_buf, ret, &nr_targets);
+
+	spin_lock(&kdamond_lock);
+	if (kdamond)
+		goto monitor_running;
+
+	damon_set_pids(targets, nr_targets);
+	spin_unlock(&kdamond_lock);
+	kfree(targets);
+
+	return ret;
+
+monitor_running:
+	spin_unlock(&kdamond_lock);
+	pr_err("%s: kdamond is running. Turn it off first.\n", __func__);
+	return -EINVAL;
+}
+
+static ssize_t debugfs_attrs_read(struct file *file,
+		char __user *buf, size_t count, loff_t *ppos)
+{
+	char attrs_buf[512];
+
+	snprintf(attrs_buf, 512, "%lu %lu %lu %lu %lu %s\n",
+			sample_interval, aggr_interval,
+			regions_update_interval, min_nr_regions,
+			max_nr_regions, rfile_path);
+
+	return simple_read_from_buffer(buf, count, ppos, attrs_buf,
+			strnlen(attrs_buf, 512));
+}
+
+static ssize_t debugfs_attrs_write(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
+{
+	unsigned long s, a, r, minr, maxr;
+	char attrs_buf[512];
+	char res_file_path[LEN_RES_FILE_PATH];
+	ssize_t ret;
+
+	if (count > 512) {
+		pr_err("attributes stream is too large: %s\n", buf);
+		return -ENOMEM;
+	}
+
+	ret = simple_write_to_buffer(attrs_buf, 512, ppos, buf, count);
+	if (ret < 0)
+		return ret;
+
+	if (sscanf(attrs_buf, "%lu %lu %lu %lu %lu %s",
+				&s, &a, &r, &minr, &maxr, res_file_path) != 6)
+		return -EINVAL;
+
+	spin_lock(&kdamond_lock);
+	if (kdamond)
+		goto monitor_running;
+
+	damon_set_attrs(s, a, r, minr, maxr, res_file_path);
+	spin_unlock(&kdamond_lock);
+
+	return ret;
+
+monitor_running:
+	spin_unlock(&kdamond_lock);
+	pr_err("%s: kdamond is running. Turn it off first.\n", __func__);
+	return -EINVAL;
+}
+
+static const struct file_operations monitor_on_fops = {
+	.owner = THIS_MODULE,
+	.read = debugfs_monitor_on_read,
+	.write = debugfs_monitor_on_write,
+};
+
+static const struct file_operations pids_fops = {
+	.owner = THIS_MODULE,
+	.read = debugfs_pids_read,
+	.write = debugfs_pids_write,
+};
+
+static const struct file_operations attrs_fops = {
+	.owner = THIS_MODULE,
+	.read = debugfs_attrs_read,
+	.write = debugfs_attrs_write,
+};
+
+static int __init debugfs_init(void)
+{
+	struct dentry *debugfs_root;
+	const char * const file_names[] = {"attrs", "pids", "monitor_on"};
+	const struct file_operations *fops[] = {&attrs_fops, &pids_fops,
+		&monitor_on_fops};
+	int i;
+
+	debugfs_root = debugfs_create_dir("damon", NULL);
+	if (!debugfs_root) {
+		pr_err("failed to create the debugfs dir\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(file_names); i++) {
+		if (!debugfs_create_file(file_names[i], 0600, debugfs_root,
+					NULL, fops[i])) {
+			pr_err("failed to create %s file\n", file_names[i]);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
 static int __init damon_init(void)
 {
 	pr_info("init\n");
@@ -1031,7 +1258,7 @@ static int __init damon_init(void)
 	ktime_get_coarse_ts64(&last_aggregate_time);
 	last_regions_update_time = last_aggregate_time;
 
-	return 0;
+	return debugfs_init();
 }
 
 module_init(damon_init);
-- 
2.17.1

