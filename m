Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F80D034B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 00:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfJHWSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 18:18:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45224 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHWSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:18:37 -0400
Received: by mail-io1-f68.google.com with SMTP id c25so426447iot.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Py9QJX7qhRtI3RVtQMuyJHB60SSixZWVKU2LBYXikqo=;
        b=A35FoO8jdY6LIxFUegLaV/812sjqHUdjHeaYRb6Lpcb/vBnKUOmpQ3ULxdL0T5IRrD
         9kt8/jvyv8ffUfMXJDMlEoHGXdaIfqL07VBTrold86upw7WAxWcXCQ+XHzkW3TQPdJSg
         5CWjBQsEFby9vNfIt8n+/J9njJiLhXr/ejSfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Py9QJX7qhRtI3RVtQMuyJHB60SSixZWVKU2LBYXikqo=;
        b=QZBlAWmY72aE/jWl34KCQwrTWPDRcUmTvMAJbIasII6JotVRxWdfjZHgXVjVSDtq1O
         Cuhybx4YZJCRMvA8chm7IzwJVzLpF51QQBxtY+YTFJ0AJ8ZA+0m9xq08FrnWGhhZygIT
         m2+uNPFSarJsBPJP74GnpBlZrElxBO/8P+PlHHXtO38WIil45fqeV02y3Z1j5f6BK7kD
         xqXlMjl1PP69IMYmRH4/unO/FKsBp5Z1ph7tovi52bSfFUFIn5/spT0H35S2gi/i7agZ
         cAsmANmWnSeB524DtJsQ8deHIupdFvD5f/uZwLF1C1askhGYI83P8oYUmAU7lHo6v44s
         bMvg==
X-Gm-Message-State: APjAAAWcNU5HAgaAtyh4la2whePBsmD9H0vxnDfzFzBbxCwrti44Nj3L
        V2z229B7lBiRrhldhiqGE6Wfe4S8Pq8=
X-Google-Smtp-Source: APXvYqwBw5aTkR8AgncxMffxoZxlK6opmbln5C2nn3+XWcPLg+/0Ipzd+JYD+RLOgyd7Xt/IOXKe3Q==
X-Received: by 2002:a92:3314:: with SMTP id a20mr779152ilf.276.1570573116401;
        Tue, 08 Oct 2019 15:18:36 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:5d69:b29f:8fd8:6f45])
        by smtp.gmail.com with ESMTPSA id h18sm148802iog.52.2019.10.08.15.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 15:18:35 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Campello <campello@chromium.org>,
        Nick Crews <ncrews@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH v4] wilco_ec: Add Dell's USB PowerShare Policy control
Date:   Tue,  8 Oct 2019 16:18:30 -0600
Message-Id: <20191008161749.1.I4476e6e2b1026ff388eb11813310264e25aa9cc9@changeid>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB PowerShare is a policy which affects charging via the special
USB PowerShare port (marked with a small lightning bolt or battery icon)
when in low power states:
- In S0, the port will always provide power.
- In S0ix, if usb_charge is enabled, then power will be supplied to
  the port when on AC or if battery is > 50%. Else no power is supplied.
- In S5, if usb_charge is enabled, then power will be supplied to
  the port when on AC. Else no power is supplied.

Signed-off-by: Daniel Campello <campello@chromium.org>
Signed-off-by: Nick Crews <ncrews@chromium.org>
---

v4 changes:
- Renamed from usb_power_share to usb_charge to match existing feature
in other platforms in the kernel (i.e., sony-laptop, samsung-laptop,
lg-laptop)
v3 changes:
- Drop a silly blank line
- Use val > 1 instead of val != 0 && val != 1
v2 changes:
- Move documentation to Documentation/ABI/testing/sysfs-platform-wilco-ec
- Zero out reserved bytes in requests.

 .../ABI/testing/sysfs-platform-wilco-ec       | 17 ++++
 drivers/platform/chrome/wilco_ec/sysfs.c      | 91 +++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-wilco-ec b/Documentation/ABI/testing/sysfs-platform-wilco-ec
