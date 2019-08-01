Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0422C7D93F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 12:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbfHAKUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 06:20:36 -0400
Received: from foss.arm.com ([217.140.110.172]:33588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728060AbfHAKUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 06:20:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D1FC1597;
        Thu,  1 Aug 2019 03:20:33 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3CB223F575;
        Thu,  1 Aug 2019 03:20:32 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, lkp@intel.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 2/3] drivers: Fix typo in parameter description for driver_find_device_by_acpi_dev
Date:   Thu,  1 Aug 2019 11:20:25 +0100
Message-Id: <20190801102026.27312-2-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801102026.27312-1-suzuki.poulose@arm.com>
References: <20190801061042.GA1132@kroah.com>
 <20190801102026.27312-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in the comment describing the parameters for the new API, which
triggers the following warning for htmldocs:

include/linux/device.h:479: warning: Function parameter or member 'drv' not described in 'driver_find_device_by_acpi_dev'

Reported-by: kbuild test robot <lkp@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 include/linux/device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 26af63847ca7..b17548b94c3e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -467,7 +467,7 @@ driver_find_device_by_fwnode(struct device_driver *drv,
 /**
  * driver_find_device_by_devt- device iterator for locating a particular device
  * by devt.
- * @driver: the driver we're iterating
+ * @drv: the driver we're iterating
  * @devt: devt pointer to match.
  */
 static inline struct device *driver_find_device_by_devt(struct device_driver *drv,
-- 
2.21.0

