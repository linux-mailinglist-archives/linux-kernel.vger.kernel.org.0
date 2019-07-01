Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5D858F47
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 02:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfF1Auf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 20:50:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43291 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfF1Aub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:50:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so1772481pgv.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 17:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k7RLwVwYnL38eM8ZKiBzXs2r91zFAZdg0XHcwAeQ9B0=;
        b=rbGyFHFmQ04ntOCPdDH1yyKg3nVdJy0t4YecgiijhUeKPTje6Xst+3WG51fo8H+rhy
         WD4fK1fAIZgtlEK8BAnHLsKkeags0OBGKQIkbFt0dyelvASVpfwGlzTRGQ18b6lcWCiS
         XF1nVcGzrj3/fGx8P+DXA2iB7zKcvzXmAl31kvS1H3PYCglhc8iaw6/ARrwiyHkApwCh
         17YT37u/udK36xj6cSAWaPzlkYisJggdXrOF6XSN/ZCU1q/Rzae7vBmn1C/Aj8nt/CIH
         xXEqRmwDVQqs/uLQdtJVdDEiDQGMz7F7guV7oQmz5brzwXeBRFg3FmOYQjEIR2XTkVAe
         vPrg==
X-Gm-Message-State: APjAAAWDXgpchmcNSigD19KBcLO+weIi33Hd7lKg6DNUpUM0/PfPwFxF
        IYXsPlp/k6z8V9V2lGbdYQGXHQ==
X-Google-Smtp-Source: APXvYqwGhEMV8h9rDzBnrEiH4sKwJ6rqLL28uz+dE3xd3Gmdb0OvPVDcAGuemwRWKgx2gks2pgyqZQ==
X-Received: by 2002:a17:90a:270f:: with SMTP id o15mr9538404pje.56.1561683030917;
        Thu, 27 Jun 2019 17:50:30 -0700 (PDT)
Received: from localhost (c-76-21-109-208.hsd1.ca.comcast.net. [76.21.109.208])
        by smtp.gmail.com with ESMTPSA id h12sm415088pje.12.2019.06.27.17.50.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 17:50:29 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Wu Hao <hao.wu@intel.com>, Zhang Yi Z <yi.z.zhang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Alan Tull <atull@kernel.org>,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 07/15] fpga: dfl: pci: enable SRIOV support.
Date:   Thu, 27 Jun 2019 17:49:43 -0700
Message-Id: <20190628004951.6202-8-mdf@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190628004951.6202-1-mdf@kernel.org>
References: <20190628004951.6202-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wu Hao <hao.wu@intel.com>

This patch enables the standard sriov support. It allows user to
enable SRIOV (and VFs), then user could pass through accelerators
(VFs) into virtual machine or use VFs directly in host.

Signed-off-by: Zhang Yi Z <yi.z.zhang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/dfl-pci.c | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl.h     |  1 +
 3 files changed, 82 insertions(+)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 66b5720582bb..2fa571b0fdea 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -223,8 +223,46 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
 	return ret;
 }
 
+static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
+{
+	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
+	struct dfl_fpga_cdev *cdev = drvdata->cdev;
+	int ret = 0;
+
+	mutex_lock(&cdev->lock);
+
+	if (!num_vfs) {
+		/*
+		 * disable SRIOV and then put released ports back to default
+		 * PF access mode.
+		 */
+		pci_disable_sriov(pcidev);
+
+		__dfl_fpga_cdev_config_port_vf(cdev, false);
+
+	} else if (cdev->released_port_num == num_vfs) {
+		/*
+		 * only enable SRIOV if cdev has matched released ports, put
+		 * released ports into VF access mode firstly.
+		 */
+		__dfl_fpga_cdev_config_port_vf(cdev, true);
+
+		ret = pci_enable_sriov(pcidev, num_vfs);
+		if (ret)
+			__dfl_fpga_cdev_config_port_vf(cdev, false);
+	} else {
+		ret = -EINVAL;
+	}
+
+	mutex_unlock(&cdev->lock);
+	return ret;
+}
+
 static void cci_pci_remove(struct pci_dev *pcidev)
 {
+	if (dev_is_pf(&pcidev->dev))
+		cci_pci_sriov_configure(pcidev, 0);
+
 	cci_remove_feature_devs(pcidev);
 	pci_disable_pcie_error_reporting(pcidev);
 }
@@ -234,6 +272,7 @@ static struct pci_driver cci_pci_driver = {
 	.id_table = cci_pcie_id_tbl,
 	.probe = cci_pci_probe,
 	.remove = cci_pci_remove,
+	.sriov_configure = cci_pci_sriov_configure,
 };
 
 module_pci_driver(cci_pci_driver);
@@ -241,3 +280,4 @@ module_pci_driver(cci_pci_driver);
 MODULE_DESCRIPTION("FPGA DFL PCIe Device Driver");
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL v2");
+MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 308c80868af4..28d61b611165 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1112,6 +1112,47 @@ int dfl_fpga_cdev_config_port(struct dfl_fpga_cdev *cdev,
 }
 EXPORT_SYMBOL_GPL(dfl_fpga_cdev_config_port);
 
+static void config_port_vf(struct device *fme_dev, int port_id, bool is_vf)
+{
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(fme_dev, FME_FEATURE_ID_HEADER);
+
+	v = readq(base + FME_HDR_PORT_OFST(port_id));
+
+	v &= ~FME_PORT_OFST_ACC_CTRL;
+	v |= FIELD_PREP(FME_PORT_OFST_ACC_CTRL,
+			is_vf ? FME_PORT_OFST_ACC_VF : FME_PORT_OFST_ACC_PF);
+
+	writeq(v, base + FME_HDR_PORT_OFST(port_id));
+}
+
+/**
+ * __dfl_fpga_cdev_config_port_vf - configure port to VF access mode
+ *
+ * @cdev: parent container device.
+ * @if_vf: true for VF access mode, and false for PF access mode
+ *
+ * Return: 0 on success, negative error code otherwise.
+ *
+ * This function is needed in sriov configuration routine. It could be used to
+ * configures the released ports access mode to VF or PF.
+ * The caller needs to hold lock for protection.
+ */
+void __dfl_fpga_cdev_config_port_vf(struct dfl_fpga_cdev *cdev, bool is_vf)
+{
+	struct dfl_feature_platform_data *pdata;
+
+	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
+		if (device_is_registered(&pdata->dev->dev))
+			continue;
+
+		config_port_vf(cdev->fme_dev, pdata->id, is_vf);
+	}
+}
+EXPORT_SYMBOL_GPL(__dfl_fpga_cdev_config_port_vf);
+
 static int __init dfl_fpga_init(void)
 {
 	int ret;
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 63f39ab08905..1350e8eb9e59 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -421,5 +421,6 @@ dfl_fpga_cdev_find_port(struct dfl_fpga_cdev *cdev, void *data,
 
 int dfl_fpga_cdev_config_port(struct dfl_fpga_cdev *cdev,
 			      u32 port_id, bool release);
+void __dfl_fpga_cdev_config_port_vf(struct dfl_fpga_cdev *cdev, bool is_vf);
 
 #endif /* __FPGA_DFL_H */
-- 
2.22.0