index 8827a734f933..bb7ba67cae97 100644
--- a/Documentation/ABI/testing/sysfs-platform-wilco-ec
+++ b/Documentation/ABI/testing/sysfs-platform-wilco-ec
@@ -31,6 +31,23 @@ Description:
                Output will a version string be similar to the example below:
                08B6

+What:		/sys/bus/platform/devices/GOOG000C\:00/usb_charge
+Date:		October 2019
+KernelVersion:	5.5
+Description:
+		Control the USB PowerShare Policy. USB PowerShare is a policy
+		which affects charging via the special USB PowerShare port
+		(marked with a small lightning bolt or battery icon) when in
+		low power states:
+		- In S0, the port will always provide power.
+		- In S0ix, if usb_charge is enabled, then power will be
+		  supplied to the port when on AC or if battery is > 50%.
+		  Else no power is supplied.
+		- In S5, if usb_charge is enabled, then power will be supplied
+		  to the port when on AC. Else no power is supplied.
+
+		Input should be either "0" or "1".
+
 What:          /sys/bus/platform/devices/GOOG000C\:00/version
 Date:          May 2019
 KernelVersion: 5.3
diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
index 3b86a21005d3..f0d174b6bb21 100644
--- a/drivers/platform/chrome/wilco_ec/sysfs.c
+++ b/drivers/platform/chrome/wilco_ec/sysfs.c
@@ -23,6 +23,26 @@ struct boot_on_ac_request {
 	u8 reserved7;
 } __packed;

+#define CMD_USB_CHARGE 0x39
+
+enum usb_charge_op {
+	USB_CHARGE_GET = 0,
+	USB_CHARGE_SET = 1,
+};
+
+struct usb_charge_request {
+	u8 cmd;		/* Always CMD_USB_CHARGE */
+	u8 reserved;
+	u8 op;		/* One of enum usb_charge_op */
+	u8 val;		/* When setting, either 0 or 1 */
+} __packed;
+
+struct usb_charge_response {
+	u8 reserved;
+	u8 status;	/* Set by EC to 0 on success, other value on failure */
+	u8 val;		/* When getting, set by EC to either 0 or 1 */
+} __packed;
+
 #define CMD_EC_INFO			0x38
 enum get_ec_info_op {
 	CMD_GET_EC_LABEL	= 0,
@@ -131,12 +151,83 @@ static ssize_t model_number_show(struct device *dev,

 static DEVICE_ATTR_RO(model_number);

+static int send_usb_charge(struct wilco_ec_device *ec,
+				struct usb_charge_request *rq,
+				struct usb_charge_response *rs)
+{
+	struct wilco_ec_message msg;
+	int ret;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.type = WILCO_EC_MSG_LEGACY;
+	msg.request_data = rq;
+	msg.request_size = sizeof(*rq);
+	msg.response_data = rs;
+	msg.response_size = sizeof(*rs);
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret < 0)
+		return ret;
+	if (rs->status)
+		return -EIO;
+
+	return 0;
+}
+
+static ssize_t usb_charge_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(dev);
+	struct usb_charge_request rq;
+	struct usb_charge_response rs;
+	int ret;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.cmd = CMD_USB_CHARGE;
+	rq.op = USB_CHARGE_GET;
+
+	ret = send_usb_charge(ec, &rq, &rs);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d\n", rs.val);
+}
+
+static ssize_t usb_charge_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(dev);
+	struct usb_charge_request rq;
+	struct usb_charge_response rs;
+	int ret;
+	u8 val;
+
+	ret = kstrtou8(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+	if (val > 1)
+		return -EINVAL;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.cmd = CMD_USB_CHARGE;
+	rq.op = USB_CHARGE_SET;
+	rq.val = val;
+
+	ret = send_usb_charge(ec, &rq, &rs);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(usb_charge);

 static struct attribute *wilco_dev_attrs[] = {
 	&dev_attr_boot_on_ac.attr,
 	&dev_attr_build_date.attr,
 	&dev_attr_build_revision.attr,
 	&dev_attr_model_number.attr,
+	&dev_attr_usb_charge.attr,
 	&dev_attr_version.attr,
 	NULL,
 };
--
2.23.0.581.g78d2f28ef7-goog

