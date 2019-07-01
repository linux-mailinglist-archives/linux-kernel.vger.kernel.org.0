Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9778C333E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 17:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfFCPvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 11:51:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53530 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728274AbfFCPvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D37C21688;
        Mon,  3 Jun 2019 08:51:02 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BAF2E3F246;
        Mon,  3 Jun 2019 08:51:01 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [RFC PATCH 03/57] drivers: coresight: Drop device references found via bus_find_device
Date:   Mon,  3 Jun 2019 16:49:29 +0100
Message-Id: <1559577023-558-4-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must drop references to the device found via bus_find_device().

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 4b13028..37ccd67 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -540,7 +540,7 @@ struct coresight_device *coresight_get_enabled_sink(bool deactivate)
 
 	dev = bus_find_device(&coresight_bustype, NULL, &deactivate,
 			      coresight_enabled_sink);
-
+	put_device(dev);
 	return dev ? to_coresight_device(dev) : NULL;
 }
 
@@ -581,7 +581,7 @@ struct coresight_device *coresight_get_sink_by_id(u32 id)
 
 	dev = bus_find_device(&coresight_bustype, NULL, &id,
 			      coresight_sink_by_id);
-
+	put_device(dev);
 	return dev ? to_coresight_device(dev) : NULL;
 }
 
-- 
2.7.4

