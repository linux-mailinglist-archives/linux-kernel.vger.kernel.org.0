Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39BD6580A8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 12:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfF0Kk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 06:40:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45006 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbfF0Kk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 06:40:56 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 93DA5289A16
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 04/11] mfd: cros_ec: Switch to use the new cros-ec-chardev driver
Date:   Thu, 27 Jun 2019 12:40:32 +0200
Message-Id: <20190627104039.26285-5-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627104039.26285-1-enric.balletbo@collabora.com>
References: <20190627104039.26285-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the purpose of remove the things that far extends the bounds of
what a MFD was designed to do, instantiate the new platform misc
cros-ec-chardev driver and get rid of all the unneeded code. After this
patch the misc chardev driver is a sub-device of the MFD, and all the
new file operations should be implemented there.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Gwendal Grignou <gwendal@chromium.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mfd/cros_ec_dev.c   | 219 +-----------------------------------
 include/linux/mfd/cros_ec.h |   2 -
 2 files changed, 5 insertions(+), 216 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 3334bc4e42ee..8c5f1f10b8af 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -17,7 +17,6 @@
  * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <linux/fs.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/cros_ec.h>
 #include <linux/mfd/cros_ec_commands.h>
@@ -25,68 +24,15 @@
 #include <linux/mod_devicetable.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
-#include <linux/pm.h>
 #include <linux/slab.h>
-#include <linux/uaccess.h>
-
-#include <uapi/linux/cros_ec_chardev.h>
 
 #define DRV_NAME "cros-ec-dev"
 
-/* Device variables */
-#define CROS_MAX_DEV 128
-static int ec_major;
-
 static struct class cros_class = {
 	.owner          = THIS_MODULE,
 	.name           = "chromeos",
 };
 
