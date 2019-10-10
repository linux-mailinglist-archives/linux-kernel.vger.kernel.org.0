Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA77D26D0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 11:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbfJJJ5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 05:57:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49130 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfJJJ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:57:53 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iIVCf-0001GB-5Y; Thu, 10 Oct 2019 09:57:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: wfx: fix spelling mistake "non existant" -> "non-existent"
Date:   Thu, 10 Oct 2019 10:57:48 +0100
Message-Id: <20191010095748.17047-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_warn message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/wfx/hif_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/hif_rx.c b/drivers/staging/wfx/hif_rx.c
index 52db02d3aa41..36e171b27ae2 100644
--- a/drivers/staging/wfx/hif_rx.c
+++ b/drivers/staging/wfx/hif_rx.c
@@ -137,7 +137,7 @@ static int hif_receive_indication(struct wfx_dev *wdev, struct hif_msg *hif, voi
 	struct hif_ind_rx *body = buf;
 
 	if (!wvif) {
-		dev_warn(wdev->dev, "ignore rx data for non existant vif %d\n", hif->interface);
+		dev_warn(wdev->dev, "ignore rx data for non-existent vif %d\n", hif->interface);
 		return 0;
 	}
 	skb_pull(skb, sizeof(struct hif_msg) + sizeof(struct hif_ind_rx));
-- 
2.20.1

