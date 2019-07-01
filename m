Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A15C3342E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 17:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfFCPyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 11:54:43 -0400
Received: from foss.arm.com ([217.140.101.70]:53662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728750AbfFCPvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2C461715;
        Mon,  3 Jun 2019 08:51:19 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CDD5D3F246;
        Mon,  3 Jun 2019 08:51:18 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com
Subject: [RFC PATCH 14/57] drivers: devcon: Use bus_find_device_by_fwnode helper
Date:   Mon,  3 Jun 2019 16:49:40 +0100
Message-Id: <1559577023-558-15-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using the bus_find_device_by_fwnode helper

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/base/devcon.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index 04db9ae..d9bcf77 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -107,19 +107,13 @@ static struct bus_type *generic_match_buses[] = {
 	NULL,
 };
 
-static int device_fwnode_match(struct device *dev, void *fwnode)
-{
-	return dev_fwnode(dev) == fwnode;
-}
-
 static void *device_connection_fwnode_match(struct device_connection *con)
 {
 	struct bus_type *bus;
 	struct device *dev;
 
 	for (bus = generic_match_buses[0]; bus; bus++) {
-		dev = bus_find_device(bus, NULL, (void *)con->fwnode,
-				      device_fwnode_match);
+		dev = bus_find_device_by_fwnode(bus, NULL, con->fwnode);
 		if (dev && !strncmp(dev_name(dev), con->id, strlen(con->id)))
 			return dev;
 
-- 
2.7.4

