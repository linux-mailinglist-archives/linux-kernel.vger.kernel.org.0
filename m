Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F37A464582
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 13:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfGJLAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 07:00:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38974 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725994AbfGJLAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 07:00:06 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 32D0F41754D70F5E80C6;
        Wed, 10 Jul 2019 19:00:02 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Wed, 10 Jul 2019 18:59:53 +0800
From:   SunKe <sunke32@huawei.com>
To:     <jlbec@evilplan.org>, <hch@lst.de>, <sunke32@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] sample_configfs: bin_file read and write
Date:   Wed, 10 Jul 2019 19:05:37 +0800
Message-ID: <1562756737-124703-1-git-send-email-sunke32@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bin_file read and write function

Signed-off-by: SunKe <sunke32@huawei.com>
---
 samples/configfs/configfs_sample.c | 43 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/samples/configfs/configfs_sample.c b/samples/configfs/configfs_sample.c
index 004a4e2..c76b784 100644
--- a/samples/configfs/configfs_sample.c
+++ b/samples/configfs/configfs_sample.c
@@ -146,6 +146,8 @@ static struct childless childless_subsys = {
 struct simple_child {
 	struct config_item item;
 	int storeme;
+	void *data;
+	size_t len;
 };
 
 static inline struct simple_child *to_simple_child(struct config_item *item)
@@ -153,6 +155,46 @@ static inline struct simple_child *to_simple_child(struct config_item *item)
 	return item ? container_of(item, struct simple_child, item) : NULL;
 }
 
+static ssize_t simple_child_bin_storeme_bin_write(struct config_item *item,
+				    const void *data, size_t size)
+{
+	struct simple_child *simple_child = to_simple_child(item);
+
+	kfree(simple_child->data);
+	simple_child->data = NULL;
+
+	simple_child->data = kmemdup(data, size, GFP_KERNEL);
+	if (!simple_child->data)
+		return -ENOMEM;
+	simple_child->len = size;
+
+	return 0;
+}
+
+static ssize_t simple_child_bin_storeme_bin_read(struct config_item *item,
+				   void *data, size_t size)
+{
+	struct simple_child *simple_child = to_simple_child(item);
+
+	if (!data) {
+		size = simple_child->len;
+	} else {
+		memcpy(data, simple_child->data, simple_child->len);
+		size = simple_child->len;
+	}
+
+	return size;
+}
+
+#define MAX_SIZE (128 * 1024)
+
+CONFIGFS_BIN_ATTR(simple_child_bin_, storeme_bin, NULL, MAX_SIZE);
+
+static struct configfs_bin_attribute *simple_child_bin_attrs[] = {
+	&simple_child_bin_attr_storeme_bin,
+	NULL,
+};
+
 static ssize_t simple_child_storeme_show(struct config_item *item, char *page)
 {
 	return sprintf(page, "%d\n", to_simple_child(item)->storeme);
@@ -196,6 +238,7 @@ static struct configfs_item_operations simple_child_item_ops = {
 static const struct config_item_type simple_child_type = {
 	.ct_item_ops	= &simple_child_item_ops,
 	.ct_attrs	= simple_child_attrs,
+	.ct_bin_attrs	= simple_child_bin_attrs,
 	.ct_owner	= THIS_MODULE,
 };
 
-- 
2.7.4

