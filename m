Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBC273390A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 21:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfFCTYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 15:24:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfFCTYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:24:17 -0400
Received: from localhost.localdomain (unknown [194.230.155.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB4BE2673F;
        Mon,  3 Jun 2019 19:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559589857;
        bh=/LooAfLWrCT1T8tDGhy1qtaoR6dOFBqW+Qnf0Z9e0n8=;
        h=From:To:Cc:Subject:Date:From;
        b=WksON4WZd9b9oL9cGzpDmko+SFiAP9FbCRMSD6abTLztlvhl+6S1lipfjh3Pdqfjg
         h2LefCzBXO1wCsQhdw1o5ONb3kOnbUYLj8Z7V6eFUyMcJIZGueRXECI6owh7RCAjGP
         v3+nYtmFQ/Sz4lZV2ls+xQfk5TInRDAhKAO2XSw0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] config: android: Remove left-over BACKLIGHT_LCD_SUPPORT
Date:   Mon,  3 Jun 2019 21:24:08 +0200
Message-Id: <20190603192408.30915-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_BACKLIGHT_LCD_SUPPORT was removed in commit 8c5dc8d9f19c
("video: backlight: Remove useless BACKLIGHT_LCD_SUPPORT kernel
symbol"). Options protected by CONFIG_BACKLIGHT_LCD_SUPPORT are now
available directly.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 kernel/configs/android-recommended.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/configs/android-recommended.config b/kernel/configs/android-recommended.config
index 81e9af7dcec2..c51f4c221ad6 100644
--- a/kernel/configs/android-recommended.config
+++ b/kernel/configs/android-recommended.config
@@ -7,7 +7,6 @@
 # CONFIG_PM_WAKELOCKS_GC is not set
 # CONFIG_VT is not set
 CONFIG_ARM64_SW_TTBR0_PAN=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_BLK_DEV_DM=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
-- 
2.17.1

