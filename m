Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0FA14E55D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 23:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgA3WKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 17:10:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46353 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgA3WKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 17:10:32 -0500
Received: by mail-pl1-f194.google.com with SMTP id y8so1861518pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 14:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9H2RnSRh5t12ovw0NiSc+WSENmGGlJVy0GVQJtIN60o=;
        b=KIgPDxHK5aqgBk32miQ4jy1WwY/DEJQAAytwKmhDczu9izDH5wyV2OTy27RoV2ktOc
         Bb+4/n+gC8bVqblArlwzfkLfjZ98GYpKYnHHeubFWuIlGYarNgO6TD9mjgRZxPq6H49I
         rNt7oL1x96w0vlcKlzdRsnPVl2LmB3Fuu19GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9H2RnSRh5t12ovw0NiSc+WSENmGGlJVy0GVQJtIN60o=;
        b=S3ZVGpeL4TWZBTcRMm1kJxXhT/u4gG0rzKn4XO48/fkX6kzvJVCm9HvksIPk56hWnh
         3SSvnYF0AAvYBt5yEXkTbNZG6WgCDTChLCXdz24AGpsCdXlYgevabo+vIfOrVn34cQf5
         cTOhDZmunOP6IvlTGpWSWdG0/O4mYFWoDVfQdZsWIoV5nUIfR8K2j6BA9Yz18cFz5Tqj
         QT2/6q2disghbNlaFCc6SeOy1weP4oym6rLSc8qY1GGz3iVcR890gzdU+j66zwy0Cdx9
         NMSamtcnQ/dR0NIsptJtcqJo9CP+zSwB6cjp/ljzMh/WBwJEzg8059oQqOcoePv7zQwV
         WsBw==
X-Gm-Message-State: APjAAAUSGCz7AXoseB72I4k/wpWilcjMPP2568FLbF81A1VVe2NsYcSk
        a9W8kInJIcL6YX0stLu5QGC9YIlBrNIVGg==
X-Google-Smtp-Source: APXvYqyY1v1oCoYe1tjP5PZ2ZM5QylnGd9R2uz+pobRK8RKkp1AJ/TfSe1meOvAn8uuUZhqKaTUA6w==
X-Received: by 2002:a17:902:9a85:: with SMTP id w5mr7124194plp.323.1580422231049;
        Thu, 30 Jan 2020 14:10:31 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id p16sm7403859pgi.50.2020.01.30.14.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 14:10:30 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, enric.balletbo@collabora.com,
        bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [RFC v2 2/3] platform/chrome: typec: Get PD_CONTROL version
Date:   Thu, 30 Jan 2020 14:07:46 -0800
Message-Id: <20200130220747.163053-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130220747.163053-1-pmalani@chromium.org>
References: <20200130220747.163053-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Query the EC to determine the version number of the USB_PD_CONTROL
command which is supported by the EC. Also store this value in the Type
C data struct since it will be used to determine how to parse the
response to queries for port information from the EC.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Fixed commit message title.

 drivers/platform/chrome/cros_ec_typec.c | 35 ++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index f48bb0172c565f..189c2192375c5d 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -22,6 +22,7 @@ struct cros_typec_data {
 	struct device *dev;
 	struct cros_ec_device *ec;
 	int num_ports;
+	unsigned int cmd_ver;
 	/* Array of ports, indexed by port number. */
 	struct typec_port *ports[EC_USB_PD_MAX_PORTS];
 };
@@ -137,6 +138,32 @@ static int cros_typec_get_num_ports(struct cros_typec_data *typec)
 	return 0;
 }
 
+static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
+{
+	struct ec_params_get_cmd_versions_v1 req_v1;
+	struct ec_response_get_cmd_versions resp;
+	int ret;
+
+	/* We're interested in the PD control command version. */
+	req_v1.cmd = EC_CMD_USB_PD_CONTROL;
+	ret = cros_ec_send_cmd_msg(typec->ec, 1, EC_CMD_GET_CMD_VERSIONS,
+				   &req_v1, sizeof(req_v1), &resp,
+				   sizeof(resp));
+	if (ret < 0) {
+		return ret;
+	}
+
+	if (resp.version_mask & EC_VER_MASK(1))
+		typec->cmd_ver = 1;
+	else
+		typec->cmd_ver = 0;
+
+	dev_dbg(typec->dev, "PD Control has version mask 0x%hhx\n",
+		typec->cmd_ver);
+
+	return 0;
+}
+
 static int cros_typec_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -160,8 +187,14 @@ static int cros_typec_probe(struct platform_device *pdev)
 		return -EOVERFLOW;
 	}
 
+	ret = cros_typec_get_cmd_version(typec);
+	if (ret < 0) {
+		dev_err(dev, "failed to get PD command version info\n");
+		return ret;
+	}
+
 	ret = cros_typec_init_ports(typec);
-	if (!ret)
+	if (ret < 0)
 		return ret;
 
 	return 0;
-- 
2.25.0.341.g760bfbb309-goog

