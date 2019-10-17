Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAEADAA0E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 12:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501973AbfJQKbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 06:31:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33790 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408870AbfJQKbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:31:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so933424pls.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 03:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=J2+dIH77bj5pUXUsovECtUNC+eDZQzRNadhd1RCEVqs=;
        b=QyCYbcfV/to97a+xYWNSXEdx2HU7uHt04NRbH5yfS2adyMH25lzSgFB9Ep8/KbqTs6
         Zf6HjbvRACc7tNrYuU7r6di3rZe8GmE3IA8S8ZiIxJ6KPj5o2rGokTTpZnoQ4LfuZw7x
         ZhxTDPIbjS/TIAPNiC+bZF+F+NfbMS9bvW2uIFHvA9oXuNOsRxBQBd54vrXbno3eLb2k
         gktYoUlsnie81rVAljMFA8VOZ1a1P8Y5Sc3HVHP6PBJQoGnESySHtq427OUVSZrgLW0h
         HErNTlmrHH7o1G4KT9XRcsqVDXMNtk24QM8VB0d2CfPbRwi/qrgH/OfPAQJ4MWED3tBl
         0IDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=J2+dIH77bj5pUXUsovECtUNC+eDZQzRNadhd1RCEVqs=;
        b=mZFwRHNAnQSdLLMnJV2HtjF/XjGcS0NXsYF4cJ6HjujUP0OoDAIQImbl1g4C54Jyg3
         ZqAUtQKcDhuMc1AB+zUFne6/xLXwJYkiU9KfnvSlzr1ehnFFB8MWk6WPBdvdtEcPAWxa
         3i7+20t0bsSrz/gAeo7+9pZMoYxlxRbm3+KYWSrtXB6l5nHgAg0rUA8EJGFIjBWxR5V4
         nVQBqpzxB2FO0ig7a4aq9hYzRnGp1t1YRV1MchsBGFqyLXSsfmWbjk8ZvEKf1B13Ydxg
         5cYYWirTIiCENMnbYZggxTWljMme7P+AHBthCzMY0BulnqFA5NCtwtQ41u7PxeC1fWw2
         E5hg==
X-Gm-Message-State: APjAAAXc08+nuCOq16CiSS42HLZaUHH5dWKByAmGhUmlq4/IX/MLlA2Q
        X2H3TrnnVfHe+ZdI++YO7rwjQgnfDGU0MA==
X-Google-Smtp-Source: APXvYqxjthyxtXwtCwKSStHwr0eQbZynMEuV7Z6n5rxCk1q33ZXyI9gQsBP1++XEWau5aZWeN+Fb6Q==
X-Received: by 2002:a17:902:56e:: with SMTP id 101mr3180603plf.90.1571308262888;
        Thu, 17 Oct 2019 03:31:02 -0700 (PDT)
Received: from localhost ([49.248.54.231])
        by smtp.gmail.com with ESMTPSA id w12sm3285919pfq.138.2019.10.17.03.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 03:31:02 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, tdas@codeaurora.org,
        swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 1/5] thermal: Initialize thermal subsystem earlier
Date:   Thu, 17 Oct 2019 16:00:50 +0530
Message-Id: <cc2aa18e2e6004ba099e69b41d0d505a4361443c.1571307382.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571307382.git.amit.kucheria@linaro.org>
References: <cover.1571307382.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571307382.git.amit.kucheria@linaro.org>
References: <cover.1571307382.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the thermal framework is built-in, in order to facilitate
thermal mitigation as early as possible in the boot cycle, move the
thermal framework initialization to core_initcall.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/thermal_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d21b754baee2..d8251d723459 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1537,4 +1537,5 @@ static int __init thermal_init(void)
 	mutex_destroy(&poweroff_lock);
 	return result;
 }
-fs_initcall(thermal_init);
+
+core_initcall(thermal_init);
-- 
2.17.1

