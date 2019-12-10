Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 731F6118CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 16:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfLJPhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 10:37:43 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:53720 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727434AbfLJPhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:37:40 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 83A5940235;
        Tue, 10 Dec 2019 15:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1575992259; bh=vfAJzCoYEGjQU8QTAYJK/QlCdujJtaY7VskjZ9rPM5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=XEi6lCqGMdd3T2IGhddQBury+QiF5TkH6hNbJ4y7lNvIi13n/JQLLRw4ZqjLyldyR
         oyhxnpDqqsqrBH69kbMa5XkXUUq0site474JYtSKJ512jlgsWA3y7Fgi0F6THfh43R
         5WxaotFHv3qXxVpqKLrK8bZC0g6rP/xyTBX/vkWyCDzy7HW67P+vGJ8CY0sYNvh+Wr
         ZdrgijYhYvSDTxLiGlOV6kirMdMnqLkXSwgCF2DTZfyOkX73AX+Rk/AWcdtx2xTgCr
         56T43BWNdrhsa37Q6wqOu4wIQPLKCCLZn9fHj+kxJQUQ4I2jm6csDRwZgXrdZMX8+y
         Ae8AMK5HLmvUw==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id E81CBA0082;
        Tue, 10 Dec 2019 15:37:36 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id B24DC3E2DC;
        Tue, 10 Dec 2019 16:37:36 +0100 (CET)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org
Cc:     Joao.Pinto@synopsys.com, bbrezillon@kernel.org,
        gregkh@linuxfoundation.org, wsa@the-dreams.de, arnd@arndb.de,
        broonie@kernel.org, Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [RFC 5/5] i3c: add i3cdev module to expose i3c dev in /dev
Date:   Tue, 10 Dec 2019 16:37:33 +0100
Message-Id: <f9f20eaf900ed5629dd3d824bc1e90c7e6b4a371.1575977795.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1575977795.git.vitor.soares@synopsys.com>
References: <cover.1575977795.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1575977795.git.vitor.soares@synopsys.com>
References: <cover.1575977795.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds user-mode support to I3C SDR transfers.

The module is based on i2c-dev.c with the following features:
  - expose on /dev the i3c devices dynamically based on if they have
    a device driver bound.
  - Dynamically allocate the char device Major number.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 drivers/i3c/Kconfig             |  15 ++
 drivers/i3c/Makefile            |   1 +
 drivers/i3c/i3cdev.c            | 438 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/i3c/i3cdev.h |  27 +++
 4 files changed, 481 insertions(+)
 create mode 100644 drivers/i3c/i3cdev.c
 create mode 100644 include/uapi/linux/i3c/i3cdev.h

diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index 30a4415..0164276 100644
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -20,5 +20,20 @@ menuconfig I3C
 	  will be called i3c.
 
 if I3C
+
+config I3CDEV
+	tristate "I3C device interface"
+	depends on I3C
+	help
+	  Say Y here to use i3c-* device files, usually found in the /dev
+	  directory on your system.  They make it possible to have user-space
+	  programs use the I3C devices.
+
+	  This support is also available as a module.  If so, the module
+	  will be called i3cdev.
+
+	  Note that this application programming interface is EXPERIMENTAL
+	  and hence SUBJECT TO CHANGE WITHOUT NOTICE while it stabilizes.
+
 source "drivers/i3c/master/Kconfig"
 endif # I3C
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index 11982ef..606d422 100644
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 i3c-y				:= device.o master.o
 obj-$(CONFIG_I3C)		+= i3c.o
+obj-$(CONFIG_I3CDEV)		+= i3cdev.o
 obj-$(CONFIG_I3C)		+= master/
