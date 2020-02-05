Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA7C152449
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 01:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgBEAuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 19:50:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:26490 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727619AbgBEAuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:50:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 16:50:31 -0800
X-IronPort-AV: E=Sophos;i="5.70,403,1574150400"; 
   d="scan'208";a="254599234"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 16:50:31 -0800
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] memremap: Remove stale comments
Date:   Tue,  4 Feb 2020 16:50:29 -0800
Message-Id: <20200205005029.2177-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

TO: linux-kernel@vger.kernel.org
TO: Jason Gunthorpe <jgg@ziepe.ca>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Christoph Hellwig <hch@lst.de>
Fixes: 80a72d0af05a ("memremap: remove the data field in struct dev_pagemap")
Fixes: fdc029b19dfd ("memremap: remove the dev field in struct dev_pagemap")
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
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
2.21.0

