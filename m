Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7EC095C23
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 12:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfHTKRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 06:17:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:35575 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729769AbfHTKRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 06:17:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 03:17:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="185872338"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Aug 2019 03:17:06 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 4/4] intel_th: pci: Add Tiger Lake support
Date:   Tue, 20 Aug 2019 13:16:53 +0300
Message-Id: <20190820101653.74738-5-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190820101653.74738-1-alexander.shishkin@linux.intel.com>
References: <20190820101653.74738-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the Trace Hub in Tiger Lake PCH.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 5c4e4fbec936..91dfeba62485 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -204,6 +204,11 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x45c5),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Tiger Lake PCH */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa0a6),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{ 0 },
 };
 
-- 
2.23.0.rc1

