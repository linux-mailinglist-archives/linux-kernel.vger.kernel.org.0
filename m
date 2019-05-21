Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B98B724AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 10:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfEUI4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 04:56:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38066 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfEUI4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:56:33 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hT0ZM-0000vb-P9; Tue, 21 May 2019 08:56:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     Li Yang <leoyang.li@nxp.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] soc: fsl: fix spelling mistake "Firmaware" -> "Firmware"
Date:   Tue, 21 May 2019 09:56:24 +0100
Message-Id: <20190521085624.13665-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a pr_err message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/soc/fsl/dpaa2-console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/dpaa2-console.c b/drivers/soc/fsl/dpaa2-console.c
index 9168d8ddc932..27243f706f37 100644
--- a/drivers/soc/fsl/dpaa2-console.c
+++ b/drivers/soc/fsl/dpaa2-console.c
@@ -73,7 +73,7 @@ static u64 get_mc_fw_base_address(void)
 
 	mcfbaregs = ioremap(mc_base_addr.start, resource_size(&mc_base_addr));
 	if (!mcfbaregs) {
-		pr_err("could not map MC Firmaware Base registers\n");
+		pr_err("could not map MC Firmware Base registers\n");
 		return 0;
 	}
 
-- 
2.20.1

