Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B18FA1834E9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 16:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgCLPZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 11:25:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53765 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgCLPZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:25:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id 25so6553355wmk.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BCXwKoNaur3Z7HhEz1+fhPzJkIu3o3cwCKBWJ9WCkVM=;
        b=dlVyyQi0X2nerasPl3ebP9TgrX2DggId0M2LsByFxdz1RgV01eT55FHKgQO8jgHq/g
         OaIhW3MUYXrN2vfaYh3VkSkMuE6R7WlN33x0aOky1U3ThBajYkXeEAGibkmcdB15If16
         mVJAxIHT2YvIU+NtCVU27kqFUNQivVnYU/Qx5CE5P2ilAqEbJU0l8zbL3NrtDNC8TuAZ
         sA7z2/T3mUjesPjPUZe3Dn4KJDSiiJJZMgI2/Lqp8tP2QJ9hiFVoLRjM3hdMLgwNUaHX
         4+lK5ETblj2hG5lWEFJZnyYnvHhH0c3cpBnev1u91kGIrd7lt2FFCjbj4AurIJwvYGzX
         39cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BCXwKoNaur3Z7HhEz1+fhPzJkIu3o3cwCKBWJ9WCkVM=;
        b=nWVLcNuBI7aY5rdZyCulZ3qVCUAu0iVhsP4yK2Q3TstEfk48wR/VfmM/aTFZVHZYiJ
         5aSoiEKE+HYSPJ4MT7ghhRwxZRgDxPmfagPkagVdafPWTEazsw1PFX4Vo0pojyje1pKJ
         t84XR6LTeIW024xyGtn9guiFxlTF1owQKkxRPBcgNZu6cx2othJPSETq8+HYtDweMHGj
         DeALdapQqR1oHUGmUumtdRK4ONePbuZ6NV1a83GKIGWbhQflelUue2AdR3WpLVcyLDiu
         IcB0vKrlwmZrnCa2hTlJ6SjDIuDGPny/lSovEvac5HQS/5TO/CBAop5YqhUfiH3jqOsN
         elfg==
X-Gm-Message-State: ANhLgQ2GV4Oo34Q8YC504rWFxjBRt5dCMK4ZwJIxZ9nu3S7EUBQwB/Hh
        nM86SWtBA0VQi0/jzYpFwMjLcw==
X-Google-Smtp-Source: ADFU+vv7oFTcZL3YTwAUyWjoFvbzNo0r6NYJ8lJsaTREmoeb4WJBNJ3QNThU2mxDafY42dPC2zmiNw==
X-Received: by 2002:a7b:c082:: with SMTP id r2mr5658626wmh.177.1584026716850;
        Thu, 12 Mar 2020 08:25:16 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id s13sm24154446wrw.29.2020.03.12.08.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 08:25:16 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] slimbus: ngd: add v2.1.0 compatible
Date:   Thu, 12 Mar 2020 15:25:10 +0000
Message-Id: <20200312152510.12224-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds compatible for SlimBus Controller on SDM845.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Hi Greg, 
Could you please pick this one slimbus patch for 5.7.

Thanks,
srini

 drivers/slimbus/qcom-ngd-ctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index e3f5ebc0c05e..fc2575fef51b 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1320,6 +1320,9 @@ static const struct of_device_id qcom_slim_ngd_dt_match[] = {
 	{
 		.compatible = "qcom,slim-ngd-v1.5.0",
 		.data = &ngd_v1_5_offset_info,
+	},{
+		.compatible = "qcom,slim-ngd-v2.1.0",
+		.data = &ngd_v1_5_offset_info,
 	},
 	{}
 };
-- 
2.21.0

