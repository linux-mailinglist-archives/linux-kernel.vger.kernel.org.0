Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97C0A71F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 20:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391347AbfGWSm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 14:42:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42612 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfGWSm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:42:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so19567630pff.9;
        Tue, 23 Jul 2019 11:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CuBq2ea9RAnOcCp/a/6zA6IGtHEy600UrSm5Gali8kE=;
        b=qHO+CknRnfSVrIIIdLUDFEacZZ6VkaWRORHECxikg5ah0nnn7qZZITAv1s82JMIi4w
         iC0W6/bFUe0Na49tk1fkV1/vFTEmx/UUkLA66GaxGKjnDuDyeutazt3G5UOiNCgk5F5H
         XoRYfLvtItoKCFrwWG1GNrc5Imq/RvI7sSJyf76+7X2jb0RutEPw+i5mJ99a5gykJF4l
         026ZAGw3gDUXlVZDMZKSPZABPLHVS2wG9CTuAzsUTOVOHfClUVU03PQmnLoW/Q+A30lx
         HBwAmXRmXH+icepv1NFFwB2VWeqGrlB44h17eGHsA8B21PTvU8Ni5FsmXzz0jo0fQ7v0
         WfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CuBq2ea9RAnOcCp/a/6zA6IGtHEy600UrSm5Gali8kE=;
        b=U8s20QZqX2mB0hy2URXJdsxelbfLHy1kG1Svi2VIfhh3pujn5IzJSAoeOqcc+BfjRF
         upSp5uWeYD5Nr4a1uLYBMA1Sc4wErVn+3W9URmVeDhifIRAQGFx28KQXTExSc1zzdxBO
         tL++zj5hyMBhJ9xLVI7ed1JXEk5TVvNL5P6FzGKUCLWTXoOrIScrL5zYQfjeYuj1OSx8
         OyfQ3IBBfvkLJFFI/fE9OPR7snMIYl4ySywZNJGVf2mLSlHgrlRBVEaNoxNJCdPKY9Aa
         pw7owA/oFgnhyE5qNCbDe/KU+EOFAe//cG+D1DyVBJIQpyXDnycqB4DsVqdpUJu055s0
         6RDQ==
X-Gm-Message-State: APjAAAVHuADkL1ihZ8jwDMRITy17SLTdmlaB/bATcDJ1HYKMo2vONG1e
        gLB97OHK+Xd22ZKnleUiBETk76e6x+Y=
X-Google-Smtp-Source: APXvYqzhx6iNGBbySKd5BbxX60bDbxsKE9vmVlL7QESq9Cq4w5vEKwrejO8eWv4HOtTGgaYRIjnTGg==
X-Received: by 2002:a63:b10f:: with SMTP id r15mr8348615pgf.230.1563907376801;
        Tue, 23 Jul 2019 11:42:56 -0700 (PDT)
Received: from localhost.localdomain ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id s66sm47416373pfs.8.2019.07.23.11.42.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 11:42:55 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        Klaus Birkelund Jensen <birkelund@gmail.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH V2] lightnvm: introduce pr_fmt for the previx nvm
Date:   Wed, 24 Jul 2019 03:42:43 +0900
Message-Id: <20190723184243.4347-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

all the pr_() family can have this prefix by pr_fmt.

Changes to V1:
  - Squashed multiple lines to make it short (Chaitanya)

Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
Reviewed-by: Javier González <javier@javigon.com>
---
 drivers/lightnvm/core.c | 48 ++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index a600934fdd9c..4c7b48f72e80 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -4,6 +4,7 @@
  * Initial release: Matias Bjorling <m@bjorling.me>
  */
 
+#define pr_fmt(fmt) "nvm: " fmt
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/sem.h>
@@ -74,7 +75,7 @@ static int nvm_reserve_luns(struct nvm_dev *dev, int lun_begin, int lun_end)
 
 	for (i = lun_begin; i <= lun_end; i++) {
 		if (test_and_set_bit(i, dev->lun_map)) {
-			pr_err("nvm: lun %d already allocated\n", i);
+			pr_err("lun %d already allocated\n", i);
 			goto err;
 		}
 	}
