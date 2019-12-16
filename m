Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF631205A5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 13:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfLPM3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 07:29:48 -0500
Received: from sauhun.de ([88.99.104.3]:39754 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbfLPM3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:29:46 -0500
Received: from localhost (p54B33297.dip0.t-ipconnect.de [84.179.50.151])
        by pokefinder.org (Postfix) with ESMTPSA id CF81D2C2D6D;
        Mon, 16 Dec 2019 13:29:44 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] macintosh: convert to i2c_new_scanned_device
Date:   Mon, 16 Dec 2019 13:29:39 +0100
Message-Id: <20191216122939.3411-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216122939.3411-1-wsa+renesas@sang-engineering.com>
References: <20191216122939.3411-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move from the deprecated i2c_new_probed_device() to the new
i2c_new_scanned_device(). Make use of the new ERRPTR if suitable.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only.

 drivers/macintosh/therm_windtunnel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index 8c744578122a..f15fec5e1cb6 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -321,10 +321,10 @@ do_attach( struct i2c_adapter *adapter )
 
 		memset(&info, 0, sizeof(struct i2c_board_info));
 		strlcpy(info.type, "therm_ds1775", I2C_NAME_SIZE);
-		i2c_new_probed_device(adapter, &info, scan_ds1775, NULL);
+		i2c_new_scanned_device(adapter, &info, scan_ds1775, NULL);
 
 		strlcpy(info.type, "therm_adm1030", I2C_NAME_SIZE);
-		i2c_new_probed_device(adapter, &info, scan_adm1030, NULL);
+		i2c_new_scanned_device(adapter, &info, scan_adm1030, NULL);
 
 		if( x.thermostat && x.fan ) {
 			x.running = 1;
-- 
2.20.1

