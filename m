Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5A7158AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 08:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgBKHz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 02:55:27 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34138 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgBKHz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 02:55:27 -0500
Received: by mail-pg1-f196.google.com with SMTP id j4so5294631pgi.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 23:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yMNaeQA1ruqb07d/gQkY9hQQ01qf8ZdkJJEE7bVrST0=;
        b=qy7q2sC3/9NT/KbvDHO5b+43/7xYnzO6GsBLhRg809ExUGmrFzUukRkO7Pv84N01jM
         5vL0X0hzh2KtKwFyQxU0RHzh/WCdWw+zd4TKRZR3k0z1LlAl24QLRksf1ouxCVJKfNHY
         IRA/zvxnFJGY7+BR2A5iM2i0KUZ7ShOINrYZqWklxf1KbAJwe+eOvLJn1FsIE9DEPGCn
         2uhhxUM32KNNQUbzTy8WV4bIUZpspI7zXjmwK4hTph0Yn7SXpvja6/8lUlYnEYrX11La
         xi7mJwc7Q1zgX2vOWUSV2LKQOFmkd5Secz5bvf1ngjC13IMvwjNaO6z+dO12k+P4gn8m
         VAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yMNaeQA1ruqb07d/gQkY9hQQ01qf8ZdkJJEE7bVrST0=;
        b=oA8buoQ3eIhNsNcHfI4/wV2L5rbZVS1Cl0lfHxQlClmm0T9JmX7zK0llkvVqsjrafb
         HQAg66lUKKHTbINgINKtD5l0mh7/W+PRdnOdhI4Sx82sI5MsJibXekjWGoQ8q6FRDUqn
         AjRCe7kyWAhI6vsiy+Y+EjaY23ivIG119KyU2DkEdKBmrcD423IRzEgOpvFM6Y23zv1F
         Ph+V/tDKtUhk4JsJXaV/D6/Qrdo0HWxvyvEGWvMZObjyepey+1Sa4pB0184OJQcMAd5f
         4ULkGG1wkk8dhS9Jz6JrZGiRwWGYtB9SpUZfyzR0UXtxplwipXMMZ1kK7fR2LVwCJce8
         +l0A==
X-Gm-Message-State: APjAAAVBJ5I51qegGVEhZJmuMfftvwqhJC3aWpIlS8LoqQk/qUCHGXUJ
        dnczM2bBMQJAnQCPBk1lcVlg4Q==
X-Google-Smtp-Source: APXvYqwB/y69jqFMmPjxzXFUjA7Ef5wpPMq1/CHv/UDjvlKO+NPD1qw9XyOMHXF8sC7l5xeyBDAzZg==
X-Received: by 2002:a63:f103:: with SMTP id f3mr501380pgi.394.1581407726884;
        Mon, 10 Feb 2020 23:55:26 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.96])
        by smtp.gmail.com with ESMTPSA id d73sm3011627pfd.109.2020.02.10.23.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Feb 2020 23:55:26 -0800 (PST)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan.cameron@huawei.com, dave.jiang@intel.com,
        grant.likely@arm.com, jean-philippe <jean-philippe@linaro.org>,
        Jerome Glisse <jglisse@redhat.com>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "haojian . zhuang" <haojian.zhuang@linaro.org>,
        guodong.xu@linaro.org
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v13 3/4] crypto: hisilicon - Remove module_param uacce_mode
Date:   Tue, 11 Feb 2020 15:54:24 +0800
Message-Id: <1581407665-13504-4-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581407665-13504-1-git-send-email-zhangfei.gao@linaro.org>
References: <1581407665-13504-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the module_param uacce_mode, which is not used currently.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/zip/zip_main.c | 31 +++++--------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index e1bab1a91333..93345f0d7415 100644
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
2.23.0

