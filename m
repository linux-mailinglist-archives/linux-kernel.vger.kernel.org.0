Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBB3145F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 00:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgAVXom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 18:44:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51672 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVXom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 18:44:42 -0500
Received: from [82.43.126.140] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iuPfp-0007xo-Tk; Wed, 22 Jan 2020 23:44:38 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Pawel Laszczak <pawell@cadence.com>, linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: cdns3: fix spelling mistake and rework grammar in text
Date:   Wed, 22 Jan 2020 23:44:37 +0000
Message-Id: <20200122234437.2829803-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The text contains a spelling mistake, "to" should be "too"
so fix this and re-work the grammar to make it more readable.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/cdns3/debug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/debug.h b/drivers/usb/cdns3/debug.h
index 2c9afbfe988b..a5c6a29e1340 100644
--- a/drivers/usb/cdns3/debug.h
+++ b/drivers/usb/cdns3/debug.h
@@ -140,7 +140,7 @@ static inline char *cdns3_dbg_ring(struct cdns3_endpoint *priv_ep,
 		trb_per_sector = TRBS_PER_SEGMENT;
 
 	if (trb_per_sector > TRBS_PER_SEGMENT) {
-		sprintf(str + ret, "\t\tTo big transfer ring %d\n",
+		sprintf(str + ret, "\t\tTransfer ring %d too big\n",
 			trb_per_sector);
 		return str;
 	}
-- 
2.24.0

