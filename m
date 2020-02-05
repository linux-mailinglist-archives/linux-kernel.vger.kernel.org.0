Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5B511538CB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 20:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgBETLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 14:11:52 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37965 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgBETLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:11:51 -0500
Received: by mail-pj1-f67.google.com with SMTP id j17so1408523pjz.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 11:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y/dxpKcYEXxmnsITAJ6pnZifEuXekQdEG50zLc7fDeo=;
        b=CxEmMnwR6rjD71F46jEADMXkj7EssJmMqd+P3L3f6w6ESIFbj1Hw7dJPhu400glIU7
         9HNGruSKqCRaiHvJNyIp5ineGRVLgeIkRrfxwSw0Ry2Ne74Iu/U8pYeooGac19uXIZ4g
         Bgrk8bznNFJ+13cj9tnhhFsYs0hNLKSvUA6Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y/dxpKcYEXxmnsITAJ6pnZifEuXekQdEG50zLc7fDeo=;
        b=buGLYv1Go1oBhIvEEBTZk7mVsikgyFdFomUUt73tH3jFcuqi3niRceQZml9qebtzas
         SDBqcJtzFf/+lzMjA1rJEESdKuKZp3mfsG7pIfeWiAhfgYWi7wI+vTmP142mwbXxdjzy
         q3kg1/HVMTfVEeMFlUEUWJIn7keeVEf6jAq+8r3dTyx3ZxeWqiEiUAvsdKxII8yj2prO
         oTfeFXKwqNhW1Wy/0vGQ2ZjuddObaAl5xAhEm0liISoUT13z8tkgwXpcb0Dd/YBysj9U
         xh/uohjjvCSlgV4zQuIRwWoqBQkq6aaS1/e2tkf8ClmcIdLANGiUw7UcpL6Nm0lbqqKA
         8zAw==
X-Gm-Message-State: APjAAAVPoFDIkJOUGyAJ/p9mCkaEVdhS0n5Vjq7UpYYOKNDAc2EB0NeM
        6FTMYACp/NE/erPRRspS0nzOzgejAMQ=
X-Google-Smtp-Source: APXvYqxHu1ZnioRv8yjOxEtywN6zzgA9Bc4iTDVAOFO5SWiSh8udQjlCLSp9knX7DA4TIgWFrn+mhQ==
X-Received: by 2002:a17:902:82c3:: with SMTP id u3mr34711027plz.73.1580929910558;
        Wed, 05 Feb 2020 11:11:50 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id u23sm257224pfm.29.2020.02.05.11.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 11:11:50 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org (open list:HID CORE LAYER)
Subject: [PATCH v2 09/17] hid: google-hammer: Use cros_ec_cmd()
Date:   Wed,  5 Feb 2020 11:00:11 -0800
Message-Id: <20200205190028.183069-10-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200205190028.183069-1-pmalani@chromium.org>
References: <20200205190028.183069-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace cros_ec_cmd_xfer_status() with cros_ec_cmd() which does the
message buffer setup and cleanup.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Updated to use new function name and parameter list.

 drivers/hid/hid-google-hammer.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 2aa4ed157aec87..fb0d2a01e2736e 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -53,38 +53,25 @@ static bool cbas_parse_base_state(const void *data)
 static int cbas_ec_query_base(struct cros_ec_device *ec_dev, bool get_state,
 				  bool *state)
 {
-	struct ec_params_mkbp_info *params;
-	struct cros_ec_command *msg;
+	struct ec_params_mkbp_info params = {0};
 	int ret;
 
-	msg = kzalloc(sizeof(*msg) + max(sizeof(u32), sizeof(*params)),
-		      GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	msg->command = EC_CMD_MKBP_INFO;
-	msg->version = 1;
-	msg->outsize = sizeof(*params);
-	msg->insize = sizeof(u32);
-	params = (struct ec_params_mkbp_info *)msg->data;
-	params->info_type = get_state ?
+	params.info_type = get_state ?
 		EC_MKBP_INFO_CURRENT : EC_MKBP_INFO_SUPPORTED;
-	params->event_type = EC_MKBP_EVENT_SWITCH;
+	params.event_type = EC_MKBP_EVENT_SWITCH;
 
-	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
+	ret = cros_ec_cmd(ec_dev, 1, EC_CMD_MKBP_INFO, &params, sizeof(params),
+			  state, sizeof(u32), NULL);
 	if (ret >= 0) {
 		if (ret != sizeof(u32)) {
 			dev_warn(ec_dev->dev, "wrong result size: %d != %zu\n",
 				 ret, sizeof(u32));
 			ret = -EPROTO;
 		} else {
-			*state = cbas_parse_base_state(msg->data);
 			ret = 0;
 		}
 	}
 
-	kfree(msg);
-
 	return ret;
 }
 
-- 
2.25.0.341.g760bfbb309-goog

