Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD7ECFE476
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 19:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKOSBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 13:01:02 -0500
Received: from mga06.intel.com ([134.134.136.31]:60146 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfKOSA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:00:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 10:00:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,309,1569308400"; 
   d="scan'208";a="203452177"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 15 Nov 2019 10:00:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B964E3A0; Fri, 15 Nov 2019 20:00:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v1 3/5] ALSA: hda: Drop duplicate check for size parameter of memremap()
Date:   Fri, 15 Nov 2019 20:00:42 +0200
Message-Id: <20191115180044.83659-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191115180044.83659-1-andriy.shevchenko@linux.intel.com>
References: <20191115180044.83659-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since memremap() returns NULL pointer for size = 0, there is no need
to duplicate this check in the callers.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/hda/intel-nhlt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/hda/intel-nhlt.c b/sound/hda/intel-nhlt.c
index 097ff6c10099..5fc10f1b244c 100644
--- a/sound/hda/intel-nhlt.c
+++ b/sound/hda/intel-nhlt.c
@@ -16,7 +16,7 @@ struct nhlt_acpi_table *intel_nhlt_init(struct device *dev)
 	acpi_handle handle;
 	union acpi_object *obj;
 	struct nhlt_resource_desc *nhlt_ptr;
-	struct nhlt_acpi_table *nhlt_table = NULL;
+	struct nhlt_acpi_table *nhlt_table;
 
 	handle = ACPI_HANDLE(dev);
 	if (!handle) {
@@ -36,8 +36,7 @@ struct nhlt_acpi_table *intel_nhlt_init(struct device *dev)
 	}
 
 	nhlt_ptr = (struct nhlt_resource_desc  *)obj->buffer.pointer;
-	if (nhlt_ptr->length)
-		nhlt_table = (struct nhlt_acpi_table *)
+	nhlt_table = (struct nhlt_acpi_table *)
 			memremap(nhlt_ptr->min_addr, nhlt_ptr->length,
 				 MEMREMAP_WB);
 	ACPI_FREE(obj);
-- 
2.24.0

