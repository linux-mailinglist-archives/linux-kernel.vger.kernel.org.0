Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01E2862829
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 20:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbfGHSQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 14:16:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43194 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfGHSQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 14:16:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so7978806pfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 11:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IV4TNtqFc/lYDTmD9DAr9+FRZAhoCH/s+0uqsnN6Now=;
        b=hKC4lvEcZYUg2cWEN+tgcenyS5TzpHs5xwAsiJlMDN7Xgaf2MvQNp3v333Vjdg3eKG
         YEQrhefll4UJZLvdmvWqMFNkmK0c5G0PP9bD8qmRqvoBkeYEBn0Iu69vGKTULjum99Qi
         w1ie1kQ1Pzd2FaEjBPMMbWML/W+r/8MaMoS1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IV4TNtqFc/lYDTmD9DAr9+FRZAhoCH/s+0uqsnN6Now=;
        b=Ogn3fB4uXkJWfWwhMiK+ZJQA8K48v5sWrrA1k5vZi0OXrxtWuZjyXfec7rJ5V9NE6R
         xydEes3211kexxP22Ag7xjDrPUx1z7QVXzZ2CopADb47bF40e5zQbtl/ey4+83rdUS+I
         vn5ShvvJ+VDIXBMSLMqDec3L2o2evcReKiS8/mk6mlIwQfP6/40asw1Yfc05SfP5qFMJ
         yQrSLonpcyGj4OgGrfW6mZYCmdtyUGOpLkNb9Nt24RjdEIdIKGUr+uzxplOuxfvR0hRB
         zsoGYg7jRMIofcNqg07Z9cLdSpPs0niGyVvVo5g9dgquPXceodtMYd3lxjHSDZN64+Dq
         3/tQ==
X-Gm-Message-State: APjAAAUBMOnKPnX3dTrfFReLlpOP6iKEb9UvBMSFF0mVEUcqyLq3Y4x2
        Uo2DEABjIUeoJUaIyriqfENDizglpVo=
X-Google-Smtp-Source: APXvYqz9rx8/siM0lxkeXMVMO5wOhFGIxpR4MSav7D4epZbi2z8x/5nc10a4xvp+baLb5Wvjnfv4Uw==
X-Received: by 2002:a63:3046:: with SMTP id w67mr26066695pgw.37.1562609764186;
        Mon, 08 Jul 2019 11:16:04 -0700 (PDT)
Received: from yichengli2.mtv.corp.google.com ([2620:15c:202:201:c519:3df6:ffc3:b620])
        by smtp.gmail.com with ESMTPSA id h6sm20355467pfb.20.2019.07.08.11.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Jul 2019 11:16:03 -0700 (PDT)
From:   Yicheng Li <yichengli@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>, lee.jones@linaro.org
Cc:     enric.balletbo@collabora.com, gwendal@chromium.org,
        bleung@chromium.org, Yicheng Li <yichengli@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] mfd: cros_ec: Update cros_ec_commands.h
Date:   Mon,  8 Jul 2019 11:15:37 -0700
Message-Id: <20190708181536.2125-1-yichengli@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update cros_ec_commands.h to match the fingerprint MCU section in
the current ec_commands.h

Signed-off-by: Yicheng Li <yichengli@chromium.org>
---

 include/linux/mfd/cros_ec_commands.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 7ccb8757b79d..98415686cbfa 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -5513,6 +5513,18 @@ struct ec_params_fp_seed {
 	uint8_t seed[FP_CONTEXT_TPM_BYTES];
 } __ec_align4;
 
+#define EC_CMD_FP_ENC_STATUS 0x0409
+
+/* FP TPM seed has been set or not */
+#define FP_ENC_STATUS_SEED_SET BIT(0)
+
+struct ec_response_fp_encryption_status {
+	/* Used bits in encryption engine status */
+	uint32_t valid_flags;
+	/* Encryption engine status */
+	uint32_t status;
+} __ec_align4;
+
 /*****************************************************************************/
 /* Touchpad MCU commands: range 0x0500-0x05FF */
 
-- 
2.20.1

