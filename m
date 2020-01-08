Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 463191340C6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 12:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgAHLm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 06:42:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:62303 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbgAHLmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:42:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 03:42:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,409,1571727600"; 
   d="scan'208";a="422891944"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jan 2020 03:42:14 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5560B6E2; Wed,  8 Jan 2020 13:42:03 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 33/36] platform/x86: intel_pmc_ipc: Use octal permissions in sysfs attributes
Date:   Wed,  8 Jan 2020 14:41:58 +0300
Message-Id: <20200108114201.27908-34-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the current preferred way so replace the S_IWUSR with the
corresponding octal value. While there move the attributes to follow
directly their store functions.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_ipc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index acec1c6d2069..20a4bb72aeac 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -215,6 +215,7 @@ static ssize_t intel_pmc_ipc_simple_cmd_store(struct device *dev,
 	}
 	return (ssize_t)count;
 }
+static DEVICE_ATTR(simplecmd, 0200, NULL, intel_pmc_ipc_simple_cmd_store);
 
 static ssize_t intel_pmc_ipc_northpeak_store(struct device *dev,
 					     struct device_attribute *attr,
@@ -240,11 +241,7 @@ static ssize_t intel_pmc_ipc_northpeak_store(struct device *dev,
 	}
 	return (ssize_t)count;
 }
-
-static DEVICE_ATTR(simplecmd, S_IWUSR,
-		   NULL, intel_pmc_ipc_simple_cmd_store);
-static DEVICE_ATTR(northpeak, S_IWUSR,
-		   NULL, intel_pmc_ipc_northpeak_store);
+static DEVICE_ATTR(northpeak, 0200, NULL, intel_pmc_ipc_northpeak_store);
 
 static struct attribute *intel_ipc_attrs[] = {
 	&dev_attr_northpeak.attr,
-- 
2.24.1

