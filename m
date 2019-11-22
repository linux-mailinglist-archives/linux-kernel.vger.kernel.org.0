Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C263E107496
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 16:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfKVPJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 10:09:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42577 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfKVPJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 10:09:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id s5so3607553pfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 07:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tJZyhm43uf0Z/sgLghvh3C922Koet0UHje3bklWsAKA=;
        b=UKWsDluEmzAq6qXa6AyufiTRGS8uyeF/E1ybHYD2BhpdDKFu8ohyyhib+rGRL0RQk7
         6ETIuUpJ2xaqwB2fiuiVGCZy3dKYtLw4ilm7bKBvFo0k1evx8V5200VPDzwi6SQDvfAS
         RQE8wpNgi2am9UqvIZn0J2IUFN72HpRBwXKXVOvpOSXrVDP/lSerMxwT48/v2+So/0Qm
         i+o0x6UUNxTuzeDIxShfoRa5k/n57nBcPh7UUmA0jdjnrZCXQ8ov6R8OWZaNtPMBlbo6
         dJS23BrpU27x2DVkqaogYcAS1ebYO5COe1i+WXQbMAfhOzpANrVa5CsYlBDq2AUFlcxI
         mS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tJZyhm43uf0Z/sgLghvh3C922Koet0UHje3bklWsAKA=;
        b=L106fJnO9ch71aG8Uj1pDYXVBSeMK4aI7gyxwrjvlzuR8rPb9kAIEb/xlu79M/5PRy
         1TCKLsO7LZ7/84prgTLWwu6jfD5pIIB4Q7eOzXWwIVcKqkh+UCCyn2DpR1ZgprpYyr9l
         v4jSqlIY5fg/NGnHYC03uXGO5ZzA9JNuQ34QDv62zdAf2rQ3cM7RN+MEjf/nsZyZueEE
         hxKC9K4vN8JlunUoeuQ+NntuWWcfrGplRwLtMfsq3bAxe1NiI9Hxq20oB8Ea018q0FL/
         Pz2L5pomP1LtdKSmUblCbNjf0Z07kgXpYwBovkkJDBJKikVFY4dPr/TZPPT6qDJIpc8H
         8M0w==
X-Gm-Message-State: APjAAAVlsnnyVKRM+u5VFRiDjet9FIxuPjljhhPVJnaLeOpQo1LTUpPm
        DyZeq4NFcUmVUu55SPA6hDUv5w==
X-Google-Smtp-Source: APXvYqxygXDW7MvUMbHe5yZ/Na9aSpFKod2LWOrlJw4kGXMdRrxeSlZHZL2DWVg1uoFERjnu1XLMaw==
X-Received: by 2002:a65:66c5:: with SMTP id c5mr16862228pgw.12.1574435393785;
        Fri, 22 Nov 2019 07:09:53 -0800 (PST)
Received: from localhost.localdomain ([240e:362:496:8600:f5af:2744:25c3:d01a])
        by smtp.gmail.com with ESMTPSA id a19sm8066021pfn.144.2019.11.22.07.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Nov 2019 07:09:53 -0800 (PST)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan.cameron@huawei.com, grant.likely@arm.com,
        jean-philippe <jean-philippe@linaro.org>,
        Jerome Glisse <jglisse@redhat.com>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "haojian . zhuang" <haojian.zhuang@linaro.org>,
        guodong.xu@linaro.org
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v9 3/4] crypto: hisilicon - Remove module_param uacce_mode
Date:   Fri, 22 Nov 2019 23:07:40 +0800
Message-Id: <1574435261-6031-4-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574435261-6031-1-git-send-email-zhangfei.gao@linaro.org>
References: <1574435261-6031-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the module_param uacce_mode, which is not used currently.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/zip/zip_main.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 1b2ee96..3de9412 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -264,9 +264,6 @@ static u32 pf_q_num = HZIP_PF_DEF_Q_NUM;
 module_param_cb(pf_q_num, &pf_q_num_ops, &pf_q_num, 0444);
 MODULE_PARM_DESC(pf_q_num, "Number of queues in PF(v1 1-4096, v2 1-1024)");
 
-static int uacce_mode;
-module_param(uacce_mode, int, 0);
-
 static const struct pci_device_id hisi_zip_dev_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_ZIP_PF) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_ZIP_VF) },
@@ -669,6 +666,7 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_set_drvdata(pdev, hisi_zip);
 
 	qm = &hisi_zip->qm;
+	qm->use_dma_api = true;
 	qm->pdev = pdev;
 	qm->ver = rev_id;
 
@@ -676,20 +674,6 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	qm->dev_name = hisi_zip_name;
 	qm->fun_type = (pdev->device == PCI_DEVICE_ID_ZIP_PF) ? QM_HW_PF :
 								QM_HW_VF;
-	switch (uacce_mode) {
-	case 0:
-		qm->use_dma_api = true;
-		break;
-	case 1:
-		qm->use_dma_api = false;
-		break;
-	case 2:
-		qm->use_dma_api = true;
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	ret = hisi_qm_init(qm);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to init qm!\n");
@@ -976,12 +960,10 @@ static int __init hisi_zip_init(void)
 		goto err_pci;
 	}
 
-	if (uacce_mode == 0 || uacce_mode == 2) {
-		ret = hisi_zip_register_to_crypto();
-		if (ret < 0) {
-			pr_err("Failed to register driver to crypto.\n");
-			goto err_crypto;
-		}
+	ret = hisi_zip_register_to_crypto();
+	if (ret < 0) {
+		pr_err("Failed to register driver to crypto.\n");
+		goto err_crypto;
 	}
 
 	return 0;
@@ -996,8 +978,7 @@ static int __init hisi_zip_init(void)
 
 static void __exit hisi_zip_exit(void)
 {
-	if (uacce_mode == 0 || uacce_mode == 2)
-		hisi_zip_unregister_from_crypto();
+	hisi_zip_unregister_from_crypto();
 	pci_unregister_driver(&hisi_zip_pci_driver);
 	hisi_zip_unregister_debugfs();
 }
-- 
2.7.4

