Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A5A18306C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 13:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgCLMhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 08:37:47 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36504 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbgCLMhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 08:37:46 -0400
Received: by mail-pj1-f68.google.com with SMTP id l41so2615676pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 05:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lBchukDJKQnY90F2ozsnSb5pJXMaYQQKSo79SHXxd9U=;
        b=E65ROswtkC/Tb78s+6ECzM36s9H66H66kO6F33KXuITiG2SR66cq8Vup8MPYOGvg5X
         EpRDBrvl6DI5StlOz4yerAbR9KgsFBM0IZlEn0sscbbuwlXdHxJJ1WVWa18hJhqtVYkX
         8QybeJJOf3q5vEEIJnldlz2cn3nsFQnmUGfgryFMySyDllTjSLdSJrnJCmqnT/LhxzDD
         4VuFCQ5ycdLJ56L8iwN3O87ZVJh5GCcqxKZ/uISLlyCWoT4WFhXhGlqJAL4XisnBnXOU
         2mu1Mut1lk8yZ4NgHeOy3rM/jnVjU6oAe85eSb9euc6n8lGz7uYTqAFwI+1TxsC3/QAi
         QH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lBchukDJKQnY90F2ozsnSb5pJXMaYQQKSo79SHXxd9U=;
        b=WVS5PZz6HFbs9+ofTxRTwf8SsIYJx7sj5MgVnTzxbF5Y53zhmSqKz5O+JSXU4SeDXF
         K7OBMyWtDtmRze83x+Rt4vpkNv8xReCT3wdd3gmnIkETU0pYCUdjUY2ya4qbn+dDs/EZ
         uMpI3/uxs09PTNWX6JY42OdoSkbmxS/s95NkWzZExSApCGHgyVVdSOUh+8T8bZ864e5/
         rlTdlze7oaHYhjgPLzMqDTGZDnkfTQp1/EmvndxszUcXnnLWODhLaSTwzTv++rFV+A3q
         CpjELb+f2aBpZu1OpGEF1ygYrvrtthx8oIlxpJzHMV/W7x1PJt+dYpEBFTxz3EeYgj47
         zM7Q==
X-Gm-Message-State: ANhLgQ0vBKmG97K71K4P1G/auP9xxA9LnIRNTNKRzK6JWwlwVtxROium
        +szywEGtnYSbmxPAsxXptBPEraAhV4A=
X-Google-Smtp-Source: ADFU+vsNmBdC+IpR5ascPNluLKrF4owJRmfZx+8wDGcZts7Z9w3HDvdGDm/ij2txqmuRd4SVcFlM8w==
X-Received: by 2002:a17:90b:1a8b:: with SMTP id ng11mr3933072pjb.194.1584016663366;
        Thu, 12 Mar 2020 05:37:43 -0700 (PDT)
Received: from localhost ([45.127.45.7])
        by smtp.gmail.com with ESMTPSA id 144sm58198495pfc.45.2020.03.12.05.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 05:37:41 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 7/8] drivers: thermal: tsens: kernel-doc fixup
Date:   Thu, 12 Mar 2020 18:07:04 +0530
Message-Id: <7ea9c9ead90a91205a3f1717c0c86db9a51780ce.1584015867.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1584015867.git.amit.kucheria@linaro.org>
References: <cover.1584015867.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document ul_lock, threshold and control structure members and make
the following kernel-doc invocation happy:

$ scripts/kernel-doc -v -none drivers/thermal/qcom/*

drivers/thermal/qcom/qcom-spmi-temp-alarm.c:105: info: Scanning doc for qpnp_tm_get_temp_stage
drivers/thermal/qcom/tsens-common.c:18: info: Scanning doc for struct tsens_irq_data
drivers/thermal/qcom/tsens-common.c:130: info: Scanning doc for tsens_hw_to_mC
drivers/thermal/qcom/tsens-common.c:163: info: Scanning doc for tsens_mC_to_hw
drivers/thermal/qcom/tsens-common.c:245: info: Scanning doc for tsens_set_interrupt
drivers/thermal/qcom/tsens-common.c:268: info: Scanning doc for tsens_threshold_violated
drivers/thermal/qcom/tsens-common.c:362: info: Scanning doc for tsens_critical_irq_thread
drivers/thermal/qcom/tsens-common.c:438: info: Scanning doc for tsens_irq_thread
drivers/thermal/qcom/tsens.h:41: info: Scanning doc for struct tsens_sensor
drivers/thermal/qcom/tsens.h:59: info: Scanning doc for struct tsens_ops
drivers/thermal/qcom/tsens.h:494: info: Scanning doc for struct tsens_features
drivers/thermal/qcom/tsens.h:513: info: Scanning doc for struct tsens_plat_data
drivers/thermal/qcom/tsens.h:529: info: Scanning doc for struct tsens_context

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/thermal/qcom/tsens.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index ad7574fe0811d..f49e516b34588 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -526,6 +526,8 @@ struct tsens_plat_data {
 
 /**
  * struct tsens_context - Registers to be saved/restored across a context loss
+ * @threshold: Threshold register value
+ * @control: Control register value
  */
 struct tsens_context {
 	int	threshold;
@@ -540,6 +542,7 @@ struct tsens_context {
  * @srot_map: pointer to SROT register address space
  * @tm_offset: deal with old device trees that don't address TM and SROT
  *             address space separately
+ * @ul_lock: lock while processing upper/lower threshold interrupts
  * @crit_lock: lock while processing critical threshold interrupts
  * @rf: array of regmap_fields used to store value of the field
  * @ctx: registers to be saved and restored during suspend/resume
-- 
2.20.1

