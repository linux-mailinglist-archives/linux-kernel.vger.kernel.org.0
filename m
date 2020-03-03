Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32D8D1785FA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 23:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgCCWx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 17:53:58 -0500
Received: from mga05.intel.com ([192.55.52.43]:13498 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbgCCWx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 17:53:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 14:53:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="386951228"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.184.249])
  by orsmga004.jf.intel.com with ESMTP; 03 Mar 2020 14:53:56 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86: ISST: Fix wrong unregister type
Date:   Tue,  3 Mar 2020 14:53:54 -0800
Message-Id: <20200303225354.363038-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MMIO driver is not unregistering with the correct type with the ISST
common core during module removal. This should be unregistered with
ISST_IF_DEV_MMIO instead of ISST_IF_DEV_MBOX.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
index ad8c7c0df4d9..3584859fcc42 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
@@ -126,7 +126,7 @@ static void isst_if_remove(struct pci_dev *pdev)
 	struct isst_if_device *punit_dev;
 
 	punit_dev = pci_get_drvdata(pdev);
-	isst_if_cdev_unregister(ISST_IF_DEV_MBOX);
+	isst_if_cdev_unregister(ISST_IF_DEV_MMIO);
 	mutex_destroy(&punit_dev->mutex);
 }
 
-- 
2.24.1

