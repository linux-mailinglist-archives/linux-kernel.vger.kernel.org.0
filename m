Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2663277F3A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2019 13:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfG1L2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 07:28:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44163 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfG1L2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 07:28:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so58771456wrf.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 04:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=yIsEZ/4iZjCdPnNdvXqVP5YKPPBlBDlH271Sc5lwj6k=;
        b=po12lpDYQC87g9tWB7W/neNnHACRJtj7QGz5L2sGnlsWrs3YeNraetUy6Oquu7pA4v
         oViMWU5uh5gXcG4NH1jt+RX73O8HWpCZYO3EWYGSMIzRuSausgXeKNoKWTGpi6ohcqsd
         gm5u8/IT0jYWLGQcGuY4Y48iJY3g1I7xveQXHvBQufO4MuXtvESziwvuVBGqJjX5a3lr
         bm+MmlipLAoHrl4N9xqPKBBzTPhLQSlIxXP84sbuaASEFYV/9t3q8Ij4bb7D684MlU++
         Mg/YEV8JP86TxEdw1fCcxmuJmXh+DQIAJeS7OmtNi/5LM+80AF8MdboynRjKS3lJnAlv
         KZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=yIsEZ/4iZjCdPnNdvXqVP5YKPPBlBDlH271Sc5lwj6k=;
        b=i/UBt/pVY3ZMNStIkCLt2mljJ1I3Ih/DC8OnQVA2dpg6XdjvPvDJ8geGXuzkQ0wybn
         uP818NJkecp4qiqgd1PlZMf35EPvv2IIkFKgsvS/gCAbRzcav+vTDadsi5Ncigkj85fa
         rmC+ODIg9M3a6Trz4igAoUiAw/vWGdheBQb4lH0s5uFr2MahP2DbjAYXTXBOYJArW8HT
         wN1pRD2CkyzN3GNIrfDqfAlQqgilUKgILKfno4K1NNVjLuE6bR0/EF7XV/ZMooCFsmsb
         WXLCP6LZvUUzb18aU7gfjxJrg96LOvFL4kjWGMgWLrl83DHPNxs0SedU5X3dmj70p5Va
         FoyA==
X-Gm-Message-State: APjAAAVdx43CYEpGSqvHEz8+2nWavpSK3sKN50E5/g4M63kM0rACj8+h
        VczJvO9Aoo3X8R64PP8qDddMn64vCpg=
X-Google-Smtp-Source: APXvYqwfT+w+1p5tYiC3JOpEaeezKtjP/QPVf+HIiAbxKo5ZZhVXMFtmTcFSa7Dfm5JGtlF0mieM5A==
X-Received: by 2002:a5d:4ec1:: with SMTP id s1mr106791606wrv.19.1564313312791;
        Sun, 28 Jul 2019 04:28:32 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id r12sm69805174wrt.95.2019.07.28.04.28.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 04:28:32 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH 9/9] habanalabs: allow multiple processes to open FD
Date:   Sun, 28 Jul 2019 14:28:18 +0300
Message-Id: <20190728112818.30397-10-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190728112818.30397-1-oded.gabbay@gmail.com>
References: <20190728112818.30397-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the limitation of a single process that can open the
device.

Now, there is no limitation on the number of processes that can open the
device and have a valid FD.

However, only a single process can perform compute operations. This is
enforced by allowing only a single process to have a compute context.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/context.c          | 100 +++++++++++++++------
 drivers/misc/habanalabs/device.c           |  18 ++--
 drivers/misc/habanalabs/habanalabs.h       |   1 -
 drivers/misc/habanalabs/habanalabs_drv.c   |   8 --
 drivers/misc/habanalabs/habanalabs_ioctl.c |   7 +-
 5 files changed, 85 insertions(+), 49 deletions(-)

diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
index 57bbe59da9b6..f64220fc3a55 100644
--- a/drivers/misc/habanalabs/context.c
+++ b/drivers/misc/habanalabs/context.c
@@ -56,7 +56,7 @@ void hl_ctx_do_release(struct kref *ref)
 	kfree(ctx);
 }
 
