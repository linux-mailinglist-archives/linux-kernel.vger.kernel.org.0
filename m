Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B014110F5C3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 04:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfLCDsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 22:48:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726932AbfLCDsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 22:48:32 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB33klU3109381
        for <linux-kernel@vger.kernel.org>; Mon, 2 Dec 2019 22:48:31 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wm6v00ygk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 22:48:31 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Tue, 3 Dec 2019 03:48:28 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Dec 2019 03:48:19 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB33mIal46202948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Dec 2019 03:48:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91B76A404D;
        Tue,  3 Dec 2019 03:48:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0202A4059;
        Tue,  3 Dec 2019 03:48:17 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Dec 2019 03:48:17 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 5F1CDA03E7;
        Tue,  3 Dec 2019 14:48:13 +1100 (AEDT)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Subject: [PATCH v2 19/27] nvdimm/ocxl: Forward events to userspace
Date:   Tue,  3 Dec 2019 14:46:47 +1100
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191203034655.51561-1-alastair@au1.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120303-0020-0000-0000-00000392CC5B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120303-0021-0000-0000-000021E9EAAA
Message-Id: <20191203034655.51561-20-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_06:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 bulkscore=2
 suspectscore=3 lowpriorityscore=2 mlxlogscore=885 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912030032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

Some of the interrupts that the card generates are better handled
by the userspace daemon, in particular:
Controller Hardware/Firmware Fatal
Controller Dump Available
Error Log available

This patch allows a userspace application to register an eventfd with
the driver via SCM_IOCTL_EVENTFD to receive notifications of these
interrupts.

Userspace can then identify what events have occurred by calling
SCM_IOCTL_EVENT_CHECK and checking against the SCM_IOCTL_EVENT_FOO
masks.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/nvdimm/ocxl/scm.c          | 216 +++++++++++++++++++++++++++++
 drivers/nvdimm/ocxl/scm_internal.h |   5 +
 include/uapi/nvdimm/ocxl-scm.h     |  16 +++
 3 files changed, 237 insertions(+)

diff --git a/drivers/nvdimm/ocxl/scm.c b/drivers/nvdimm/ocxl/scm.c
index 54a2bac1cab7..854787950334 100644
--- a/drivers/nvdimm/ocxl/scm.c
+++ b/drivers/nvdimm/ocxl/scm.c
@@ -9,6 +9,7 @@
 #include <misc/ocxl.h>
 #include <linux/delay.h>
 #include <linux/ndctl.h>
+#include <linux/eventfd.h>
 #include <linux/fs.h>
 #include <linux/mm_types.h>
 #include <linux/memory_hotplug.h>
