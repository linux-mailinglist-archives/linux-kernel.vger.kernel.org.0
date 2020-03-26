Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1FD31949DD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 22:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgCZVKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 17:10:11 -0400
Received: from sauhun.de ([88.99.104.3]:54366 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgCZVJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:09:59 -0400
Received: from localhost (p54B3331F.dip0.t-ipconnect.de [84.179.51.31])
        by pokefinder.org (Postfix) with ESMTPSA id DCD572C1F84;
        Thu, 26 Mar 2020 22:09:58 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] char: ipmi: convert to use i2c_new_client_device()
Date:   Thu, 26 Mar 2020 22:09:58 +0100
Message-Id: <20200326210958.13051-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326210958.13051-1-wsa+renesas@sang-engineering.com>
References: <20200326210958.13051-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move away from the deprecated API.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 8ac390c2b514..2791b799e33d 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1945,8 +1945,8 @@ static int ssif_adapter_handler(struct device *adev, void *opaque)
 	if (adev->type != &i2c_adapter_type)
 		return 0;
 
-	addr_info->added_client = i2c_new_device(to_i2c_adapter(adev),
-						 &addr_info->binfo);
+	addr_info->added_client = i2c_new_client_device(to_i2c_adapter(adev),
+							&addr_info->binfo);
 
 	if (!addr_info->adapter_name)
 		return 1; /* Only try the first I2C adapter by default. */
-- 
2.20.1

