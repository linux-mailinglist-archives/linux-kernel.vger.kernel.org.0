Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 722F1108CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 12:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfKYL20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 06:28:26 -0500
Received: from foss.arm.com ([217.140.110.172]:49066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbfKYL2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:28:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4A941396;
        Mon, 25 Nov 2019 03:28:18 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0644D3F52E;
        Mon, 25 Nov 2019 03:28:17 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/14] driver: base: cpu: Export device_online/offline
Date:   Mon, 25 Nov 2019 11:27:49 +0000
Message-Id: <20191125112754.25223-10-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191125112754.25223-1-qais.yousef@arm.com>
References: <20191125112754.25223-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And the {lock,unlock}_device_hotplug so that they can be used from
modules.

This is in preparation to replace cpu_up/down with
device_online/offline; which kernel/torture.c will require to be
exported to be built as a module.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>
CC: linux-kernel@vger.kernel.org
---
 drivers/base/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7bd9cd366d41..29b40c71b1ba 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -883,11 +883,13 @@ void lock_device_hotplug(void)
 {
 	mutex_lock(&device_hotplug_lock);
 }
+EXPORT_SYMBOL_GPL(lock_device_hotplug);
 
 void unlock_device_hotplug(void)
 {
 	mutex_unlock(&device_hotplug_lock);
 }
+EXPORT_SYMBOL_GPL(unlock_device_hotplug);
 
 int lock_device_hotplug_sysfs(void)
 {
@@ -2679,6 +2681,7 @@ int device_offline(struct device *dev)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(device_offline);
 
 /**
  * device_online - Put the device back online after successful device_offline().
@@ -2710,6 +2713,7 @@ int device_online(struct device *dev)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(device_online);
 
 struct root_device {
 	struct device dev;
-- 
2.17.1

