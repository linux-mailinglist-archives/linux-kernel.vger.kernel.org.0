Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED88B16567D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 06:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgBTFFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 00:05:04 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46663 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgBTFFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:05:03 -0500
Received: by mail-pf1-f195.google.com with SMTP id k29so1276027pfp.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 21:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dyNzXT8jLD/h3SHy8a6cXUYQMkAeXAKSKv5N+Mj3VNM=;
        b=qDZfr9MCt0H7vO2O2iGnZXpDtP5E3Qw9y7loJoWPu3Sj//W9D1V3bwpfmBtms4Xo0c
         y6yfy3huIAtnE5UxWFpK65fS4DIrSHQFpLXMYKAj6NImy/HuUzvlH38b2SN336GjLW2P
         +grV3nLOxp0DzcR0vqK1R92Ly+imwIohlL8Xpci5eFMJR0vPC9Q4YNZtns4C3XB1J/rT
         iLYeXLknGxrnrOsXDUQuWLZ6vXxoXWbxjjXuLwZgC+dT9w/QcUb+OAsmwh1RW+9SLOgc
         82NKg5tXDHCXkDfMmQbjifdqPgWa6yDzv1kwkFqvuVL6iPJ7/9X4UGYmWTylJYSBgUJG
         DTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dyNzXT8jLD/h3SHy8a6cXUYQMkAeXAKSKv5N+Mj3VNM=;
        b=Tlb9czQRMG8TM/pXhIRuIvjwUAnkANga6daZsOvLfKSZvwFpcYSBxWe5tAVi5tVTAi
         u06L6wjeiIitZM5N+n2M2vixPHSKopNn5c6L/6SdK8fEzPqwWwrhx47gXXqBN89nuB16
         8fxUmcTBs/ziLE1CX/Ktwg6kzHPfliwwxxcdS8jSQK7O0Q9RlgaeKWm+WJNQC5GN8PSM
         3zbGY7j5bbpizO+mrmyH4AMXIYnBA8V/pBGMTsTXoXlEjfsSqb37vxQhLjSwRLBR4Ckp
         g5NPUw+Fn4BfHlEk4PLpNZXTbKhAe1G+na3X8ed42DI3YrcpFQoXje9/emna/Tsv6ToX
         IFiw==
X-Gm-Message-State: APjAAAVvab90oz5YSiwV2fuN8BeO8U1Z18cO+d1QKk1WV3GmQe5/m1sp
        3E83Qy3hRDZBxlYIncuHvOsRc9k/xd0=
X-Google-Smtp-Source: APXvYqwKxpJ3up3gMovM7cilewhjBB7h6jVLv5FEJQ5jkpiNN8ZLL6nciC7CXK+kdMoSse7byXh8eg==
X-Received: by 2002:a63:ec07:: with SMTP id j7mr30998730pgh.187.1582175101605;
        Wed, 19 Feb 2020 21:05:01 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id z4sm1400847pfn.42.2020.02.19.21.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:05:01 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 2/6] driver core: Set deferred_probe_timeout to a longer default if CONFIG_MODULES is set
Date:   Thu, 20 Feb 2020 05:04:36 +0000
Message-Id: <20200220050440.45878-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220050440.45878-1-john.stultz@linaro.org>
References: <20200220050440.45878-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using modules, its common for the modules not to be loaded
until quite late by userland. With the current code,
driver_deferred_probe_check_state() will stop returning
EPROBE_DEFER after late_initcall, which can cause module
dependency resolution to fail after that.

So allow a longer window of 30 seconds (picked somewhat
arbitrarily, but influenced by the similar regulator core
timeout value) in the case where modules are enabled.

Cc: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
Change-Id: I9c5a02a54915ff53f9f14d49c601f41d7105e05e
---
v4:
* Split out into its own patch as suggested by Mark
* Made change conditional on CONFIG_MODULES
---
 drivers/base/dd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index bb383dca39c1..fa138f24e2d3 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -224,7 +224,16 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(deferred_devs);
 
+#ifdef CONFIG_MODULES
+/*
+ * In the case of modules, set the default probe timeout to
+ * 30 seconds to give userland some time to load needed modules
+ */
+static int deferred_probe_timeout = 30;
+#else
+/* In the case of !modules, no probe timeout needed */
 static int deferred_probe_timeout = -1;
+#endif
 static int __init deferred_probe_timeout_setup(char *str)
 {
 	int timeout;
-- 
2.17.1

