Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17857137B3D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 03:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgAKCtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 21:49:41 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34026 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgAKCtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 21:49:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id i6so2051667pfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 18:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gt6F4uTsWktpFFyX7CiQDNWqBR7Eg8dmS5mipvr7KTw=;
        b=BuzS4eUvOv/lhca+jR2XNxv29Xk0K8XQWpKgw3B6udBY132JvhuXBRE/kladDkwxYR
         aaZea4znzHpeHW+nADfJFyC1SOn1tIQnLMyZBIHs5aUh8O8izQOU2mAWoqRBZFEcsjug
         Z7/eidmHjaG6WHi8MPp4HL/48LWKjFxqDxyeymaSuDq7hPJXrbnJpQfBgcg8SuFbq+U/
         OPzLMPV4lI7BqHR7bSJrHhFlIj+vAhl5uFKCMAuyTUKDACOpp4jCuALokLQV0XNv4is2
         s5s1rFOcw7R4n8xsmQRgX2VhHy1ssc17xQdH9ABbFZ8+Pb9hL0pW8um2ym06jsoqu41+
         HEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gt6F4uTsWktpFFyX7CiQDNWqBR7Eg8dmS5mipvr7KTw=;
        b=YNqzyiiK1KxTjKdD6dJJAGuFllBIUhntrptSuVkwhuNAh/Z+eh3J46hyas6u8/SlQc
         gzwKI8jd6bdOTAqtPdI4Aw1HU15Ef/AZ2PXAGb3hrafuOpSBdycAFNshjaUuTqoUIVKo
         TPfKSvqQ+XzZQu692yLAeqd2Vtbuf8uXINqA0KdwJ6dwwht9d6Po4O3UHUOz104jHgPw
         VIHyA2GMXG6MsMIMnfHyDtW9x+Feg43BsmjDIWGCETd3c8sCPk1a9vPjWrL0CjtlpHkQ
         67aDLADv/3mc0g+p1jaXCHo2KgtR7lqf3yXRxKqItskJYS5pzc8nz4Hs3f4roKnoWwD6
         fCug==
X-Gm-Message-State: APjAAAUOjqkuDP72O+gOn9qEZWHWXjnw+w56XY2+IKSmo1ouVlbZ+jkb
        4wUOR+dJpcL7bvyuY7lwJ3cj/Q==
X-Google-Smtp-Source: APXvYqxUTpxgXhP/QozBen7/IpqFv6gFvrift6Iqxe8kTCwZcjYNtE65ze1fgs8sK/N//6WTFktdHg==
X-Received: by 2002:aa7:96c7:: with SMTP id h7mr7548359pfq.211.1578710980442;
        Fri, 10 Jan 2020 18:49:40 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.78])
        by smtp.gmail.com with ESMTPSA id r7sm4778472pfg.34.2020.01.10.18.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jan 2020 18:49:40 -0800 (PST)
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
Subject: [PATCH v11 3/4] crypto: hisilicon - Remove module_param uacce_mode
Date:   Sat, 11 Jan 2020 10:48:38 +0800
Message-Id: <1578710919-12141-4-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578710919-12141-1-git-send-email-zhangfei.gao@linaro.org>
References: <1578710919-12141-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the module_param uacce_mode, which is not used currently.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/zip/zip_main.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 31ae6a7..853b97e 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -298,9 +298,6 @@ static u32 pf_q_num = HZIP_PF_DEF_Q_NUM;
 module_param_cb(pf_q_num, &pf_q_num_ops, &pf_q_num, 0444);
 MODULE_PARM_DESC(pf_q_num, "Number of queues in PF(v1 1-4096, v2 1-1024)");
 
-static int uacce_mode;
-module_param(uacce_mode, int, 0);
-
 static u32 vfs_num;
 module_param(vfs_num, uint, 0444);
 MODULE_PARM_DESC(vfs_num, "Number of VFs to enable(1-63)");
@@ -796,6 +793,7 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_set_drvdata(pdev, hisi_zip);
 
 	qm = &hisi_zip->qm;
+	qm->use_dma_api = true;
 	qm->pdev = pdev;
 	qm->ver = rev_id;
 
@@ -803,20 +801,6 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -1015,12 +999,10 @@ static int __init hisi_zip_init(void)
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
@@ -1035,8 +1017,7 @@ static int __init hisi_zip_init(void)
 
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