@@ -382,11 +383,22 @@ static void free_scm(struct scm_data *scm_data)
 {
 	int rc;
 
+	// Disable doorbells
+	(void)ocxl_global_mmio_set64(scm_data->ocxl_afu, GLOBAL_MMIO_CHIEC,
+				     OCXL_LITTLE_ENDIAN,
+				     GLOBAL_MMIO_CHI_ALL);
+
 	if (scm_data->nvdimm_bus)
 		nvdimm_bus_unregister(scm_data->nvdimm_bus);
 
 	free_scm_minor(scm_data);
 
+	if (scm_data->irq_addr[1])
+		iounmap(scm_data->irq_addr[1]);
+
+	if (scm_data->irq_addr[0])
+		iounmap(scm_data->irq_addr[0]);
+
 	if (scm_data->cdev.owner)
 		cdev_del(&scm_data->cdev);
 
@@ -491,6 +503,11 @@ static int scm_file_release(struct inode *inode, struct file *file)
 {
 	struct scm_data *scm_data = file->private_data;
 
+	if (scm_data->ev_ctx) {
+		eventfd_ctx_put(scm_data->ev_ctx);
+		scm_data->ev_ctx = NULL;
+	}
+
 	scm_put(scm_data);
 	return 0;
 }
@@ -986,6 +1003,51 @@ static int scm_ioctl_controller_stats(struct scm_data *scm_data,
 	return rc;
 }
 
+static int scm_ioctl_eventfd(struct scm_data *scm_data,
+			     struct scm_ioctl_eventfd __user *uarg)
+{
+	struct scm_ioctl_eventfd args;
+
+	if (copy_from_user(&args, uarg, sizeof(args)))
+		return -EFAULT;
+
+	if (scm_data->ev_ctx)
+		return -EINVAL;
+
+	scm_data->ev_ctx = eventfd_ctx_fdget(args.eventfd);
+	if (!scm_data->ev_ctx)
+		return -EFAULT;
+
+	return 0;
+}
+
+static int scm_ioctl_event_check(struct scm_data *scm_data, u64 __user *uarg)
+{
+	u64 val = 0;
+	int rc;
+	u64 chi = 0;
+
+	rc = scm_chi(scm_data, &chi);
+	if (rc < 0)
+		return rc;
+
+	if (chi & GLOBAL_MMIO_CHI_ELA)
+		val |= SCM_IOCTL_EVENT_ERROR_LOG_AVAILABLE;
+
+	if (chi & GLOBAL_MMIO_CHI_CDA)
+		val |= SCM_IOCTL_EVENT_CONTROLLER_DUMP_AVAILABLE;
+
+	if (chi & GLOBAL_MMIO_CHI_CFFS)
+		val |= SCM_IOCTL_EVENT_FIRMWARE_FATAL;
+
+	if (chi & GLOBAL_MMIO_CHI_CHFS)
+		val |= SCM_IOCTL_EVENT_HARDWARE_FATAL;
+
+	rc = copy_to_user((u64 __user *) uarg, &val, sizeof(val));
+
+	return rc;
+}
+
 static long scm_file_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long args)
 {
@@ -1015,6 +1077,15 @@ static long scm_file_ioctl(struct file *file, unsigned int cmd,
 		rc = scm_ioctl_controller_stats(scm_data,
 						(struct scm_ioctl_controller_stats __user *)args);
 		break;
+
+	case SCM_IOCTL_EVENTFD:
+		rc = scm_ioctl_eventfd(scm_data,
+				       (struct scm_ioctl_eventfd __user *)args);
+		break;
+
+	case SCM_IOCTL_EVENT_CHECK:
+		rc = scm_ioctl_event_check(scm_data, (u64 __user *)args);
+		break;
 	}
 
 	return rc;
@@ -1156,6 +1227,146 @@ static void scm_dump_error_log(struct scm_data *scm_data)
 	kfree(buf);
 }
 
