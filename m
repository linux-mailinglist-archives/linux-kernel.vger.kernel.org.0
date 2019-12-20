Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 459FC128445
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 23:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfLTWFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 17:05:39 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57542 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbfLTWFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 17:05:37 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iiQOl-0005Ku-8o; Fri, 20 Dec 2019 22:05:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajmohan Mani <rajmohan.mani@intel.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] thunderbolt: fix memory leak of object sw
Date:   Fri, 20 Dec 2019 22:05:26 +0000
Message-Id: <20191220220526.11307-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where the call tb_switch_exceeds_max_depth is true
the error reurn path leaks memory in sw.  Fix this by setting
the return error code to -EADDRNOTAVAIL and returning via the
error exit path err_free_sw_ports to free sw. sw has been kzalloc'd
so the free of the NULL sw->ports is fine.

Addresses-Coverity: ("Resource leak")
Fixes: b04079837b20 ("thunderbolt: Add initial support for USB4")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/thunderbolt/switch.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 3454e6154958..ad5479f21174 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1885,8 +1885,10 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, struct device *parent,
 	sw->config.enabled = 0;
 
 	/* Make sure we do not exceed maximum topology limit */
-	if (tb_switch_exceeds_max_depth(sw, depth))
-		return ERR_PTR(-EADDRNOTAVAIL);
+	if (tb_switch_exceeds_max_depth(sw, depth)) {
+		ret = -EADDRNOTAVAIL;
+		goto err_free_sw_ports;
+	}
 
 	/* initialize ports */
 	sw->ports = kcalloc(sw->config.max_port_number + 1, sizeof(*sw->ports),
-- 
2.24.0

