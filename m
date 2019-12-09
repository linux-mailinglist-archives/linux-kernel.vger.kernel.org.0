Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF151175ED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 20:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfLITdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 14:33:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfLITd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:33:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8539206E0;
        Mon,  9 Dec 2019 19:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575920008;
        bh=BToz5JHrjUWsUPJ/3ovCQ8vpI4jT63sQyRRUO6Nlgok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A0kjUcB75uFR4u4UJ/HW0FLnhGRvnXIAJ0OXOrIJ0IJ65qXXL0lA4gg2owDg3yS5Z
         wazrAUGXyOp8fk+RWn20jINIctqJjTApf/J3Xm8/0LrrDyjSqiYMY/RopgapV6lpxD
         laUS4/7cTOmyHO7iCAHhqG0impqviNTmVG7Wh84Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 5/6] device.h: move 'struct class' stuff out to device/class.h
Date:   Mon,  9 Dec 2019 20:33:02 +0100
Message-Id: <20191209193303.1694546-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209193303.1694546-1-gregkh@linuxfoundation.org>
References: <20191209193303.1694546-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device.h has everything and the kitchen sink when it comes to struct
device things, so split out the struct class things things to a separate
.h file to make things easier to maintain and manage over time.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/class.c         |   1 +
 include/linux/device.h       | 241 +------------------------------
 include/linux/device/class.h | 266 +++++++++++++++++++++++++++++++++++
 3 files changed, 268 insertions(+), 240 deletions(-)
 create mode 100644 include/linux/device/class.h

diff --git a/drivers/base/class.c b/drivers/base/class.c
index d8a6a5864c2e..bcd410e6d70a 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -8,6 +8,7 @@
  * Copyright (c) 2003-2004 IBM Corp.
  */
 
+#include <linux/device/class.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/include/linux/device.h b/include/linux/device.h
index cb0ea7e66d53..2d697159bfbc 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -27,6 +27,7 @@
 #include <linux/gfp.h>
 #include <linux/overflow.h>
 #include <linux/device/bus.h>
+#include <linux/device/class.h>
 #include <asm/device.h>
 
 struct device;