+static irqreturn_t scm_imn0_handler(void *private)
+{
+	struct scm_data *scm_data = private;
+	u64 chi = 0;
+
+	(void)scm_chi(scm_data, &chi);
+
+	if (chi & GLOBAL_MMIO_CHI_ELA) {
+		dev_warn(&scm_data->dev, "Error log is available\n");
+
+		if (scm_data->ev_ctx)
+			eventfd_signal(scm_data->ev_ctx, 1);
+	}
+
+	if (chi & GLOBAL_MMIO_CHI_CDA) {
+		dev_warn(&scm_data->dev, "Controller dump is available\n");
+
+		if (scm_data->ev_ctx)
+			eventfd_signal(scm_data->ev_ctx, 1);
+	}
+
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t scm_imn1_handler(void *private)
+{
+	struct scm_data *scm_data = private;
+	u64 chi = 0;
+
+	(void)scm_chi(scm_data, &chi);
+
+	if (chi & (GLOBAL_MMIO_CHI_CFFS | GLOBAL_MMIO_CHI_CHFS)) {
+		dev_err(&scm_data->dev,
+			"Controller status is fatal, chi=0x%llx, going offline\n", chi);
+
+		if (scm_data->nvdimm_bus) {
+			nvdimm_bus_unregister(scm_data->nvdimm_bus);
+			scm_data->nvdimm_bus = NULL;
+		}
+
+		if (scm_data->ev_ctx)
+			eventfd_signal(scm_data->ev_ctx, 1);
+	}
+
+	return IRQ_HANDLED;
+}
+
+
+/**
+ * scm_setup_irq() - Set up the IRQs for the SCM device
+ * @scm_data: the SCM metadata
+ * Return: 0 on success, negative on failure
+ */
+static int scm_setup_irq(struct scm_data *scm_data)
+{
+	int rc;
+	u64 irq_addr;
+
+	rc = ocxl_afu_irq_alloc(scm_data->ocxl_context, &scm_data->irq_id[0]);
+	if (rc)
+		return rc;
+
+	rc = ocxl_irq_set_handler(scm_data->ocxl_context, scm_data->irq_id[0],
+				  scm_imn0_handler, NULL, scm_data);
+
+	irq_addr = ocxl_afu_irq_get_addr(scm_data->ocxl_context, scm_data->irq_id[0]);
+	if (!irq_addr)
+		return -EINVAL;
+
+	scm_data->irq_addr[0] = ioremap(irq_addr, PAGE_SIZE);
+	if (!scm_data->irq_addr[0])
+		return -EINVAL;
+
+	rc = ocxl_global_mmio_write64(scm_data->ocxl_afu, GLOBAL_MMIO_IMA0_OHP,
+				      OCXL_LITTLE_ENDIAN,
+				      (u64)scm_data->irq_addr[0]);
+	if (rc)
+		goto out_irq0;
+
+	rc = ocxl_global_mmio_write64(scm_data->ocxl_afu, GLOBAL_MMIO_IMA0_CFP,
+				      OCXL_LITTLE_ENDIAN, 0);
+	if (rc)
+		goto out_irq0;
+
+	rc = ocxl_afu_irq_alloc(scm_data->ocxl_context, &scm_data->irq_id[1]);
+	if (rc)
+		goto out_irq0;
+
+
+	rc = ocxl_irq_set_handler(scm_data->ocxl_context, scm_data->irq_id[1],
+				  scm_imn1_handler, NULL, scm_data);
+	if (rc)
+		goto out_irq0;
+
+	irq_addr = ocxl_afu_irq_get_addr(scm_data->ocxl_context, scm_data->irq_id[1]);
+	if (!irq_addr) {
+		rc = -EFAULT;
+		goto out_irq0;
+	}
+
+	scm_data->irq_addr[1] = ioremap(irq_addr, PAGE_SIZE);
+	if (!scm_data->irq_addr[1]) {
+		rc = -EINVAL;
+		goto out_irq0;
+	}
+
+	rc = ocxl_global_mmio_write64(scm_data->ocxl_afu, GLOBAL_MMIO_IMA1_OHP,
+				      OCXL_LITTLE_ENDIAN,
+				      (u64)scm_data->irq_addr[1]);
+	if (rc)
+		goto out_irq1;
+
+	rc = ocxl_global_mmio_write64(scm_data->ocxl_afu, GLOBAL_MMIO_IMA1_CFP,
+				      OCXL_LITTLE_ENDIAN, 0);
+	if (rc)
+		goto out_irq1;
+
+	// Enable doorbells
+	rc = ocxl_global_mmio_set64(scm_data->ocxl_afu, GLOBAL_MMIO_CHIE,
+				    OCXL_LITTLE_ENDIAN,
+				    GLOBAL_MMIO_CHI_ELA | GLOBAL_MMIO_CHI_CDA |
+				    GLOBAL_MMIO_CHI_CFFS | GLOBAL_MMIO_CHI_CHFS |
+				    GLOBAL_MMIO_CHI_NSCRA);
+	if (rc)
+		goto out_irq1;
+
+	return 0;
+
+out_irq1:
+	iounmap(scm_data->irq_addr[1]);
+	scm_data->irq_addr[1] = NULL;
+
+out_irq0:
+	iounmap(scm_data->irq_addr[0]);
+	scm_data->irq_addr[0] = NULL;
+
+	return rc;
+}
+
 /**
  * scm_probe_function_0 - Set up function 0 for an OpenCAPI Storage Class Memory device
  * This is important as it enables templates higher than 0 across all other functions,
@@ -1261,6 +1472,11 @@ static int scm_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err;
 	}
 
+	if (scm_setup_irq(scm_data)) {
+		dev_err(&pdev->dev, "Could not set up OCXL IRQs for SCM\n");
+		goto err;
+	}
+
 	if (scm_setup_command_metadata(scm_data)) {
 		dev_err(&pdev->dev, "Could not read OCXL command matada\n");
 		goto err;
diff --git a/drivers/nvdimm/ocxl/scm_internal.h b/drivers/nvdimm/ocxl/scm_internal.h
index 9bf8fcf30ea6..693fd59f8bde 100644
--- a/drivers/nvdimm/ocxl/scm_internal.h
+++ b/drivers/nvdimm/ocxl/scm_internal.h
@@ -104,6 +104,10 @@ struct scm_data {
 	struct pci_dev *pdev;
 	struct cdev cdev;
 	struct ocxl_fn *ocxl_fn;
+#define SCM_IRQ_COUNT 2
+	int irq_id[SCM_IRQ_COUNT];
+	struct dev_pagemap irq_pgmap[SCM_IRQ_COUNT];
+	void *irq_addr[SCM_IRQ_COUNT];
 	struct nd_interleave_set nd_set;
 	struct nvdimm_bus_descriptor bus_desc;
 	struct nvdimm_bus *nvdimm_bus;
@@ -114,6 +118,7 @@ struct scm_data {
 	struct command_metadata ns_command;
 	struct resource scm_res;
 	struct nd_region *nd_region;
+	struct eventfd_ctx *ev_ctx;
 	char fw_version[8+1];
 	u32 timeouts[ADMIN_COMMAND_MAX+1];
 
diff --git a/include/uapi/nvdimm/ocxl-scm.h b/include/uapi/nvdimm/ocxl-scm.h
index 0a5de46c5acd..e86ffb02d31f 100644
--- a/include/uapi/nvdimm/ocxl-scm.h
+++ b/include/uapi/nvdimm/ocxl-scm.h
@@ -66,6 +66,20 @@ struct scm_ioctl_controller_stats {
 	__u64 cache_write_latency; // nanoseconds
 };
 
+struct scm_ioctl_eventfd {
+	__s32 eventfd;
+	__u32 reserved;
+};
+
+#ifndef BIT_ULL
+#define BIT_ULL(nr)	(1ULL << (nr))
+#endif
+
+#define SCM_IOCTL_EVENT_CONTROLLER_DUMP_AVAILABLE	BIT_ULL(0)
+#define SCM_IOCTL_EVENT_ERROR_LOG_AVAILABLE		BIT_ULL(1)
+#define SCM_IOCTL_EVENT_HARDWARE_FATAL			BIT_ULL(2)
+#define SCM_IOCTL_EVENT_FIRMWARE_FATAL			BIT_ULL(3)
+
 /* ioctl numbers */
 #define SCM_MAGIC 0x5C
 /* SCM devices */
@@ -74,5 +88,7 @@ struct scm_ioctl_controller_stats {
 #define SCM_IOCTL_CONTROLLER_DUMP_DATA _IOWR(SCM_MAGIC, 0x03, struct scm_ioctl_controller_dump_data)
 #define SCM_IOCTL_CONTROLLER_DUMP_COMPLETE _IO(SCM_MAGIC, 0x04)
 #define SCM_IOCTL_CONTROLLER_STATS _IO(SCM_MAGIC, 0x05)
+#define SCM_IOCTL_EVENTFD	_IOW(SCM_MAGIC, 0x06, struct scm_ioctl_eventfd)
+#define SCM_IOCTL_EVENT_CHECK	_IOR(SCM_MAGIC, 0x07, __u64)
 
 #endif /* _UAPI_OCXL_SCM_H */
-- 
2.23.0

