Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 216E3187138
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 18:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbgCPReW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 13:34:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:61497 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731745AbgCPReV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 13:34:21 -0400
IronPort-SDR: RHHrC+t/3QWSD6QcwPs9Yj0/NVR6Lq7epKvcKT0VUgCS+pOFUSgWuRPcH51g5BLmYGJYdHobVX
 MFX9+DB+hW4Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 10:34:21 -0700
IronPort-SDR: tKDL4NR8Z7Y+zHgBFsNKDDc5AOAEJ3MKAEpb9ehI+scsom473dAJy4QiY4H9VSe43pKYJ4Q480
 GlkdoaGOkWyw==
X-IronPort-AV: E=Sophos;i="5.70,561,1574150400"; 
   d="scan'208";a="237676837"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 10:34:21 -0700
From:   ira.weiny@intel.com
To:     Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>, Ira Weiny <ira.weiny@intel.com>
Subject: [RESEND] memremap: Remove stale comments
Date:   Mon, 16 Mar 2020 10:34:14 -0700
Message-Id: <20200316173414.143627-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Fixes: 80a72d0af05a ("memremap: remove the data field in struct dev_pagemap")
Fixes: fdc029b19dfd ("memremap: remove the dev field in struct dev_pagemap")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Resending as I don't see this picked up in the rdma tree.

Jason I sent this to you as you pulled the patches which dropped the
parameters.  Can you take it?  Or do you want me to send through Andrew?

Thanks,
Ira

 include/linux/memremap.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 6fefb09af7c3..edfd1ec6c165 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -98,8 +98,6 @@ struct dev_pagemap_ops {
  * @ref: reference count that pins the devm_memremap_pages() mapping
  * @internal_ref: internal reference if @ref is not provided by the caller
  * @done: completion for @internal_ref
- * @dev: host device of the mapping for debug
- * @data: private data pointer for page_free()
  * @type: memory type: see MEMORY_* in memory_hotplug.h
  * @flags: PGMAP_* flags to specify defailed behavior
  * @ops: method table
-- 
2.23.0

