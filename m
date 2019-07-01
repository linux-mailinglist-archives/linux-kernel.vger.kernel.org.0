Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEA0D39844
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2019 00:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbfFGWKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 18:10:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:58792 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731524AbfFGWKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:10:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 15:10:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,564,1557212400"; 
   d="scan'208";a="182814110"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2019 15:10:03 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 4/5] x86/umwait: Add sysfs interface to control umwait maximum time
Date:   Fri,  7 Jun 2019 15:00:36 -0700
Message-Id: <1559944837-149589-5-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA32_UMWAIT_CONTROL[31:2] determines the maximum time in TSC-quanta
that processor can stay in C0.1 or C0.2. A zero value means no maximum
time.

Each instruction sets its own deadline in the instruction's implicit
input EDX:EAX value. The instruction wakes up if the time-stamp counter
reaches or exceeds the specified deadline, or the umwait maximum time
expires, or a store happens in the monitored address range in umwait.

Users can write an unsigned 32-bit number to
/sys/devices/system/cpu/umwait_control/max_time to change the default
value. Note that a value of zero means there is no limit. Low order
two bits must be zero.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/power/umwait.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/x86/power/umwait.c b/arch/x86/power/umwait.c
index 9c176f3e59b6..7fa381e3fd4e 100644
--- a/arch/x86/power/umwait.c
+++ b/arch/x86/power/umwait.c
@@ -104,8 +104,47 @@ static ssize_t enable_c02_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(enable_c02);
 
+static ssize_t
+max_time_show(struct device *kobj, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", get_umwait_control_max_time());
+}
+
+static ssize_t max_time_store(struct device *kobj,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	u32 max_time;
+	int ret;
+
+	ret = kstrtou32(buf, 0, &max_time);
+	if (ret)
+		return ret;
+
+	/* bits[1:0] must be zero */
+	if (max_time & ~MSR_IA32_UMWAIT_CONTROL_MAX_TIME)
+		return -EINVAL;
+
+	mutex_lock(&umwait_lock);
+
+	if (max_time == get_umwait_control_max_time())
+		goto out_unlock;
+
+	umwait_control_cached = max_time | get_umwait_control_c02();
+
+	/* Update umwait max time on all CPUs */
+	on_each_cpu(umwait_control_msr_update, NULL, 1);
+
+out_unlock:
+	mutex_unlock(&umwait_lock);
+
+	return count;
+}
+static DEVICE_ATTR_RW(max_time);
+
 static struct attribute *umwait_attrs[] = {
 	&dev_attr_enable_c02.attr,
+	&dev_attr_max_time.attr,
 	NULL
 };
 
-- 
2.19.1

