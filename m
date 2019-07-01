Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37B7433430
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 17:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfFCPvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 11:51:13 -0400
Received: from foss.arm.com ([217.140.101.70]:53590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbfFCPvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18B8B15AB;
        Mon,  3 Jun 2019 08:51:09 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0093B3F246;
        Mon,  3 Jun 2019 08:51:07 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 07/57] drivers: nvmem: Use bus_find_device_by_of_node helper
Date:   Mon,  3 Jun 2019 16:49:33 +0100
Message-Id: <1559577023-558-8-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using the bus_find_device_by_of_node helper

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/nvmem/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index c7892c3..63947d3 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -76,11 +76,6 @@ static struct bus_type nvmem_bus_type = {
 	.name		= "nvmem",
 };
 
-static int of_nvmem_match(struct device *dev, void *nvmem_np)
-{
-	return dev->of_node == nvmem_np;
-}
-
 static struct nvmem_device *of_nvmem_find(struct device_node *nvmem_np)
 {
 	struct device *d;
@@ -88,7 +83,7 @@ static struct nvmem_device *of_nvmem_find(struct device_node *nvmem_np)
 	if (!nvmem_np)
 		return NULL;
 
-	d = bus_find_device(&nvmem_bus_type, NULL, nvmem_np, of_nvmem_match);
+	d = bus_find_device_by_of_node(&nvmem_bus_type, NULL, nvmem_np);
 
 	if (!d)
 		return NULL;
-- 
2.7.4

