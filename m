Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01CC313D2B1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 04:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgAPD3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 22:29:11 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:33809 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726587AbgAPD3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 22:29:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TnrLKNv_1579145341;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TnrLKNv_1579145341)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Jan 2020 11:29:09 +0800
From:   luanshi <zhangliguang@linux.alibaba.com>
To:     james.morse@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [V2 2/3] firmware: arm_sdei: Removed multiple white lines.
Date:   Thu, 16 Jan 2020 11:28:50 +0800
Message-Id: <1579145331-78633-2-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579145331-78633-1-git-send-email-zhangliguang@linux.alibaba.com>
References: <1579145331-78633-1-git-send-email-zhangliguang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove one unnecessary white line.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 drivers/firmware/arm_sdei.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 37e9bf0..f81c09e 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -599,7 +599,6 @@ static int _sdei_event_register(struct sdei_event *event)
 					       event->registered,
 					       SDEI_EVENT_REGISTER_RM_ANY, 0);
 
-
 	err = sdei_do_cross_call(_local_event_register, event);
 	if (err) {
 		spin_lock(&event->sdei_event_lock);
-- 
1.8.3.1

