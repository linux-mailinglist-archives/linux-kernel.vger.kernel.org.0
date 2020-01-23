Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93B8C146014
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 01:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgAWAsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 19:48:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52766 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWAsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 19:48:18 -0500
Received: from [82.43.126.140] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iuQfN-0006ib-2P; Thu, 23 Jan 2020 00:48:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: rockchip: fix spelling mistake "to" -> "too"
Date:   Thu, 23 Jan 2020 00:48:07 +0000
Message-Id: <20200123004807.2833556-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
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
 arch/arm/mach-rockchip/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index 649e0a54784c..d60856898d97 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -180,7 +180,7 @@ static int __init rockchip_smp_prepare_sram(struct device_node *node)
 
 	rsize = resource_size(&res);
 	if (rsize < trampoline_sz) {
-		pr_err("%s: reserved block with size 0x%x is to small for trampoline size 0x%x\n",
+		pr_err("%s: reserved block with size 0x%x is too small for trampoline size 0x%x\n",
 		       __func__, rsize, trampoline_sz);
 		return -EINVAL;
 	}
-- 
2.24.0