-int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
+static int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
 {
 	struct hl_ctx_mgr *mgr = &hpriv->ctx_mgr;
 	struct hl_ctx *ctx;
@@ -89,9 +89,6 @@ int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
 	/* TODO: remove for multiple contexts per process */
 	hpriv->ctx = ctx;
 
-	/* TODO: remove the following line for multiple process support */
-	hdev->compute_ctx = ctx;
-
 	return 0;
 
 remove_from_idr:
@@ -206,13 +203,22 @@ bool hl_ctx_is_valid(struct hl_fpriv *hpriv, bool requires_compute_ctx)
 	int rc;
 
 	/* First thing, to minimize latency impact, check if context exists.
-	 * Also check if it matches the requirements. If so, exit immediately
+	 * This is relevant for the "steady state", where a process context
+	 * already exists, and we want to minimize the latency in command
+	 * submissions. In that case, we want to see if we can quickly exit
+	 * with a valid answer.
+	 *
+	 * If a context doesn't exists, we must grab the mutex. Otherwise,
+	 * there can be nasty races in case of multi-threaded application.
+	 *
+	 * So, if the context exists and we don't need a compute context,
+	 * that's fine. If it exists and the context we have is the compute
+	 * context, that's also fine. Other then that, we can't check anything
+	 * without the mutex.
 	 */
-	if (hpriv->ctx) {
-		if ((requires_compute_ctx) && (hdev->compute_ctx != hpriv->ctx))
-			return false;
+	if ((hpriv->ctx) && ((!requires_compute_ctx) ||
+					(hdev->compute_ctx == hpriv->ctx)))
 		return true;
-	}
 
 	mutex_lock(&hdev->lazy_ctx_creation_lock);
 
@@ -222,35 +228,73 @@ bool hl_ctx_is_valid(struct hl_fpriv *hpriv, bool requires_compute_ctx)
 	 * creation of a context
 	 */
 	if (hpriv->ctx) {
-		if ((requires_compute_ctx) && (hdev->compute_ctx != hpriv->ctx))
+		if ((!requires_compute_ctx) ||
+					(hdev->compute_ctx == hpriv->ctx))
+			goto unlock_mutex;
+
+		if (hdev->compute_ctx) {
 			valid = false;
-		goto unlock_mutex;
-	}
+			goto unlock_mutex;
+		}
 
-	/* If we already have a compute context, there is no point
-	 * of creating one in case we are called from ioctl that needs
-	 * a compute context
-	 */
-	if ((hdev->compute_ctx) && (requires_compute_ctx)) {
+		/* If we reached here, it means we have a non-compute context,
+		 * but there is no compute context on the device. Therefore,
+		 * we can try to "upgrade" the existing context to a compute
+		 * context
+		 */
+		dev_dbg_ratelimited(hdev->dev,
+				"Non-compute context %d exists\n",
+				hpriv->ctx->asid);
+
+	} else if ((hdev->compute_ctx) && (requires_compute_ctx)) {
+
+		/* If we already have a compute context in the device, there is
+		 * no point of creating one in case we are called from ioctl
+		 * that needs a compute context
+		 */
 		dev_err(hdev->dev,
 			"Can't create new compute context as one already exists\n");
 		valid = false;
 		goto unlock_mutex;
-	}
+	} else {
+		/* If we reached here it is because there isn't a context for
+		 * the process AND there is no compute context or compute
+		 * context wasn't required. In any case, must create a context
+		 * for the process
+		 */
 
-	rc = hl_ctx_create(hdev, hpriv);
-	if (rc) {
-		dev_err(hdev->dev, "Failed to create context %d\n", rc);
-		valid = false;
-		goto unlock_mutex;
+		rc = hl_ctx_create(hdev, hpriv);
+		if (rc) {
+			dev_err(hdev->dev, "Failed to create context %d\n", rc);
+			valid = false;
+			goto unlock_mutex;
+		}
+
+		dev_dbg_ratelimited(hdev->dev, "Created context %d\n",
+					hpriv->ctx->asid);
 	}
 
-	/* Device is IDLE at this point so it is legal to change PLLs.
-	 * There is no need to check anything because if the PLL is
-	 * already HIGH, the set function will return without doing
-	 * anything
+	/* If we reached here then either we have a new context, or we can
+	 * upgrade a non-compute context to a compute context. Do the upgrade
+	 * only if the caller required a compute context
 	 */
-	hl_device_set_frequency(hdev, PLL_HIGH);
+	if (requires_compute_ctx) {
+		WARN(hdev->compute_ctx,
+			"Compute context exists but driver is setting a new one");
+
+		dev_dbg_ratelimited(hdev->dev,
+				"Setting context %d as compute\n",
+				hpriv->ctx->asid);
+
+		hdev->compute_ctx = hpriv->ctx;
+
+		/* Device is IDLE at this point so it is legal to change PLLs.
+		 * There is no need to check anything because if the PLL is
+		 * already HIGH, the set function will return without doing
+		 * anything
+		 */
+		hl_device_set_frequency(hdev, PLL_HIGH);
+	}
 
 unlock_mutex:
 	mutex_unlock(&hdev->lazy_ctx_creation_lock);
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 2677160c01b8..e99a6d2b9893 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -42,10 +42,12 @@ static void hpriv_release(struct kref *ref)
 {
 	struct hl_fpriv *hpriv;
 	struct hl_device *hdev;
+	struct hl_ctx *ctx;
 
 	hpriv = container_of(ref, struct hl_fpriv, refcount);
 
 	hdev = hpriv->hdev;
+	ctx = hpriv->ctx;
 
 	put_pid(hpriv->taskpid);
 
@@ -53,9 +55,6 @@ static void hpriv_release(struct kref *ref)
 
 	mutex_destroy(&hpriv->restore_phase_mutex);
 
-	/* Remove private data node from the device list. This enables
-	 * another process to open the device
-	 */
 	mutex_lock(&hdev->fpriv_list_lock);
 	list_del(&hpriv->dev_node);
 	mutex_unlock(&hdev->fpriv_list_lock);
@@ -63,7 +62,8 @@ static void hpriv_release(struct kref *ref)
 	kfree(hpriv);
 
 	mutex_lock(&hdev->lazy_ctx_creation_lock);
-	hdev->compute_ctx = NULL;
+	if (hdev->compute_ctx == ctx)
+		hdev->compute_ctx = NULL;
 	mutex_unlock(&hdev->lazy_ctx_creation_lock);
 }
 
@@ -567,6 +567,7 @@ int hl_device_resume(struct hl_device *hdev)
 static void device_kill_open_processes(struct hl_device *hdev)
 {
 	u16 pending_total, pending_cnt;
+	struct hl_fpriv	*hpriv;
 	struct task_struct *task = NULL;
 
 	if (hdev->pldm)
@@ -589,13 +590,12 @@ static void device_kill_open_processes(struct hl_device *hdev)
 	/* This section must be protected because we are dereferencing
 	 * pointers that are freed if the process exits
 	 */
-	if (!list_empty(&hdev->fpriv_list)) {
-		task = get_pid_task(hdev->compute_ctx->hpriv->taskpid,
-					PIDTYPE_PID);
+	list_for_each_entry(hpriv, &hdev->fpriv_list, dev_node) {
+		task = get_pid_task(hpriv->taskpid, PIDTYPE_PID);
 		if (task) {
-			dev_info(hdev->dev, "Killing user processes\n");
+			dev_info(hdev->dev, "Killing user process\n");
 			send_sig(SIGKILL, task, 1);
-			msleep(100);
+			usleep_range(1000, 10000);
 
 			put_task_struct(task);
 		}
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 6a6c71fd5eef..43123d00d046 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1412,7 +1412,6 @@ void hl_asid_fini(struct hl_device *hdev);
 unsigned long hl_asid_alloc(struct hl_device *hdev);
 void hl_asid_free(struct hl_device *hdev, unsigned long asid);
 
-int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv);
 void hl_ctx_free(struct hl_device *hdev, struct hl_ctx *ctx);
 int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx);
 void hl_ctx_do_release(struct kref *ref);
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index d990b30c0701..b21f9724a652 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -117,14 +117,6 @@ int hl_device_open(struct inode *inode, struct file *filp)
 		goto out_err;
 	}
 
-	if (!list_empty(&hdev->fpriv_list)) {
-		dev_info_ratelimited(hdev->dev,
-			"Can't open %s because another user is working on it\n",
-			dev_name(hdev->dev));
-		rc = -EBUSY;
-		goto out_err;
-	}
-
 	list_add(&hpriv->dev_node, &hdev->fpriv_list);
 	mutex_unlock(&hdev->fpriv_list_lock);
 
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index 8d84f2ac302d..452fd419a0cd 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -89,8 +89,9 @@ static int hw_events_info(struct hl_device *hdev, struct hl_info_args *args)
 	return copy_to_user(out, arr, min(max_size, size)) ? -EFAULT : 0;
 }
 
-static int dram_usage_info(struct hl_device *hdev, struct hl_info_args *args)
+static int dram_usage_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
+	struct hl_device *hdev = hpriv->hdev;
 	struct hl_info_dram_usage dram_usage = {0};
 	u32 max_size = args->return_size;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
@@ -105,7 +106,7 @@ static int dram_usage_info(struct hl_device *hdev, struct hl_info_args *args)
 	dram_usage.dram_free_mem = (prop->dram_size - dram_kmd_size) -
 					atomic64_read(&hdev->dram_used_mem);
 	dram_usage.ctx_dram_mem =
-			atomic64_read(&hdev->compute_ctx->dram_phys_mem);
+			atomic64_read(&hpriv->ctx->dram_phys_mem);
 
 	return copy_to_user(out, &dram_usage,
 		min((size_t) max_size, sizeof(dram_usage))) ? -EFAULT : 0;
@@ -225,7 +226,7 @@ static int hl_info_ioctl(struct hl_fpriv *hpriv, void *data)
 		break;
 
 	case HL_INFO_DRAM_USAGE:
-		rc = dram_usage_info(hdev, args);
+		rc = dram_usage_info(hpriv, args);
 		break;
 
 	case HL_INFO_HW_IDLE:
-- 
2.17.1

