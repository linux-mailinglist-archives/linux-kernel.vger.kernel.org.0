Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5B7CEEE2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 00:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfJGWLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 18:11:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:35933 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728654AbfJGWLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 18:11:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 15:11:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="193217380"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.155])
  by fmsmga007.fm.intel.com with ESMTP; 07 Oct 2019 15:11:09 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/2] mei: me: fix me_intr_clear function name in KDoc
Date:   Tue,  8 Oct 2019 03:57:35 +0300
Message-Id: <20191008005735.12707-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191008005735.12707-1-tomas.winkler@intel.com>
References: <20191008005735.12707-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index c4f6991d3028..5ef30c7c92b3 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -269,7 +269,7 @@ static inline void me_intr_disable(struct mei_device *dev, u32 hcsr)
 }
 
 /**
- * mei_me_intr_clear - clear and stop interrupts
+ * me_intr_clear - clear and stop interrupts
  *
  * @dev: the device structure
  * @hcsr: supplied hcsr register value
-- 
2.21.0

