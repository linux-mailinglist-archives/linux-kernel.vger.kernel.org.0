Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE43194BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 23:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgCZWpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 18:45:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40169 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbgCZWpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:45:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id c20so975172pfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 15:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z3g/2X3xqKE2E6bsoNbDYiNdI89O/pvEeLJlm/o2OpE=;
        b=Xrz876FMDozNGuIjV9RUCVbds29I/2Zmat9NHRrib4AsLtTtobMA/SSi7hjLncf2yA
         lqmiEa+GyH/VnRNlyHRoY6r/ULU9/llEgod1gbjGx7uDvyD7RMdeq+8czV/BMgZPuJcE
         oNQ0ye+dyQceMh07rv+amQjd810I+l0IR6ncwGE8ffkO0ZRSA/2EULHQOppY53VSu3kM
         FlkLV6LETgkJt8BiO23uay777rqryr5JLwfYLKGBbEwMzwRAYpoTinIzgoYxUqSHnvfR
         PJ1cfEsNaVBuKQ2uBTGdjF2QAP0HbfzB+TgJCQp4WT+WZiQjjbXamMlRP2PfzisA2pwu
         TH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z3g/2X3xqKE2E6bsoNbDYiNdI89O/pvEeLJlm/o2OpE=;
        b=Yr2z2Ey283RBsv044GwdaFj33CC/KVW6LN1hQfP2MrkW+6F4/VX0UY+bDvTmveMywu
         47dMEpOatOGADXrCo7HPLVfap4TGqA83DM8vjOEfdGeuJX0avP3B6QHKPR1avc+MoYBF
         qUYklx7MjZ+wqabR3fMWKx3irmb7mCBkyx0G3UXZiclxEz3ToxHhICtvmKy1/g6zam6e
         Dr172VMKRShcjCGHkXzItrWMezH+jn0eKdbbYsdTNl1GPfDMfpkRDpCKyR5UtKyrwb1A
         PAvHFHA9RBd/eS+uCxr1xwZjSq0puj3+g3INLuw5ab1kBV9TamtsDZm7RPUonvB73ypX
         cTTQ==
X-Gm-Message-State: ANhLgQ2ZYbmoOfpnljzI0J7SvtCVe2F/UVOIKm3OaXuVSErLJlMHbIPE
        eU5A9Cd16wr6kDaxTjSeZpYeNQ4WI5E=
X-Google-Smtp-Source: ADFU+vtoCJXf8vwmtr6xsj2U3JR2F9hMCFfeXD53husYpJJuJFDNBaKMd5A71q5bsoMe9Y++eXFZAA==
X-Received: by 2002:a62:3086:: with SMTP id w128mr11394896pfw.63.1585262704003;
        Thu, 26 Mar 2020 15:45:04 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id g10sm2592788pfk.90.2020.03.26.15.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 15:45:03 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 1/3] soc: qcom: rpmpd: Allow RPMPD driver to be loaded as a module
Date:   Thu, 26 Mar 2020 22:44:57 +0000
Message-Id: <20200326224459.105170-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326224459.105170-1-john.stultz@linaro.org>
References: <20200326224459.105170-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allow the rpmpd driver to be loaded as a permenent
module. Meaning it can be loaded from a module, but then cannot
be unloaded.

Ideally, it would include a remove hook and related logic, but
apparently the genpd code isn't able to track usage and cleaning
things up? (See: https://lkml.org/lkml/2019/1/24/38)

So making it a permenent module at least improves things slightly
over requiring it to be a built in driver.

Feedback would be appreciated!

Cc: Todd Kjos <tkjos@google.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org
Acked-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2:
* Fix MODULE_LICENSE to be GPL v2 as suggested by Bjorn
* Leave initcall as core_initcall, since that switches to module_initcall
  only when built as a module, also suggested by Bjorn
* Add module tags taken from Rajendra's earlier patch
---
 drivers/soc/qcom/Kconfig | 4 ++--
 drivers/soc/qcom/rpmpd.c | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index d0a73e76d563..af774555b9d2 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -123,8 +123,8 @@ config QCOM_RPMHPD
 	  for the voltage rail.
 
 config QCOM_RPMPD
-	bool "Qualcomm RPM Power domain driver"
-	depends on QCOM_SMD_RPM=y
+	tristate "Qualcomm RPM Power domain driver"
+	depends on QCOM_SMD_RPM
 	help
 	  QCOM RPM Power domain driver to support power-domains with
 	  performance states. The driver communicates a performance state
diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 2b1834c5609a..22fe94c03e79 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -5,6 +5,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/mutex.h>
+#include <linux/module.h>
 #include <linux/pm_domain.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -226,6 +227,7 @@ static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,qcs404-rpmpd", .data = &qcs404_desc },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, rpmpd_match_table);
 
 static int rpmpd_send_enable(struct rpmpd *pd, bool enable)
 {
@@ -422,3 +424,7 @@ static int __init rpmpd_init(void)
 	return platform_driver_register(&rpmpd_driver);
 }
 core_initcall(rpmpd_init);
+
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. RPM Power Domain Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:qcom-rpmpd");
-- 
2.17.1

