Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27EF531765
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2019 01:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfEaXC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 19:02:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39433 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfEaXC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 19:02:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so6830919wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 16:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2E2Yu1Q0tfoRnZK+jcFx+IKOzLmnmqLF029Lgzpcc/k=;
        b=kAPSjOHJOqE94uShWuypL9ii/931wZa3nfEZy6jHi7f5ffa88I6XCTYhi+IO4lubpd
         v6DfIVeKTBjr5AfnnnoacjBrvMFN0uS6Nmic6Y+Ls9f6KHrNbVoXv7SHUZu2lmiBXm6a
         bdgTzHuVoUOSAW5tVTZFBMohcrSgniG+us56LJ7t/cgGRQ2LlIaUEFLpFMGirkNlfro+
         SshBV1M2Qxf82C69STRYtJ30Yvou7sn9ZP3V11OHG+O8rfVIVoGCOTQWHcOPIk04rhNp
         ymMzKBCfYM22Pv60exOlifHdS1Xx8etrviMB8KrG3o3MFTCbAVGMzB2eFTRneN4ZUwez
         CmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2E2Yu1Q0tfoRnZK+jcFx+IKOzLmnmqLF029Lgzpcc/k=;
        b=DI9PCAeFgrjzHvPCSm9Ta0yws2zm6tu7lQ6fBAICXpRderVpDNRm0fXHxTPfERiDWV
         WecpHkGsgDyspqRi2VOM+g95AOcWFhXZe37Z9SFdHQog7yNhz/UqywyfLwKJyv8GXyIn
         nyOPO6OyB6O+QWQzgYTauUxttW56/id36WjaO3fsOd+nyupQjDPvCsjB0YGB+xwYlCYS
         7ncJJ8HDUujnDMt4y0WrPy55VJQjUFXSKMMqtQBw3oYZsX70Y3D1Ls3+GQtiBcGdIViW
         Guq9HImCXglVIvGAgPBuA2XtFsR7JlH+hrkBSJwFBb09buUWOgHph////Fxq0Hif3Ms9
         iH2w==
X-Gm-Message-State: APjAAAXw3ICzP6RJDejbpjyy4h3vWwG3bQlma4dkBCvjYtP7Esi+tfHm
        nsdWv38VsNru2OrAsYgvED6YMmdAyhs=
X-Google-Smtp-Source: APXvYqx6wjVK/tcFeX/rhtUgPB7srsqPsdYUURWilKTfPF/hjR0oX5M5C1cVumW9Af59AWzIevHkUw==
X-Received: by 2002:a1c:7ec8:: with SMTP id z191mr1666867wmc.66.1559343776646;
        Fri, 31 May 2019 16:02:56 -0700 (PDT)
Received: from localhost.localdomain (catv-89-135-96-219.catv.broadband.hu. [89.135.96.219])
        by smtp.gmail.com with ESMTPSA id w10sm11439526wrr.67.2019.05.31.16.02.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 16:02:55 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] regulator: arizona-micsupp: Delete unused include
Date:   Sat,  1 Jun 2019 01:02:52 +0200
Message-Id: <20190531230252.6541-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver uses no symbols from <linux/gpio.h> so just drop
this include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/arizona-micsupp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index be0d46da51a1..4876b1ceef23 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -16,7 +16,6 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
-#include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <sound/soc.h>
-- 
2.20.1

