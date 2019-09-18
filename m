Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B23EFB6EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 23:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbfIRVTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 17:19:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:56601 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387948AbfIRVTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 17:19:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 14:19:35 -0700
X-IronPort-AV: E=Sophos;i="5.64,522,1559545200"; 
   d="scan'208";a="388065194"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 14:19:35 -0700
From:   ira.weiny@intel.com
To:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] nvdimm: Trivial comment fix
Date:   Wed, 18 Sep 2019 14:19:33 -0700
Message-Id: <20190918211933.13213-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/nd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nd.h b/include/linux/nd.h
index f778f962d1b6..55c735997805 100644
--- a/include/linux/nd.h
+++ b/include/linux/nd.h
@@ -147,7 +147,7 @@ static inline int nvdimm_read_bytes(struct nd_namespace_common *ndns,
 
 /**
  * nvdimm_write_bytes() - synchronously write bytes to an nvdimm namespace
- * @ndns: device to read
+ * @ndns: device to write
  * @offset: namespace-relative starting offset
  * @buf: buffer to drain
  * @size: transfer length
-- 
2.20.1

