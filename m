Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7833B17E254
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 15:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgCIOLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 10:11:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:10543 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgCIOLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:11:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 07:11:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,533,1574150400"; 
   d="scan'208";a="288698406"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Mar 2020 07:11:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1A736193; Mon,  9 Mar 2020 16:11:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] driver core: Replace open-coded list_last_entry()
Date:   Mon,  9 Mar 2020 16:11:11 +0200
Message-Id: <20200309141111.40576-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309141111.40576-1-andriy.shevchenko@linux.intel.com>
References: <20200309141111.40576-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a place in the code where open-coded version of list entry accessors
list_last_entry() is used.

Replace that with the standard macro.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/dd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index efd0e4c16ba5..27a4d51b5bba 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1226,7 +1226,7 @@ void driver_detach(struct device_driver *drv)
 			spin_unlock(&drv->p->klist_devices.k_lock);
 			break;
 		}
-		dev_prv = list_entry(drv->p->klist_devices.k_list.prev,
+		dev_prv = list_last_entry(&drv->p->klist_devices.k_list,
 				     struct device_private,
 				     knode_driver.n_node);
 		dev = dev_prv->device;
-- 
2.25.1

