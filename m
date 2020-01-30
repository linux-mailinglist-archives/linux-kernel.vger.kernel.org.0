Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4410214E545
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 23:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgA3WBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 17:01:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46367 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgA3WBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 17:01:48 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so2332268pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 14:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lliL7/3pwt4VFfxOj7m/6XdB9CxTiAptU2VTzMYYqyI=;
        b=XcjNDeCrawm1dIODsKko5J+z9u+yjQmsi1ogXCXXdhnFqfRmpAKVkmVwRym0V+mYvA
         ylZlRPRwywR9j+Qd7GQqtivgEse2TXTwLH4VAeLUsU23/Ig3Dtp0aJklp5gkb2TZXhwf
         2xxl5pIYfpgntaoH5d+Pc7RyqHzxGSk7OoU/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lliL7/3pwt4VFfxOj7m/6XdB9CxTiAptU2VTzMYYqyI=;
        b=LqUb2M1zRqUmB3uJvwcBa3ZXz9Sntb9Eq+ICG3vQabmvN4/yACPa1gqXb53AG3IANZ
         qOJDD7SfedmJWDg2f6ON6tvtn0JTIJ1RJElQZyjLmZ8RTxXHySRH3SucIqgYdB0VdoEo
         kbyClNWM2KqAIWsM98VSEnne/vcMLtiZGRcIlPdcgcBM98yNBU3jonXLaP6Woy8127LD
         mGBYtegCxLn3FpQG9AYyW7+dy9Hfxbl3pqVgsz5L0pSqDb/87wShRMIBPRb42ckCpK38
         5yQSQXtin8ofsB6pZZlmODJwn5RvgLP6N5X91IyfHDl+MeWCwB52gCTG285pAgj+Hudz
         BDEQ==
X-Gm-Message-State: APjAAAVPkmETWikJ4ya1FVrO573YrS3lkOKkx7UqoKpt/Vn5HVlF1EqL
        rOUnfQg5zcrOdP0e2jvqd7C1T257s0R8wA==
X-Google-Smtp-Source: APXvYqzDRPhNEgFE44OIWTnGWicemk/4/h6xpXfYIL9U9JdfyhSfCGC1WOfRWS3OX7vqB+X6dMjGbA==
X-Received: by 2002:a63:de03:: with SMTP id f3mr7000619pgg.141.1580421706888;
        Thu, 30 Jan 2020 14:01:46 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id g21sm8219849pfb.126.2020.01.30.14.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 14:01:46 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, enric.balletbo@collabora.com,
        bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [RFC 3/3] platform/chrome: typec: Update port info from EC
Date:   Thu, 30 Jan 2020 14:00:33 -0800
Message-Id: <20200130220032.160855-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130220032.160855-1-pmalani@chromium.org>
References: <20200130220032.160855-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After registering the ports at probe, get the current port information
from EC and update the Type C connector class ports accordingly.

Co-developed-by: Jon Flatley <jflat@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 90 ++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 189c2192375c5d..a9160a5734a489 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -27,6 +27,82 @@ struct cros_typec_data {
 	struct typec_port *ports[EC_USB_PD_MAX_PORTS];
 };
 
+static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
+		int port_num, struct ec_response_usb_pd_control *resp)
+{
+	struct typec_port *port = typec->ports[port_num];
+	enum typec_orientation polarity;
+
+	if (!resp->enabled)
+		polarity = TYPEC_ORIENTATION_NONE;
+	else if (!resp->polarity)
+		polarity = TYPEC_ORIENTATION_NORMAL;
+	else
+		polarity = TYPEC_ORIENTATION_REVERSE;
+
+	typec_set_pwr_role(port, resp->role ? TYPEC_SOURCE : TYPEC_SINK);
+	typec_set_orientation(port, polarity);
+}
+
+
+static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
+		int port_num, struct ec_response_usb_pd_control_v1 *resp)
+{
+	struct typec_port *port = typec->ports[port_num];
+	enum typec_orientation polarity;
+
+	if (!(resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED))
+		polarity = TYPEC_ORIENTATION_NONE;
+	else if (!resp->polarity)
+		polarity = TYPEC_ORIENTATION_NORMAL;
+	else
+		polarity = TYPEC_ORIENTATION_REVERSE;
+	typec_set_orientation(port, polarity);
+	typec_set_data_role(port, resp->role & PD_CTRL_RESP_ROLE_DATA ?
+			TYPEC_HOST : TYPEC_DEVICE);
+	typec_set_pwr_role(port, resp->role & PD_CTRL_RESP_ROLE_POWER ?
+			TYPEC_SOURCE : TYPEC_SINK);
+	typec_set_vconn_role(port, resp->role & PD_CTRL_RESP_ROLE_VCONN ?
+			TYPEC_SOURCE : TYPEC_SINK);
+}
+
+static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
+{
+	struct ec_params_usb_pd_control req;
+	struct ec_response_usb_pd_control_v1 resp;
+	int ret;
+
+	if (port_num < 0 || port_num >= typec->num_ports) {
+		dev_err(typec->dev, "cannot get status for invalid port %d\n",
+				port_num);
+		return -EINVAL;
+	}
+
+	req.port = port_num;
+	req.role = USB_PD_CTRL_ROLE_NO_CHANGE;
+	req.mux = USB_PD_CTRL_MUX_NO_CHANGE;
+	req.swap = USB_PD_CTRL_SWAP_NONE;
+
+	ret = cros_ec_send_cmd_msg(typec->ec, typec->cmd_ver,
+			EC_CMD_USB_PD_CONTROL,
+			&req, sizeof(req), &resp, sizeof(resp));
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(typec->dev, "Enabled %d: 0x%hhx\n", port_num, resp.enabled);
+	dev_dbg(typec->dev, "Role %d: 0x%hhx\n", port_num, resp.role);
+	dev_dbg(typec->dev, "Polarity %d: 0x%hhx\n", port_num, resp.polarity);
+	dev_dbg(typec->dev, "State %d: %s\n", port_num, resp.state);
+
+	if (typec->cmd_ver == 1)
+		cros_typec_set_port_params_v1(typec, port_num, &resp);
+	else
+		cros_typec_set_port_params_v0(typec, port_num,
+			(struct ec_response_usb_pd_control *) &resp);
+
+	return 0;
+}
+
 void cros_typec_parse_port_props(struct typec_capability *cap,
 				 const struct fwnode_handle *fwnode,
 				 struct device *dev)
@@ -168,7 +244,7 @@ static int cros_typec_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct cros_typec_data *typec;
-	int ret;
+	int ret, i;
 
 	typec = devm_kzalloc(dev, sizeof(*typec), GFP_KERNEL);
 	if (!typec)
@@ -197,7 +273,19 @@ static int cros_typec_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	for (i = 0; i < typec->num_ports; i++) {
+		ret = cros_typec_port_update(typec, i);
+		if (ret < 0)
+			goto unregister_ports;
+	}
+
 	return 0;
+
+unregister_ports:
+	for (i = 0; i < typec->num_ports; i++)
+		if (typec->ports[i])
+			typec_unregister_port(typec->ports[i]);
+	return ret;
 }
 
 #ifdef CONFIG_ACPI
-- 
2.25.0.341.g760bfbb309-goog

