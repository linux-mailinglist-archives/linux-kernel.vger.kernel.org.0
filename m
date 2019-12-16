Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B88D11FD1F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 04:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLPDJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 22:09:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38894 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfLPDJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 22:09:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so4784325pfc.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 19:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W9XtgUwCaqLhMYMb2ALmzrvWt2lsT7N00PF81eXUGSY=;
        b=d4C45TMhLG17otkNIqcQIV7myR2FtJM/oxZV8H1jZ8G04hESxsdbJdsUP8hGHY8/Gf
         jghQRrKOidpVDRa71k7UJo+l0aZ4HJ7b5WrAzGsTk5cRD1h3BubA1I+J5rytAGtG3b59
         m/kyp6LOdgYQsuxMDuQ+NJkEvyGSTNVLngOhtAokUSTFUdXetMIgcFr3FNzCFF2oJNpP
         jm3XpW4gTy+sitnHuEgFmEQ61tmyzqeuJotRRLWTn/6mSKI+jXcVPFTagB08Q2jKbkOI
         5P1go0kcwaf6IrhKIxol3dskN4rl37kp4uOwoRH0eWY6gdy2XK6FBeWCqQDckqz0HM9L
         CKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W9XtgUwCaqLhMYMb2ALmzrvWt2lsT7N00PF81eXUGSY=;
        b=f8bURxWKnPrRb8Wk4qcpgZ8VY8WmNZ18+xs28qazR4IHq0+ofjG6cJKkyc0H16iPJY
         rbmFMr3TI7R+NdS5r8z+gOMFbNvqxxa7xMiy7tZpPDGjNMOHDfR2D8QXd+zR3iA/agWV
         aYm+Mq80hJUfrsNfooLXxkJ+sN6qSCDyc5BwTUpv8juCj6cS+w3ODkKFRA98TpgvKRql
         eSQrq2KIqsTqImlWpJ9ryeSqPd70Y3/kYEXeeEUvvXl5RntbgOogwlZR7sNB6RaQQeBO
         uK/fXVSGXGuPXHOkq4Y52ZfwdrHyZS3uB/shhdtvyDAJuZDZ9c8d3mcCRghyMbqCCb2j
         2EZQ==
X-Gm-Message-State: APjAAAWG2lOrvjse0gtW33vrAFtLn/walciaP88SpUC63HSIRhzmjQeY
        J8ad/01heoWpUZNOi7psOUxkTQ==
X-Google-Smtp-Source: APXvYqx938xXbcVugkpJ5W2sSVRdHdWqJdHWHBdpOMXCSuzfgsY8YW81wKOhTdduJrYUpFTG24+rrw==
X-Received: by 2002:a63:3645:: with SMTP id d66mr15533541pga.337.1576465773063;
        Sun, 15 Dec 2019 19:09:33 -0800 (PST)
Received: from localhost.localdomain ([240e:362:4f3:9700:194a:b273:fdd9:92e0])
        by smtp.gmail.com with ESMTPSA id k60sm18021687pjh.22.2019.12.15.19.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Dec 2019 19:09:32 -0800 (PST)
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
Subject: [PATCH v10 3/4] crypto: hisilicon - Remove module_param uacce_mode
Date:   Mon, 16 Dec 2019 11:08:16 +0800
Message-Id: <1576465697-27946-4-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576465697-27946-1-git-send-email-zhangfei.gao@linaro.org>
References: <1576465697-27946-1-git-send-email-zhangfei.gao@linaro.org>
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
index e1bab1a..93345f0 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -297,9 +297,6 @@ static u32 pf_q_num = HZIP_PF_DEF_Q_NUM;
 module_param_cb(pf_q_num, &pf_q_num_ops, &pf_q_num, 0444);
 MODULE_PARM_DESC(pf_q_num, "Number of queues in PF(v1 1-4096, v2 1-1024)");
 
-static int uacce_mode;
-module_param(uacce_mode, int, 0);
-
 static u32 vfs_num;
 module_param(vfs_num, uint, 0444);
 MODULE_PARM_DESC(vfs_num, "Number of VFs to enable(1-63)");
@@ -791,6 +788,7 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_set_drvdata(pdev, hisi_zip);
 
 	qm = &hisi_zip->qm;
+	qm->use_dma_api = true;
 	qm->pdev = pdev;
 	qm->ver = rev_id;
 
@@ -798,20 +796,6 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -1010,12 +994,10 @@ static int __init hisi_zip_init(void)
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
@@ -1030,8 +1012,7 @@ static int __init hisi_zip_init(void)
 
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

