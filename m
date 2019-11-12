Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFDE1F997D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 20:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKLTPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 14:15:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33341 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfKLTPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:15:02 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iUbcz-00033W-6X; Tue, 12 Nov 2019 19:15:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     Marek Behun <marek.behun@nic.cz>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: turris-mox-rwtm: fix indentation issue
Date:   Tue, 12 Nov 2019 19:15:00 +0000
Message-Id: <20191112191500.283071-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a statement that is indented too deeply, remove
the extraneous tab.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/firmware/turris-mox-rwtm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index 72be58960e54..e27f68437b56 100644
--- a/drivers/firmware/turris-mox-rwtm.c
+++ b/drivers/firmware/turris-mox-rwtm.c
@@ -197,7 +197,7 @@ static int mox_get_board_info(struct mox_rwtm *rwtm)
 		rwtm->serial_number = reply->status[1];
 		rwtm->serial_number <<= 32;
 		rwtm->serial_number |= reply->status[0];
-			rwtm->board_version = reply->status[2];
+		rwtm->board_version = reply->status[2];
 		rwtm->ram_size = reply->status[3];
 		reply_to_mac_addr(rwtm->mac_address1, reply->status[4],
 				  reply->status[5]);
-- 
2.20.1