@@ -294,246 +295,6 @@ int subsys_system_register(struct bus_type *subsys,
 int subsys_virtual_register(struct bus_type *subsys,
 			    const struct attribute_group **groups);
 
-/**
- * struct class - device classes
- * @name:	Name of the class.
- * @owner:	The module owner.
- * @class_groups: Default attributes of this class.
- * @dev_groups:	Default attributes of the devices that belong to the class.
- * @dev_kobj:	The kobject that represents this class and links it into the hierarchy.
- * @dev_uevent:	Called when a device is added, removed from this class, or a
- *		few other things that generate uevents to add the environment
- *		variables.
- * @devnode:	Callback to provide the devtmpfs.
- * @class_release: Called to release this class.
- * @dev_release: Called to release the device.
- * @shutdown_pre: Called at shut-down time before driver shutdown.
- * @ns_type:	Callbacks so sysfs can detemine namespaces.
- * @namespace:	Namespace of the device belongs to this class.
- * @get_ownership: Allows class to specify uid/gid of the sysfs directories
- *		for the devices belonging to the class. Usually tied to
- *		device's namespace.
- * @pm:		The default device power management operations of this class.
- * @p:		The private data of the driver core, no one other than the
- *		driver core can touch this.
- *
- * A class is a higher-level view of a device that abstracts out low-level
- * implementation details. Drivers may see a SCSI disk or an ATA disk, but,
- * at the class level, they are all simply disks. Classes allow user space
- * to work with devices based on what they do, rather than how they are
- * connected or how they work.
- */
-struct class {
-	const char		*name;
-	struct module		*owner;
-
-	const struct attribute_group	**class_groups;
-	const struct attribute_group	**dev_groups;
-	struct kobject			*dev_kobj;
-
-	int (*dev_uevent)(struct device *dev, struct kobj_uevent_env *env);
-	char *(*devnode)(struct device *dev, umode_t *mode);
-
-	void (*class_release)(struct class *class);
-	void (*dev_release)(struct device *dev);
-
-	int (*shutdown_pre)(struct device *dev);
-
-	const struct kobj_ns_type_operations *ns_type;
-	const void *(*namespace)(struct device *dev);
-
-	void (*get_ownership)(struct device *dev, kuid_t *uid, kgid_t *gid);
-
-	const struct dev_pm_ops *pm;
-
-	struct subsys_private *p;
-};
-
-struct class_dev_iter {
-	struct klist_iter		ki;
-	const struct device_type	*type;
-};
-
-extern struct kobject *sysfs_dev_block_kobj;
-extern struct kobject *sysfs_dev_char_kobj;
-extern int __must_check __class_register(struct class *class,
-					 struct lock_class_key *key);
-extern void class_unregister(struct class *class);
-
-/* This is a #define to keep the compiler from merging different
- * instances of the __key variable */
-#define class_register(class)			\
-({						\
-	static struct lock_class_key __key;	\
-	__class_register(class, &__key);	\
-})
-
-struct class_compat;
-struct class_compat *class_compat_register(const char *name);
-void class_compat_unregister(struct class_compat *cls);
-int class_compat_create_link(struct class_compat *cls, struct device *dev,
-			     struct device *device_link);
-void class_compat_remove_link(struct class_compat *cls, struct device *dev,
-			      struct device *device_link);
-
-extern void class_dev_iter_init(struct class_dev_iter *iter,
-				struct class *class,
-				struct device *start,
-				const struct device_type *type);
-extern struct device *class_dev_iter_next(struct class_dev_iter *iter);
-extern void class_dev_iter_exit(struct class_dev_iter *iter);
-
-extern int class_for_each_device(struct class *class, struct device *start,
-				 void *data,
-				 int (*fn)(struct device *dev, void *data));
-extern struct device *class_find_device(struct class *class,
-					struct device *start, const void *data,
-					int (*match)(struct device *, const void *));
-
-/**
- * class_find_device_by_name - device iterator for locating a particular device
- * of a specific name.
- * @class: class type
- * @name: name of the device to match
- */
-static inline struct device *class_find_device_by_name(struct class *class,
-						       const char *name)
-{
-	return class_find_device(class, NULL, name, device_match_name);
-}
-
-/**
- * class_find_device_by_of_node : device iterator for locating a particular device
- * matching the of_node.
- * @class: class type
- * @np: of_node of the device to match.
- */
-static inline struct device *
-class_find_device_by_of_node(struct class *class, const struct device_node *np)
-{
-	return class_find_device(class, NULL, np, device_match_of_node);
-}
-
-/**
- * class_find_device_by_fwnode : device iterator for locating a particular device
- * matching the fwnode.
- * @class: class type
- * @fwnode: fwnode of the device to match.
- */
-static inline struct device *
-class_find_device_by_fwnode(struct class *class,
-			    const struct fwnode_handle *fwnode)
-{
-	return class_find_device(class, NULL, fwnode, device_match_fwnode);
-}
-
-/**
- * class_find_device_by_devt : device iterator for locating a particular device
- * matching the device type.
- * @class: class type
- * @devt: device type of the device to match.
- */
-static inline struct device *class_find_device_by_devt(struct class *class,
-						       dev_t devt)
-{
-	return class_find_device(class, NULL, &devt, device_match_devt);
-}
-
-#ifdef CONFIG_ACPI
-struct acpi_device;
-/**
- * class_find_device_by_acpi_dev : device iterator for locating a particular
- * device matching the ACPI_COMPANION device.
- * @class: class type
- * @adev: ACPI_COMPANION device to match.
- */
-static inline struct device *
-class_find_device_by_acpi_dev(struct class *class, const struct acpi_device *adev)
-{
-	return class_find_device(class, NULL, adev, device_match_acpi_dev);
-}
-#else
-static inline struct device *
-class_find_device_by_acpi_dev(struct class *class, const void *adev)
-{
-	return NULL;
-}
-#endif
-
-struct class_attribute {
-	struct attribute attr;
-	ssize_t (*show)(struct class *class, struct class_attribute *attr,
-			char *buf);
-	ssize_t (*store)(struct class *class, struct class_attribute *attr,
-			const char *buf, size_t count);
-};
-
-#define CLASS_ATTR_RW(_name) \
-	struct class_attribute class_attr_##_name = __ATTR_RW(_name)
-#define CLASS_ATTR_RO(_name) \
-	struct class_attribute class_attr_##_name = __ATTR_RO(_name)
-#define CLASS_ATTR_WO(_name) \
-	struct class_attribute class_attr_##_name = __ATTR_WO(_name)
-
-extern int __must_check class_create_file_ns(struct class *class,
-					     const struct class_attribute *attr,
-					     const void *ns);
-extern void class_remove_file_ns(struct class *class,
-				 const struct class_attribute *attr,
-				 const void *ns);
-
-static inline int __must_check class_create_file(struct class *class,
-					const struct class_attribute *attr)
-{
-	return class_create_file_ns(class, attr, NULL);
-}
-
-static inline void class_remove_file(struct class *class,
-				     const struct class_attribute *attr)
-{
-	return class_remove_file_ns(class, attr, NULL);
-}
-
-/* Simple class attribute that is just a static string */
-struct class_attribute_string {
-	struct class_attribute attr;
-	char *str;
-};
-
-/* Currently read-only only */
-#define _CLASS_ATTR_STRING(_name, _mode, _str) \
-	{ __ATTR(_name, _mode, show_class_attr_string, NULL), _str }
-#define CLASS_ATTR_STRING(_name, _mode, _str) \
-	struct class_attribute_string class_attr_##_name = \
-		_CLASS_ATTR_STRING(_name, _mode, _str)
-
-extern ssize_t show_class_attr_string(struct class *class, struct class_attribute *attr,
-                        char *buf);
-
-struct class_interface {
-	struct list_head	node;
-	struct class		*class;
-
-	int (*add_dev)		(struct device *, struct class_interface *);
-	void (*remove_dev)	(struct device *, struct class_interface *);
-};
-
-extern int __must_check class_interface_register(struct class_interface *);
-extern void class_interface_unregister(struct class_interface *);
-
-extern struct class * __must_check __class_create(struct module *owner,
-						  const char *name,
-						  struct lock_class_key *key);
-extern void class_destroy(struct class *cls);
-
-/* This is a #define to keep the compiler from merging different
- * instances of the __key variable */
-#define class_create(owner, name)		\
-({						\
-	static struct lock_class_key __key;	\
-	__class_create(owner, name, &__key);	\
-})
-
 /*
  * The type of device, "struct device" is embedded in. A class
  * or bus can contain devices of different types
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
new file mode 100644
index 000000000000..e8d470c457d1
--- /dev/null
+++ b/include/linux/device/class.h
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The class-specific portions of the driver model
+ *
+ * Copyright (c) 2001-2003 Patrick Mochel <mochel@osdl.org>
+ * Copyright (c) 2004-2009 Greg Kroah-Hartman <gregkh@suse.de>
+ * Copyright (c) 2008-2009 Novell Inc.
+ * Copyright (c) 2012-2019 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+ * Copyright (c) 2012-2019 Linux Foundation
+ *
+ * See Documentation/driver-api/driver-model/ for more information.
+ */
+
+#ifndef _DEVICE_CLASS_H_
+#define _DEVICE_CLASS_H_
+
+#include <linux/kobject.h>
+#include <linux/klist.h>
+#include <linux/pm.h>
+#include <linux/device/bus.h>
+
+struct device;
+struct fwnode_handle;
+
+/**
+ * struct class - device classes
+ * @name:	Name of the class.
+ * @owner:	The module owner.
+ * @class_groups: Default attributes of this class.
+ * @dev_groups:	Default attributes of the devices that belong to the class.
+ * @dev_kobj:	The kobject that represents this class and links it into the hierarchy.
+ * @dev_uevent:	Called when a device is added, removed from this class, or a
+ *		few other things that generate uevents to add the environment
+ *		variables.
+ * @devnode:	Callback to provide the devtmpfs.
+ * @class_release: Called to release this class.
+ * @dev_release: Called to release the device.
+ * @shutdown_pre: Called at shut-down time before driver shutdown.
+ * @ns_type:	Callbacks so sysfs can detemine namespaces.
+ * @namespace:	Namespace of the device belongs to this class.
+ * @get_ownership: Allows class to specify uid/gid of the sysfs directories
+ *		for the devices belonging to the class. Usually tied to
+ *		device's namespace.
+ * @pm:		The default device power management operations of this class.
+ * @p:		The private data of the driver core, no one other than the
+ *		driver core can touch this.
+ *
+ * A class is a higher-level view of a device that abstracts out low-level
+ * implementation details. Drivers may see a SCSI disk or an ATA disk, but,
+ * at the class level, they are all simply disks. Classes allow user space
+ * to work with devices based on what they do, rather than how they are
+ * connected or how they work.
+ */
+struct class {
+	const char		*name;
+	struct module		*owner;
+
+	const struct attribute_group	**class_groups;
+	const struct attribute_group	**dev_groups;
+	struct kobject			*dev_kobj;
+
+	int (*dev_uevent)(struct device *dev, struct kobj_uevent_env *env);
+	char *(*devnode)(struct device *dev, umode_t *mode);
+
+	void (*class_release)(struct class *class);
+	void (*dev_release)(struct device *dev);
+
+	int (*shutdown_pre)(struct device *dev);
+
+	const struct kobj_ns_type_operations *ns_type;
+	const void *(*namespace)(struct device *dev);
+
+	void (*get_ownership)(struct device *dev, kuid_t *uid, kgid_t *gid);
+
+	const struct dev_pm_ops *pm;
+
+	struct subsys_private *p;
+};
+
+struct class_dev_iter {
+	struct klist_iter		ki;
+	const struct device_type	*type;
+};
+
+extern struct kobject *sysfs_dev_block_kobj;
+extern struct kobject *sysfs_dev_char_kobj;
+extern int __must_check __class_register(struct class *class,
+					 struct lock_class_key *key);
+extern void class_unregister(struct class *class);
+
+/* This is a #define to keep the compiler from merging different
+ * instances of the __key variable */
+#define class_register(class)			\
+({						\
+	static struct lock_class_key __key;	\
+	__class_register(class, &__key);	\
+})
+
+struct class_compat;
+struct class_compat *class_compat_register(const char *name);
+void class_compat_unregister(struct class_compat *cls);
+int class_compat_create_link(struct class_compat *cls, struct device *dev,
+			     struct device *device_link);
+void class_compat_remove_link(struct class_compat *cls, struct device *dev,
+			      struct device *device_link);
+
+extern void class_dev_iter_init(struct class_dev_iter *iter,
+				struct class *class,
+				struct device *start,
+				const struct device_type *type);
+extern struct device *class_dev_iter_next(struct class_dev_iter *iter);
+extern void class_dev_iter_exit(struct class_dev_iter *iter);
+
+extern int class_for_each_device(struct class *class, struct device *start,
+				 void *data,
+				 int (*fn)(struct device *dev, void *data));
+extern struct device *class_find_device(struct class *class,
+					struct device *start, const void *data,
+					int (*match)(struct device *, const void *));
+
+/**
+ * class_find_device_by_name - device iterator for locating a particular device
+ * of a specific name.
+ * @class: class type
+ * @name: name of the device to match
+ */
+static inline struct device *class_find_device_by_name(struct class *class,
+						       const char *name)
+{
+	return class_find_device(class, NULL, name, device_match_name);
+}
+
+/**
+ * class_find_device_by_of_node : device iterator for locating a particular device
+ * matching the of_node.
+ * @class: class type
+ * @np: of_node of the device to match.
+ */
+static inline struct device *
+class_find_device_by_of_node(struct class *class, const struct device_node *np)
+{
+	return class_find_device(class, NULL, np, device_match_of_node);
+}
+
+/**
+ * class_find_device_by_fwnode : device iterator for locating a particular device
+ * matching the fwnode.
+ * @class: class type
+ * @fwnode: fwnode of the device to match.
+ */
+static inline struct device *
+class_find_device_by_fwnode(struct class *class,
+			    const struct fwnode_handle *fwnode)
+{
+	return class_find_device(class, NULL, fwnode, device_match_fwnode);
+}
+
+/**
+ * class_find_device_by_devt : device iterator for locating a particular device
+ * matching the device type.
+ * @class: class type
+ * @devt: device type of the device to match.
+ */
+static inline struct device *class_find_device_by_devt(struct class *class,
+						       dev_t devt)
+{
+	return class_find_device(class, NULL, &devt, device_match_devt);
+}
+
+#ifdef CONFIG_ACPI
+struct acpi_device;
+/**
+ * class_find_device_by_acpi_dev : device iterator for locating a particular
+ * device matching the ACPI_COMPANION device.
+ * @class: class type
+ * @adev: ACPI_COMPANION device to match.
+ */
+static inline struct device *
+class_find_device_by_acpi_dev(struct class *class, const struct acpi_device *adev)
+{
+	return class_find_device(class, NULL, adev, device_match_acpi_dev);
+}
+#else
+static inline struct device *
+class_find_device_by_acpi_dev(struct class *class, const void *adev)
+{
+	return NULL;
+}
+#endif
+
+struct class_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct class *class, struct class_attribute *attr,
+			char *buf);
+	ssize_t (*store)(struct class *class, struct class_attribute *attr,
+			const char *buf, size_t count);
+};
+
+#define CLASS_ATTR_RW(_name) \
+	struct class_attribute class_attr_##_name = __ATTR_RW(_name)
+#define CLASS_ATTR_RO(_name) \
+	struct class_attribute class_attr_##_name = __ATTR_RO(_name)
+#define CLASS_ATTR_WO(_name) \
+	struct class_attribute class_attr_##_name = __ATTR_WO(_name)
+
+extern int __must_check class_create_file_ns(struct class *class,
+					     const struct class_attribute *attr,
+					     const void *ns);
+extern void class_remove_file_ns(struct class *class,
+				 const struct class_attribute *attr,
+				 const void *ns);
+
+static inline int __must_check class_create_file(struct class *class,
+					const struct class_attribute *attr)
+{
+	return class_create_file_ns(class, attr, NULL);
+}
+
+static inline void class_remove_file(struct class *class,
+				     const struct class_attribute *attr)
+{
+	return class_remove_file_ns(class, attr, NULL);
+}
+
+/* Simple class attribute that is just a static string */
+struct class_attribute_string {
+	struct class_attribute attr;
+	char *str;
+};
+
+/* Currently read-only only */
+#define _CLASS_ATTR_STRING(_name, _mode, _str) \
+	{ __ATTR(_name, _mode, show_class_attr_string, NULL), _str }
+#define CLASS_ATTR_STRING(_name, _mode, _str) \
+	struct class_attribute_string class_attr_##_name = \
+		_CLASS_ATTR_STRING(_name, _mode, _str)
+
+extern ssize_t show_class_attr_string(struct class *class, struct class_attribute *attr,
+                        char *buf);
+
+struct class_interface {
+	struct list_head	node;
+	struct class		*class;
+
+	int (*add_dev)		(struct device *, struct class_interface *);
+	void (*remove_dev)	(struct device *, struct class_interface *);
+};
+
+extern int __must_check class_interface_register(struct class_interface *);
+extern void class_interface_unregister(struct class_interface *);
+
+extern struct class * __must_check __class_create(struct module *owner,
+						  const char *name,
+						  struct lock_class_key *key);
+extern void class_destroy(struct class *cls);
+
+/* This is a #define to keep the compiler from merging different
+ * instances of the __key variable */
+#define class_create(owner, name)		\
+({						\
+	static struct lock_class_key __key;	\
+	__class_create(owner, name, &__key);	\
+})
+
+
+#endif	/* _DEVICE_CLASS_H_ */
-- 
2.24.0