diff --git a/drivers/i3c/i3cdev.c b/drivers/i3c/i3cdev.c
new file mode 100644
index 0000000..4d4b83c
--- /dev/null
+++ b/drivers/i3c/i3cdev.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Synopsys, Inc. and/or its affiliates.
+ *
+ * Author: Vitor Soares <soares@synopsys.com>
+ */
+
+#include <linux/cdev.h>
+#include <linux/compat.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <linux/i3c/i3cdev.h>
+
+#include "internals.h"
+
+#define I3C_MINORS	MINORMASK
+#define N_I3C_MINORS	16 /* For now */
+
+static DECLARE_BITMAP(minors, N_I3C_MINORS);
+
+struct i3cdev_data {
+	struct list_head list;
+	struct i3c_device *i3c;
+	struct cdev cdev;
+	struct device *dev;
+	dev_t devt;
+};
+
+static dev_t i3cdev_number; /* Alloted device number */
+
+static LIST_HEAD(i3cdev_list);
+static DEFINE_SPINLOCK(i3cdev_list_lock);
+
+static struct i3cdev_data *i3cdev_get_by_minor(unsigned int minor)
+{
+	struct i3cdev_data *i3cdev;
+
+	spin_lock(&i3cdev_list_lock);
+	list_for_each_entry(i3cdev, &i3cdev_list, list) {
+		if (MINOR(i3cdev->devt) == minor)
+			goto found;
+	}
+
+	i3cdev = NULL;
+
+found:
+	spin_unlock(&i3cdev_list_lock);
+	return i3cdev;
+}
+
+static struct i3cdev_data *i3cdev_get_by_i3c(struct i3c_device *i3c)
+{
+	struct i3cdev_data *i3cdev;
+
+	spin_lock(&i3cdev_list_lock);
+	list_for_each_entry(i3cdev, &i3cdev_list, list) {
+		if (i3cdev->i3c == i3c)
+			goto found;
+	}
+
+	i3cdev = NULL;
+
+found:
+	spin_unlock(&i3cdev_list_lock);
+	return i3cdev;
+}
+
+static struct i3cdev_data *get_free_i3cdev(struct i3c_device *i3c)
+{
+	struct i3cdev_data *i3cdev;
+	unsigned long minor;
+
+	minor = find_first_zero_bit(minors, N_I3C_MINORS);
+	if (minor >= N_I3C_MINORS) {
+		pr_err("i3cdev: no minor number available!\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	i3cdev = kzalloc(sizeof(*i3cdev), GFP_KERNEL);
+	if (!i3cdev)
+		return ERR_PTR(-ENOMEM);
+
+	i3cdev->i3c = i3c;
+	i3cdev->devt = MKDEV(MAJOR(i3cdev_number), minor);
+	set_bit(minor, minors);
+
+	spin_lock(&i3cdev_list_lock);
+	list_add_tail(&i3cdev->list, &i3cdev_list);
+	spin_unlock(&i3cdev_list_lock);
+
+	return i3cdev;
+}
+
+static void put_i3cdev(struct i3cdev_data *i3cdev)
+{
+	spin_lock(&i3cdev_list_lock);
+	list_del(&i3cdev->list);
+	spin_unlock(&i3cdev_list_lock);
+	kfree(i3cdev);
+}
+
+static ssize_t
+i3cdev_read(struct file *file, char __user *buf, size_t count, loff_t *f_pos)
+{
+	struct i3c_device *i3c = file->private_data;
+	struct i3c_priv_xfer xfers = {
+		.rnw = true,
+		.len = count,
+	};
+	char *tmp;
+	int ret;
+
+	tmp = kzalloc(count, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	xfers.data.in = tmp;
+
+	dev_dbg(&i3c->dev, "Reading %zu bytes.\n", count);
+
+	ret = i3c_device_do_priv_xfers(i3c, &xfers, 1);
+	if (!ret)
+		ret = copy_to_user(buf, tmp, count) ? -EFAULT : ret;
+
+	kfree(tmp);
+	return ret;
+}
+
+static ssize_t
+i3cdev_write(struct file *file, const char __user *buf, size_t count,
+	     loff_t *f_pos)
+{
+	struct i3c_device *i3c = file->private_data;
+	struct i3c_priv_xfer xfers = {
+		.rnw = false,
+		.len = count,
+	};
+	char *tmp;
+	int ret;
+
+	tmp = memdup_user(buf, count);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+
+	xfers.data.out = tmp;
+
+	dev_dbg(&i3c->dev, "Writing %zu bytes.\n", count);
+
+	ret = i3c_device_do_priv_xfers(i3c, &xfers, 1);
+	kfree(tmp);
+	return (!ret) ? count : ret;
+}
+
+static int
+i3cdev_do_priv_xfer(struct i3c_device *dev, struct i3c_priv_xfer *xfers,
+		    unsigned int nxfers)
+{
+	void __user **data_ptrs;
+	unsigned int i;
+	int ret = 0;
+
+	data_ptrs = kmalloc_array(nxfers, sizeof(*data_ptrs), GFP_KERNEL);
+	if (!data_ptrs)
+		return -ENOMEM;
+
+	for (i = 0; i < nxfers; i++) {
+		if (xfers[i].rnw) {
+			data_ptrs[i] = (void __user *)xfers[i].data.in;
+			xfers[i].data.in = memdup_user(data_ptrs[i],
+						       xfers[i].len);
+			if (IS_ERR(xfers[i].data.in)) {
+				ret = PTR_ERR(xfers[i].data.in);
+				break;
+			}
+		} else {
+			data_ptrs[i] = (void __user *)xfers[i].data.out;
+			xfers[i].data.out = memdup_user(data_ptrs[i],
+							xfers[i].len);
+			if (IS_ERR(xfers[i].data.out)) {
+				ret = PTR_ERR(xfers[i].data.out);
+				break;
+			}
+		}
+	}
+
+	if (ret < 0) {
+		unsigned int j;
+
+		for (j = 0; j < i; ++j) {
+			if (xfers[i].rnw)
+				kfree(xfers[i].data.in);
+			else
+				kfree(xfers[i].data.out);
+		}
+
+		kfree(data_ptrs);
+		return ret;
+	}
+
+	ret = i3c_device_do_priv_xfers(dev, xfers, nxfers);
+	while (i-- > 0) {
+		if (ret >= 0 && xfers[i].rnw) {
+			if (copy_to_user(data_ptrs[i], xfers[i].data.in,
+					 xfers[i].len))
+				ret = -EFAULT;
+		}
+
+		if (xfers[i].rnw)
+			kfree(xfers[i].data.in);
+		else
+			kfree(xfers[i].data.out);
+	}
+
+	kfree(data_ptrs);
+	return ret;
+}
+
+static int
+i3cdev_ioc_priv_xfer(struct i3c_device *i3c,
+		     struct i3c_ioc_priv_xfer __user *u_ioc_xfers)
+{
+	struct i3c_ioc_priv_xfer k_ioc_xfer;
+	struct i3c_priv_xfer *xfers;
+	int ret;
+
+	if (copy_from_user(&k_ioc_xfer, u_ioc_xfers, sizeof(k_ioc_xfer)))
+		return -EFAULT;
+
+	xfers = memdup_user(k_ioc_xfer.xfers,
+			    k_ioc_xfer.nxfers * sizeof(struct i3c_priv_xfer));
+	if (IS_ERR(xfers))
+		return PTR_ERR(xfers);
+
+	ret = i3cdev_do_priv_xfer(i3c, xfers, k_ioc_xfer.nxfers);
+	kfree(xfers);
+
+	return ret;
+}
+
+static long
+i3cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct i3c_device *i3c = file->private_data;
+
+	dev_dbg(&i3c->dev, "ioctl, cmd=0x%02x, arg=0x%02lx\n", cmd, arg);
+
+	if (_IOC_TYPE(cmd) != I3C_DEV_IOC_MAGIC)
+		return -ENOTTY;
+
+	if (cmd == I3C_IOC_PRIV_XFER)
+		return i3cdev_ioc_priv_xfer(i3c,
+					(struct i3c_ioc_priv_xfer __user *)arg);
+
+	return 0;
+}
+
+static int i3cdev_open(struct inode *inode, struct file *file)
+{
+	unsigned int minor = iminor(inode);
+	struct i3cdev_data *i3cdev;
+
+	i3cdev = i3cdev_get_by_minor(minor);
+	if (!i3cdev)
+		return -ENODEV;
+
+	file->private_data = i3cdev->i3c;
+
+	return 0;
+}
+
+static int i3cdev_release(struct inode *inode, struct file *file)
+{
+	file->private_data = NULL;
+
+	return 0;
+}
+
+static const struct file_operations i3cdev_fops = {
+	.owner		= THIS_MODULE,
+	.read		= i3cdev_read,
+	.write		= i3cdev_write,
+	.unlocked_ioctl	= i3cdev_ioctl,
+	.open		= i3cdev_open,
+	.release	= i3cdev_release,
+};
+
+/* ------------------------------------------------------------------------- */
+
+static struct class *i3cdev_class;
+
+static int i3cdev_attach(struct device *dev, void *dummy)
+{
+	struct i3c_device *i3c;
+	struct i3cdev_data *i3cdev;
+	int res;
+
+	if (dev->type == &i3c_masterdev_type || dev->driver)
+		return 0;
+
+	i3c = dev_to_i3cdev(dev);
+
+	/* Get a device */
+	i3cdev = get_free_i3cdev(i3c);
+	if (IS_ERR(i3cdev))
+		return PTR_ERR(i3cdev);
+
+	cdev_init(&i3cdev->cdev, &i3cdev_fops);
+	i3cdev->cdev.owner = THIS_MODULE;
+	res = cdev_add(&i3cdev->cdev, i3cdev->devt, 1);
+	if (res)
+		goto error_cdev;
+
+	/* register this i3c device with the driver core */
+	i3cdev->dev = device_create(i3cdev_class, &i3c->dev,
+				    i3cdev->devt, NULL,
+				    "i3c-%s", dev_name(&i3c->dev));
+	if (IS_ERR(i3cdev->dev)) {
+		res = PTR_ERR(i3cdev->dev);
+		goto error;
+	}
+	pr_debug("i3c-cdev: I3C device [%s] registered as minor %d\n",
+		 dev_name(&i3c->dev), MINOR(i3cdev->devt));
+	return 0;
+
+error:
+	cdev_del(&i3cdev->cdev);
+error_cdev:
+	put_i3cdev(i3cdev);
+	return res;
+}
+
+static int i3cdev_detach(struct device *dev, void *dummy)
+{
+	struct i3c_device *i3c;
+	struct i3cdev_data *i3cdev;
+
+	if (dev->type == &i3c_masterdev_type)
+		return 0;
+
+	i3c = dev_to_i3cdev(dev);
+
+	i3cdev = i3cdev_get_by_i3c(i3c);
+	if (!i3cdev)
+		return 0;
+
+	clear_bit(MINOR(i3cdev->devt), minors);
+	cdev_del(&i3cdev->cdev);
+	device_destroy(i3cdev_class, i3cdev->devt);
+	put_i3cdev(i3cdev);
+
+	pr_debug("i3c-busdev: bus [%s] unregistered\n",
+		 dev_name(&i3c->dev));
+
+	return 0;
+}
+
+static int i3cdev_notifier_call(struct notifier_block *nb,
+				unsigned long action,
+				void *data)
+{
+	struct device *dev = data;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		return i3cdev_attach(dev, NULL);
+	case BUS_NOTIFY_DEL_DEVICE:
+	case BUS_NOTIFY_BOUND_DRIVER:
+		return i3cdev_detach(dev, NULL);
+	}
+
+	return 0;
+}
+
+static struct notifier_block i3c_notifier = {
+	.notifier_call = i3cdev_notifier_call,
+};
+
+static int __init i3cdev_init(void)
+{
+	int res;
+
+	pr_info("i3c /dev entries driver\n");
+
+	/* Dynamically request unused major number */
+	res = alloc_chrdev_region(&i3cdev_number, 0, N_I3C_MINORS, "i3c");
+	if (res)
+		goto out;
+
+	/* Create a classe to populate sysfs entries*/
+	i3cdev_class = class_create(THIS_MODULE, "i3c-dev");
+	if (IS_ERR(i3cdev_class)) {
+		res = PTR_ERR(i3cdev_class);
+		goto out_unreg_chrdev;
+	}
+
+	/* Keep track of busses which have devices to add or remove later */
+	res = bus_register_notifier(&i3c_bus_type, &i3c_notifier);
+	if (res)
+		goto out_unreg_class;
+
+	/* Bind to already existing device without driver right away */
+	i3c_for_each_dev(NULL, i3cdev_attach);
+
+	return 0;
+
+out_unreg_class:
+	class_destroy(i3cdev_class);
+out_unreg_chrdev:
+	unregister_chrdev_region(i3cdev_number, I3C_MINORS);
+out:
+	pr_err("%s: Driver Initialisation failed\n", __FILE__);
+	return res;
+}
+
+static void __exit i3cdev_exit(void)
+{
+	bus_unregister_notifier(&i3c_bus_type, &i3c_notifier);
+	i3c_for_each_dev(NULL, i3cdev_detach);
+	class_destroy(i3cdev_class);
+	unregister_chrdev_region(i3cdev_number, I3C_MINORS);
+}
+
+MODULE_AUTHOR("Vitor Soares <soares@synopsys.com>");
+MODULE_DESCRIPTION("I3C /dev entries driver");
+MODULE_LICENSE("GPL");
+
+module_init(i3cdev_init);
+module_exit(i3cdev_exit);
diff --git a/include/uapi/linux/i3c/i3cdev.h b/include/uapi/linux/i3c/i3cdev.h
new file mode 100644
index 0000000..4030043
--- /dev/null
+++ b/include/uapi/linux/i3c/i3cdev.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 Synopsys, Inc. and/or its affiliates.
+ *
+ * Author: Vitor Soares <vitor.soares@synopsys.com>
+ */
+
+#ifndef _UAPI_I3C_DEV_H_
+#define _UAPI_I3C_DEV_H_
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/* IOCTL commands */
+#define I3C_DEV_IOC_MAGIC	0x07
+
+struct i3c_ioc_priv_xfer {
+	struct i3c_priv_xfer __user *xfers;	/* pointers to i3c_priv_xfer */
+	__u32 nxfers;				/* number of i3c_priv_xfer */
+};
+
+#define I3C_IOC_PRIV_XFER	\
+	_IOW(I3C_DEV_IOC_MAGIC, 30, struct i3c_ioc_priv_xfer)
+
+#define  I3C_IOC_PRIV_XFER_MAX_MSGS	42
+
+#endif
-- 
2.7.4

