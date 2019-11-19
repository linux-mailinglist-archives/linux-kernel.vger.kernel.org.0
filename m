Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF81B102ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 18:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfKSRfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 12:35:01 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:37670 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728060AbfKSRfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:35:01 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Tia1I97_1574184888;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0Tia1I97_1574184888)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Nov 2019 01:34:58 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     zhiche.yy@alibaba-inc.com, xlpang@linux.alibaba.com,
        Wen Yang <wenyang@linux.alibaba.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] intel_th: avoid double free in error flow
Date:   Wed, 20 Nov 2019 01:34:47 +0800
Message-Id: <20191119173447.2454-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a possible double free issue in intel_th_subdevice_alloc:

651         err = intel_th_device_add_resources(thdev, res, subdev->nres);
652         if (err) {
653                 put_device(&thdev->dev);
654                 goto fail_put_device;     ---> freed
655         }
...
687 fail_put_device:
688         put_device(&thdev->dev);          ---> double freed
689

This patch fix it by removing the unnecessary put_device().

Fixes: a753bfcfdb1f ("intel_th: Make the switch allocate its subdevices")
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
---
 drivers/hwtracing/intel_th/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index d5c1821..98d195c 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -649,10 +649,8 @@ static inline void intel_th_request_hub_module_flush(struct intel_th *th)
 	}
 
 	err = intel_th_device_add_resources(thdev, res, subdev->nres);
-	if (err) {
-		put_device(&thdev->dev);
+	if (err)
 		goto fail_put_device;
-	}
 
 	if (subdev->type == INTEL_TH_OUTPUT) {
 		if (subdev->mknode)
-- 
1.8.3.1

