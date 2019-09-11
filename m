Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F813AF9EF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 12:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfIKKHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 06:07:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49642 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfIKKHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:07:47 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1i7zXN-0000Mc-Fk; Wed, 11 Sep 2019 10:07:45 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: host: u132-hcd: fix spelling mistake "overcurren" -> "overcurrent"
Date:   Wed, 11 Sep 2019 11:07:45 +0100
Message-Id: <20190911100745.30711-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a module parameter description. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/host/u132-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index 4efee34f154f..e9209e3e6248 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -71,7 +71,7 @@ INT_MODULE_PARM(testing, 0);
 /* Some boards misreport power switching/overcurrent*/
 static bool distrust_firmware = true;
 module_param(distrust_firmware, bool, 0);
-MODULE_PARM_DESC(distrust_firmware, "true to distrust firmware power/overcurren"
+MODULE_PARM_DESC(distrust_firmware, "true to distrust firmware power/overcurrent"
 	"t setup");
 static DECLARE_WAIT_QUEUE_HEAD(u132_hcd_wait);
 /*
-- 
2.20.1

