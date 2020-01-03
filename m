Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF3A12FAAC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 17:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgACQkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 11:40:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:47792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgACQkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:40:39 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 899F7206E6;
        Fri,  3 Jan 2020 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578069638;
        bh=TKY5B9he46GmvnJkwdmWtHvRFw0gy4YRKbRubwq1RA8=;
        h=From:To:Cc:Subject:Date:From;
        b=Em97YJUgy6L/J6qOkZ0wcXXcvgQ/C7FOEeXnwiJpPmr965ilT7u13CyoUSNfUVCyu
         UqhslCV7HveGSB/AK7Lo9297ReXVPlt854Q5lFNM9zw3U8EyAQEzd62x90baVVyOpg
         kivksL5aalawykbk6/M0NTpvcvRPBi5d1kuivKP8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] usb: ehci-mv: Fix missing iomem in cast
Date:   Fri,  3 Jan 2020 17:40:31 +0100
Message-Id: <20200103164031.4089-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix missing __iomem in cast to struct ehci_caps.  This fixes the Sparse
warning visible on x86_64 compile test:

   drivers/usb/host/ehci-mv.c:167:23: warning: cast removes address space '<asn:2>' of expression
   drivers/usb/host/ehci-mv.c:167:20: warning: incorrect type in assignment (different address spaces)
   drivers/usb/host/ehci-mv.c:167:20:    expected struct ehci_caps [noderef] <asn:2> *caps
   drivers/usb/host/ehci-mv.c:167:20:    got struct ehci_caps *

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/usb/host/ehci-mv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index 66ec1fdf9fe7..16df3cfbed26 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -164,7 +164,7 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	}
 
 	ehci = hcd_to_ehci(hcd);
-	ehci->caps = (struct ehci_caps *) ehci_mv->cap_regs;
+	ehci->caps = (struct ehci_caps __iomem *) ehci_mv->cap_regs;
 
 	if (ehci_mv->mode == MV_USB_MODE_OTG) {
 		ehci_mv->otg = devm_usb_get_phy(&pdev->dev, USB_PHY_TYPE_USB2);
-- 
2.17.1

