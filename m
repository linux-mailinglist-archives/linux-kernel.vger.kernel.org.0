Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F37AD4A9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 10:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfIIITW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 04:19:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40854 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfIIITW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:19:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id t9so13492784wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 01:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IQx2hKMgmP9XOyhFpC2qn9Y+bupvqz+vNmxTVrE/dzQ=;
        b=owt9bXuU0Nf8BzM8qdIXU1q6gtY/bFx66KTZIb7Kjpj+IGXKChmf6uhXmbxQmtp/ty
         2OCv5Z4Yr4coK6NJbodfGPo4mz3jFJRCGX1pagnop3I+er8B5jY7UVlN9SiEO7KZjes6
         +5KaVSzTlmVE5tgHOSaUKp5W10aoq7lOHBRROnVpcw8SK6eDqzmgmXc/NzUVtlAUOJCR
         p66oOvuyXXWPpcOg5p5e1HL2+WGul7CIPNru5rWe6G9M+2ovTEEWJ5PlX3ukEi0VBhPl
         x4NjoETERFW7kvmV7XLAnqaOjycMuKEPsth+UZDQmPQWOyV6XMwohCckA+R3GAMZTm4J
         xqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IQx2hKMgmP9XOyhFpC2qn9Y+bupvqz+vNmxTVrE/dzQ=;
        b=tdEaU6gwdq0nXtRFz50o3EpPIec2McOIR+TjSsMjVW7PkH9HYuezQPc0IQGx1hI2gS
         U6Fo/SDJOfCqSdTM34+Rd9cGgIuzhLAiSzVpxMXvXCWnWdBKSoBE4VGRmcHVBPZ4zKiK
         QJCk6xdA9izY+gyqR1WXmFP+7qAQF84le4inZtDWZUTdnOFjScG3kByxMjR5WlXxET2G
         J+5wK9j8198Kq5yeNamV2+JTtn+alIi0r1PdKiNVKi3YGZ1Xy1RUPwdmwb87J9uF535f
         1WcKMX9PPg4v4Q8zptKHBu2U1DG+70SYJ2iDns5JYbAGXIVi8hYVop2susXAsS/C8urj
         UubA==
X-Gm-Message-State: APjAAAWOnGs0MQkVuFUFswq9UuL7fn16t0eJtgxVTqfgUkjxQm7rAeEQ
        6niVSRvWUBtFRGPfg66x6jD8Kg==
X-Google-Smtp-Source: APXvYqwps9lwJpFgo8szWgk2epskX4IHhTOjCIcIPUyAfdOHZ8J+CVjeDJAX6FtA5uz7TGHAgIQzlg==
X-Received: by 2002:a7b:cb0e:: with SMTP id u14mr16732930wmj.2.1568017160359;
        Mon, 09 Sep 2019 01:19:20 -0700 (PDT)
Received: from localhost.localdomain (69.red-83-35-113.dynamicip.rima-tde.net. [83.35.113.69])
        by smtp.gmail.com with ESMTPSA id i9sm17332675wrb.18.2019.09.09.01.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Sep 2019 01:19:19 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, agross@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, vkamble@qti.qualcomm.com
Subject: [PATCH] mailbox: qcom-apcs: fix max_register value
Date:   Mon,  9 Sep 2019 10:19:16 +0200
Message-Id: <20190909081916.4379-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mailbox length is 0x1000 hence the max_register value is 0xFFC.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 705e17a5479c..e5d6b1b70441 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -28,7 +28,7 @@ static const struct regmap_config apcs_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.max_register = 0x1000,
+	.max_register = 0xFFC,
 	.fast_io = true,
 };
 
-- 
2.23.0