-/* Basic communication */
-static int ec_get_version(struct cros_ec_dev *ec, char *str, int maxlen)
-{
-	struct ec_response_get_version *resp;
-	static const char * const current_image_name[] = {
-		"unknown", "read-only", "read-write", "invalid",
-	};
-	struct cros_ec_command *msg;
-	int ret;
-
-	msg = kmalloc(sizeof(*msg) + sizeof(*resp), GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	msg->version = 0;
-	msg->command = EC_CMD_GET_VERSION + ec->cmd_offset;
-	msg->insize = sizeof(*resp);
-	msg->outsize = 0;
-
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
-	if (ret < 0)
-		goto exit;
-
-	if (msg->result != EC_RES_SUCCESS) {
-		snprintf(str, maxlen,
-			 "%s\nUnknown EC version: EC returned %d\n",
-			 CROS_EC_DEV_VERSION, msg->result);
-		ret = -EINVAL;
-		goto exit;
-	}
-
-	resp = (struct ec_response_get_version *)msg->data;
-	if (resp->current_image >= ARRAY_SIZE(current_image_name))
-		resp->current_image = 3; /* invalid */
-
-	snprintf(str, maxlen, "%s\n%s\n%s\n%s\n", CROS_EC_DEV_VERSION,
-		 resp->version_string_ro, resp->version_string_rw,
-		 current_image_name[resp->current_image]);
-
-	ret = 0;
-exit:
-	kfree(msg);
-	return ret;
-}
-
 static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 {
 	struct cros_ec_command *msg;
@@ -122,142 +68,6 @@ static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 	return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
 }
 
-/* Device file ops */
-static int ec_device_open(struct inode *inode, struct file *filp)
-{
-	struct cros_ec_dev *ec = container_of(inode->i_cdev,
-					      struct cros_ec_dev, cdev);
-	filp->private_data = ec;
-	nonseekable_open(inode, filp);
-	return 0;
-}
-
-static int ec_device_release(struct inode *inode, struct file *filp)
-{
-	return 0;
-}
-
-static ssize_t ec_device_read(struct file *filp, char __user *buffer,
-			      size_t length, loff_t *offset)
-{
-	struct cros_ec_dev *ec = filp->private_data;
-	char msg[sizeof(struct ec_response_get_version) +
-		 sizeof(CROS_EC_DEV_VERSION)];
-	size_t count;
-	int ret;
-
-	if (*offset != 0)
-		return 0;
-
-	ret = ec_get_version(ec, msg, sizeof(msg));
-	if (ret)
-		return ret;
-
-	count = min(length, strlen(msg));
-
-	if (copy_to_user(buffer, msg, count))
-		return -EFAULT;
-
-	*offset = count;
-	return count;
-}
-
-/* Ioctls */
-static long ec_device_ioctl_xcmd(struct cros_ec_dev *ec, void __user *arg)
-{
-	long ret;
-	struct cros_ec_command u_cmd;
-	struct cros_ec_command *s_cmd;
-
-	if (copy_from_user(&u_cmd, arg, sizeof(u_cmd)))
-		return -EFAULT;
-
-	if ((u_cmd.outsize > EC_MAX_MSG_BYTES) ||
-	    (u_cmd.insize > EC_MAX_MSG_BYTES))
-		return -EINVAL;
-
-	s_cmd = kmalloc(sizeof(*s_cmd) + max(u_cmd.outsize, u_cmd.insize),
-			GFP_KERNEL);
-	if (!s_cmd)
-		return -ENOMEM;
-
-	if (copy_from_user(s_cmd, arg, sizeof(*s_cmd) + u_cmd.outsize)) {
-		ret = -EFAULT;
-		goto exit;
-	}
-
-	if (u_cmd.outsize != s_cmd->outsize ||
-	    u_cmd.insize != s_cmd->insize) {
-		ret = -EINVAL;
-		goto exit;
-	}
-
-	s_cmd->command += ec->cmd_offset;
-	ret = cros_ec_cmd_xfer(ec->ec_dev, s_cmd);
-	/* Only copy data to userland if data was received. */
-	if (ret < 0)
-		goto exit;
-
-	if (copy_to_user(arg, s_cmd, sizeof(*s_cmd) + s_cmd->insize))
-		ret = -EFAULT;
-exit:
-	kfree(s_cmd);
-	return ret;
-}
-
-static long ec_device_ioctl_readmem(struct cros_ec_dev *ec, void __user *arg)
-{
-	struct cros_ec_device *ec_dev = ec->ec_dev;
-	struct cros_ec_readmem s_mem = { };
-	long num;
-
-	/* Not every platform supports direct reads */
-	if (!ec_dev->cmd_readmem)
-		return -ENOTTY;
-
-	if (copy_from_user(&s_mem, arg, sizeof(s_mem)))
-		return -EFAULT;
-
-	num = ec_dev->cmd_readmem(ec_dev, s_mem.offset, s_mem.bytes,
-				  s_mem.buffer);
-	if (num <= 0)
-		return num;
-
-	if (copy_to_user((void __user *)arg, &s_mem, sizeof(s_mem)))
-		return -EFAULT;
-
-	return num;
-}
-
-static long ec_device_ioctl(struct file *filp, unsigned int cmd,
-			    unsigned long arg)
-{
-	struct cros_ec_dev *ec = filp->private_data;
-
-	if (_IOC_TYPE(cmd) != CROS_EC_DEV_IOC)
-		return -ENOTTY;
-
-	switch (cmd) {
-	case CROS_EC_DEV_IOCXCMD:
-		return ec_device_ioctl_xcmd(ec, (void __user *)arg);
-	case CROS_EC_DEV_IOCRDMEM:
-		return ec_device_ioctl_readmem(ec, (void __user *)arg);
-	}
-
-	return -ENOTTY;
-}
-
-/* Module initialization */
-static const struct file_operations fops = {
-	.open = ec_device_open,
-	.release = ec_device_release,
-	.read = ec_device_read,
-	.unlocked_ioctl = ec_device_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl = ec_device_ioctl,
-#endif
-};
-
 static void cros_ec_class_release(struct device *dev)
 {
 	kfree(to_cros_ec_dev(dev));
@@ -465,6 +275,7 @@ static const struct mfd_cell cros_usbpd_charger_cells[] = {
 };
 
 static const struct mfd_cell cros_ec_platform_cells[] = {
+	{ .name = "cros-ec-chardev" },
 	{ .name = "cros-ec-debugfs" },
 	{ .name = "cros-ec-lightbar" },
 	{ .name = "cros-ec-sysfs" },
@@ -492,7 +303,6 @@ static int ec_device_probe(struct platform_device *pdev)
 	ec->features[0] = -1U; /* Not cached yet */
 	ec->features[1] = -1U; /* Not cached yet */
 	device_initialize(&ec->class_dev);
-	cdev_init(&ec->cdev, &fops);
 
 	/* Check whether this is actually a Fingerprint MCU rather than an EC */
 	if (cros_ec_check_features(ec, EC_FEATURE_FINGERPRINT)) {
@@ -539,10 +349,7 @@ static int ec_device_probe(struct platform_device *pdev)
 
 	/*
 	 * Add the class device
-	 * Link to the character device for creating the /dev entry
-	 * in devtmpfs.
 	 */
-	ec->class_dev.devt = MKDEV(ec_major, pdev->id);
 	ec->class_dev.class = &cros_class;
 	ec->class_dev.parent = dev;
 	ec->class_dev.release = cros_ec_class_release;
@@ -553,6 +360,10 @@ static int ec_device_probe(struct platform_device *pdev)
 		goto failed;
 	}
 
+	retval = device_add(&ec->class_dev);
+	if (retval)
+		goto failed;
+
 	/* check whether this EC is a sensor hub. */
 	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
 		cros_ec_sensors_register(ec);
@@ -596,13 +407,6 @@ static int ec_device_probe(struct platform_device *pdev)
 				retval);
 	}
 
-	/* We can now add the sysfs class, we know which parameter to show */
-	retval = cdev_device_add(&ec->cdev, &ec->class_dev);
-	if (retval) {
-		dev_err(dev, "cdev_device_add failed => %d\n", retval);
-		goto failed;
-	}
-
 	retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
 				 cros_ec_platform_cells,
 				 ARRAY_SIZE(cros_ec_platform_cells),
@@ -636,7 +440,6 @@ static int ec_device_remove(struct platform_device *pdev)
 	struct cros_ec_dev *ec = dev_get_drvdata(&pdev->dev);
 
 	mfd_remove_devices(ec->dev);
-	cdev_del(&ec->cdev);
 	device_unregister(&ec->class_dev);
 	return 0;
 }
