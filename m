Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7C1B15D3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 23:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfILVVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 17:21:19 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.40]:23142 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728538AbfILVVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 17:21:19 -0400
X-Greylist: delayed 1492 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Sep 2019 17:21:19 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 4476B3CD06
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 15:56:27 -0500 (CDT)
Received: from gator3278.hostgator.com ([198.57.247.242])
        by cmsmtp with SMTP
        id 8W8gia33t3Qi08W8hiCMys; Thu, 12 Sep 2019 15:56:27 -0500
X-Authority-Reason: nr=8
Received: from 89-69-237-178.dynamic.chello.pl ([89.69.237.178]:40740 helo=comp.lan)
        by gator3278.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <arkadiusz@drabczyk.org>)
        id 1i8W8g-000GNC-3z; Thu, 12 Sep 2019 15:56:26 -0500
From:   Arkadiusz Drabczyk <arkadiusz@drabczyk.org>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: Update pointer to documentation
Date:   Thu, 12 Sep 2019 22:56:06 +0200
Message-Id: <20190912205606.31095-1-arkadiusz@drabczyk.org>
X-Mailer: git-send-email 2.9.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator3278.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drabczyk.org
X-BWhitelist: no
X-Source-IP: 89.69.237.178
X-Source-L: No
X-Exim-ID: 1i8W8g-000GNC-3z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 89-69-237-178.dynamic.chello.pl (comp.lan) [89.69.237.178]:40740
X-Source-Auth: arkadiusz@drabczyk.org
X-Email-Count: 1
X-Source-Cap: cmt1bXZicmg7cmt1bXZicmg7Z2F0b3IzMjc4Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation was revamped in 113ccc but link in
firmware_loader/main.c hasn't been updated.

Signed-off-by: Arkadiusz Drabczyk <arkadiusz@drabczyk.org>
---
 drivers/base/firmware_loader/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index bf44c79..d5995d7 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -4,7 +4,7 @@
  *
  * Copyright (c) 2003 Manuel Estrada Sainz
  *
- * Please see Documentation/firmware_class/ for more information.
+ * Please see Documentation/driver-api/firmware/ for more information.
  *
  */
 
-- 
2.9.0