@@ -264,7 +265,7 @@ static int nvm_config_check_luns(struct nvm_geo *geo, int lun_begin,
 				 int lun_end)
 {
 	if (lun_begin > lun_end || lun_end >= geo->all_luns) {
-		pr_err("nvm: lun out of bound (%u:%u > %u)\n",
+		pr_err("lun out of bound (%u:%u > %u)\n",
 			lun_begin, lun_end, geo->all_luns - 1);
 		return -EINVAL;
 	}
@@ -297,7 +298,7 @@ static int __nvm_config_extended(struct nvm_dev *dev,
 	if (e->op == 0xFFFF) {
 		e->op = NVM_TARGET_DEFAULT_OP;
 	} else if (e->op < NVM_TARGET_MIN_OP || e->op > NVM_TARGET_MAX_OP) {
-		pr_err("nvm: invalid over provisioning value\n");
+		pr_err("invalid over provisioning value\n");
 		return -EINVAL;
 	}
 
@@ -334,23 +335,23 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 		e = create->conf.e;
 		break;
 	default:
-		pr_err("nvm: config type not valid\n");
+		pr_err("config type not valid\n");
 		return -EINVAL;
 	}
 
 	tt = nvm_find_target_type(create->tgttype);
 	if (!tt) {
-		pr_err("nvm: target type %s not found\n", create->tgttype);
+		pr_err("target type %s not found\n", create->tgttype);
 		return -EINVAL;
 	}
 
 	if ((tt->flags & NVM_TGT_F_HOST_L2P) != (dev->geo.dom & NVM_RSP_L2P)) {
-		pr_err("nvm: device is incompatible with target L2P type.\n");
+		pr_err("device is incompatible with target L2P type.\n");
 		return -EINVAL;
 	}
 
 	if (nvm_target_exists(create->tgtname)) {
-		pr_err("nvm: target name already exists (%s)\n",
+		pr_err("target name already exists (%s)\n",
 							create->tgtname);
 		return -EINVAL;
 	}
@@ -367,7 +368,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 
 	tgt_dev = nvm_create_tgt_dev(dev, e.lun_begin, e.lun_end, e.op);
 	if (!tgt_dev) {
-		pr_err("nvm: could not create target device\n");
+		pr_err("could not create target device\n");
 		ret = -ENOMEM;
 		goto err_t;
 	}
@@ -686,7 +687,7 @@ static int nvm_set_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
 	rqd->nr_ppas = nr_ppas;
 	rqd->ppa_list = nvm_dev_dma_alloc(dev, GFP_KERNEL, &rqd->dma_ppa_list);
 	if (!rqd->ppa_list) {
-		pr_err("nvm: failed to allocate dma memory\n");
+		pr_err("failed to allocate dma memory\n");
 		return -ENOMEM;
 	}
 
@@ -1048,7 +1049,7 @@ int nvm_set_chunk_meta(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
 		return 0;
 
 	if (nr_ppas > NVM_MAX_VLBA) {
-		pr_err("nvm: unable to update all blocks atomically\n");
+		pr_err("unable to update all blocks atomically\n");
 		return -EINVAL;
 	}
 
@@ -1111,27 +1112,26 @@ static int nvm_init(struct nvm_dev *dev)
 	int ret = -EINVAL;
 
 	if (dev->ops->identity(dev)) {
-		pr_err("nvm: device could not be identified\n");
+		pr_err("device could not be identified\n");
 		goto err;
 	}
 
-	pr_debug("nvm: ver:%u.%u nvm_vendor:%x\n",
-				geo->major_ver_id, geo->minor_ver_id,
-				geo->vmnt);
+	pr_debug("ver:%u.%u nvm_vendor:%x\n", geo->major_ver_id,
+			geo->minor_ver_id, geo->vmnt);
 
 	ret = nvm_core_init(dev);
 	if (ret) {
-		pr_err("nvm: could not initialize core structures.\n");
+		pr_err("could not initialize core structures.\n");
 		goto err;
 	}
 
-	pr_info("nvm: registered %s [%u/%u/%u/%u/%u]\n",
+	pr_info("registered %s [%u/%u/%u/%u/%u]\n",
 			dev->name, dev->geo.ws_min, dev->geo.ws_opt,
 			dev->geo.num_chk, dev->geo.all_luns,
 			dev->geo.num_ch);
 	return 0;
 err:
-	pr_err("nvm: failed to initialize nvm\n");
+	pr_err("failed to initialize nvm\n");
 	return ret;
 }
 
@@ -1169,7 +1169,7 @@ int nvm_register(struct nvm_dev *dev)
 	dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist",
 						  exp_pool_size);
 	if (!dev->dma_pool) {
-		pr_err("nvm: could not create dma pool\n");
+		pr_err("could not create dma pool\n");
 		kref_put(&dev->ref, nvm_free);
 		return -ENOMEM;
 	}
@@ -1214,7 +1214,7 @@ static int __nvm_configure_create(struct nvm_ioctl_create *create)
 	up_write(&nvm_lock);
 
 	if (!dev) {
-		pr_err("nvm: device not found\n");
+		pr_err("device not found\n");
 		return -EINVAL;
 	}
 
@@ -1288,7 +1288,7 @@ static long nvm_ioctl_get_devices(struct file *file, void __user *arg)
 		i++;
 
 		if (i > 31) {
-			pr_err("nvm: max 31 devices can be reported.\n");
+			pr_err("max 31 devices can be reported.\n");
 			break;
 		}
 	}
@@ -1315,7 +1315,7 @@ static long nvm_ioctl_dev_create(struct file *file, void __user *arg)
 
 	if (create.conf.type == NVM_CONFIG_TYPE_EXTENDED &&
 	    create.conf.e.rsv != 0) {
-		pr_err("nvm: reserved config field in use\n");
+		pr_err("reserved config field in use\n");
 		return -EINVAL;
 	}
 
@@ -1331,7 +1331,7 @@ static long nvm_ioctl_dev_create(struct file *file, void __user *arg)
 			flags &= ~NVM_TARGET_FACTORY;
 
 		if (flags) {
-			pr_err("nvm: flag not supported\n");
+			pr_err("flag not supported\n");
 			return -EINVAL;
 		}
 	}
@@ -1349,7 +1349,7 @@ static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
 	remove.tgtname[DISK_NAME_LEN - 1] = '\0';
 
 	if (remove.flags != 0) {
-		pr_err("nvm: no flags supported\n");
+		pr_err("no flags supported\n");
 		return -EINVAL;
 	}
 
@@ -1365,7 +1365,7 @@ static long nvm_ioctl_dev_init(struct file *file, void __user *arg)
 		return -EFAULT;
 
 	if (init.flags != 0) {
-		pr_err("nvm: no flags supported\n");
+		pr_err("no flags supported\n");
 		return -EINVAL;
 	}
 
-- 
2.17.1

