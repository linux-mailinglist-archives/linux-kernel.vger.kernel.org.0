Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20BEB1438AE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 09:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgAUIst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 03:48:49 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:52190 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbgAUIst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:48:49 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0ToHXcN0_1579596527;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHXcN0_1579596527)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:48:47 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     David Airlie <airlied@linux.ie>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] agp/via: remove unused current_size
Date:   Tue, 21 Jan 2020 16:48:44 +0800
Message-Id: <1579596524-257369-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one care the current_size, so don't bother to get current_size.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: David Airlie <airlied@linux.ie> 
Cc: Arnd Bergmann <arnd@arndb.de> 
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> 
Cc: linux-kernel@vger.kernel.org 
---
 drivers/char/agp/via-agp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/char/agp/via-agp.c b/drivers/char/agp/via-agp.c
index 87a92a044570..dc594f4eca38 100644
--- a/drivers/char/agp/via-agp.c
+++ b/drivers/char/agp/via-agp.c
@@ -128,9 +128,6 @@ static int via_fetch_size_agp3(void)
 static int via_configure_agp3(void)
 {
 	u32 temp;
-	struct aper_size_info_16 *current_size;
-
-	current_size = A_SIZE_16(agp_bridge->current_size);
 
 	/* address to map to */
 	agp_bridge->gart_bus_addr = pci_bus_address(agp_bridge->dev,
-- 
1.8.3.1