@@ -659,7 +462,6 @@ static struct platform_driver cros_ec_dev_driver = {
 static int __init cros_ec_dev_init(void)
 {
 	int ret;
-	dev_t dev = 0;
 
 	ret  = class_register(&cros_class);
 	if (ret) {
@@ -667,14 +469,6 @@ static int __init cros_ec_dev_init(void)
 		return ret;
 	}
 
-	/* Get a range of minor numbers (starting with 0) to work with */
-	ret = alloc_chrdev_region(&dev, 0, CROS_MAX_DEV, CROS_EC_DEV_NAME);
-	if (ret < 0) {
-		pr_err(CROS_EC_DEV_NAME ": alloc_chrdev_region() failed\n");
-		goto failed_chrdevreg;
-	}
-	ec_major = MAJOR(dev);
-
 	/* Register the driver */
 	ret = platform_driver_register(&cros_ec_dev_driver);
 	if (ret < 0) {
@@ -684,8 +478,6 @@ static int __init cros_ec_dev_init(void)
 	return 0;
 
 failed_devreg:
-	unregister_chrdev_region(MKDEV(ec_major, 0), CROS_MAX_DEV);
-failed_chrdevreg:
 	class_unregister(&cros_class);
 	return ret;
 }
@@ -693,7 +485,6 @@ static int __init cros_ec_dev_init(void)
 static void __exit cros_ec_dev_exit(void)
 {
 	platform_driver_unregister(&cros_ec_dev_driver);
-	unregister_chrdev(ec_major, CROS_EC_DEV_NAME);
 	class_unregister(&cros_class);
 }
 
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 669962ac392b..e7548530019e 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -199,7 +199,6 @@ struct cros_ec_debugfs;
 /**
  * struct cros_ec_dev - ChromeOS EC device entry point.
  * @class_dev: Device structure used in sysfs.
- * @cdev: Character device structure in /dev.
  * @ec_dev: cros_ec_device structure to talk to the physical device.
  * @dev: Pointer to the platform device.
  * @debug_info: cros_ec_debugfs structure for debugging information.
@@ -209,7 +208,6 @@ struct cros_ec_debugfs;
  */
 struct cros_ec_dev {
 	struct device class_dev;
-	struct cdev cdev;
 	struct cros_ec_device *ec_dev;
 	struct device *dev;
 	struct cros_ec_debugfs *debug_info;
-- 
2.20.1

