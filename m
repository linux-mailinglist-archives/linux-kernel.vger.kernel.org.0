Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E863B33400
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 17:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbfFCPw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 11:52:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54118 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729600AbfFCPwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:52:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58E381A25;
        Mon,  3 Jun 2019 08:52:24 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3EFF23F246;
        Mon,  3 Jun 2019 08:52:23 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [RFC PATCH 56/57] drivers: Introduce driver_find_next_device() helper
Date:   Mon,  3 Jun 2019 16:50:22 +0100
Message-Id: <1559577023-558-57-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to bus_find_next_device(), add a helper to find
the next device for the given driver.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 include/linux/device.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 528efc0..39a7755 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -456,6 +456,12 @@ driver_find_device_by_fwnode(struct device_driver *drv,
 	return driver_find_device(drv, start, (void *)fwnode, device_match_fwnode);
 }
 
+static inline struct device *driver_find_next_device(struct device_driver *drv,
+						     struct device *start)
+{
+	return driver_find_device(drv, start, NULL, device_match_any);
+}
+
 void driver_deferred_probe_add(struct device *dev);
 int driver_deferred_probe_check_state(struct device *dev);
 
-- 
2.7.4

