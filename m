Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37E6712DFF0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jan 2020 19:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgAAS01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 13:26:27 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:13063
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727170AbgAAS00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 13:26:26 -0500
X-IronPort-AV: E=Sophos;i="5.69,382,1571695200"; 
   d="scan'208";a="334542272"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 01 Jan 2020 19:26:24 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] USB: omap_udc: use resource_size
Date:   Wed,  1 Jan 2020 18:49:41 +0100
Message-Id: <1577900990-8588-2-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1577900990-8588-1-git-send-email-Julia.Lawall@inria.fr>
References: <1577900990-8588-1-git-send-email-Julia.Lawall@inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use resource_size rather than a verbose computation on
the end and start fields.

The semantic patch that makes these changes is as follows:
(http://coccinelle.lip6.fr/)

<smpl>
@@ struct resource ptr; @@
- (ptr.end - ptr.start + 1)
+ resource_size(&ptr)
</smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/usb/gadget/udc/omap_udc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index f36f0730afab..bd12417996db 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2757,7 +2757,7 @@ static int omap_udc_probe(struct platform_device *pdev)
 
 	/* NOTE:  "knows" the order of the resources! */
 	if (!request_mem_region(pdev->resource[0].start,
-			pdev->resource[0].end - pdev->resource[0].start + 1,
+			resource_size(&pdev->resource[0]),
 			driver_name)) {
 		DBG("request_mem_region failed\n");
 		return -EBUSY;
@@ -2934,7 +2934,7 @@ static int omap_udc_probe(struct platform_device *pdev)
 	}
 
 	release_mem_region(pdev->resource[0].start,
-			pdev->resource[0].end - pdev->resource[0].start + 1);
+			   resource_size(&pdev->resource[0]));
 
 	return status;
 }
@@ -2950,7 +2950,7 @@ static int omap_udc_remove(struct platform_device *pdev)
 	wait_for_completion(&done);
 
 	release_mem_region(pdev->resource[0].start,
-			pdev->resource[0].end - pdev->resource[0].start + 1);
+			   resource_size(&pdev->resource[0]));
 
 	return 0;
 }

