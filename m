Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6162396A67
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 22:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbfHTUZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 16:25:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43658 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730945AbfHTUYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:24:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id v12so4048134pfn.10;
        Tue, 20 Aug 2019 13:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=na3FREkudwb1VMnaG2ccAswT2v+ZuC8y+xiG8YtQBYY=;
        b=XI1KpQiWyMhjzJhwmR2SesNXeBqep8k/k21tUnzOhcZPe9IcuO8kdlU7hy1BcUciP3
         ZmQs7uuIEG0Bdkffz3BdoaSu3HbfJ6kHdqQxaTVDvJW+o5yUAiMhLa1bg5zkjZo2nKgk
         XmrTn6ir5F54zPPx1N6Srg7MqwrhMVXpbUX2QxBMlBjO6ActJN9rbe0Ula3Z9y9drcRq
         C/Au/8bPnUfM+obwYIAPe4zO/XRl22kGXyK/ywv5rNzLNChkduQLHZP9UxnGJ4RX3sbR
         pi7UON3N3m3Ee74p06s0OyIFNWwCCedKagdIT7RTaLU7qo6HMJKeNvnFTagzdlGF2Zku
         ZBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=na3FREkudwb1VMnaG2ccAswT2v+ZuC8y+xiG8YtQBYY=;
        b=eeP6jTOpl60sWlYCCQO4+rbblFeiAM+qCUwZ7HM3eX/6Y7U1DY0ZFWv29FoeDlVM/W
         HIPnyJrlpYs6rQMFc3+MVKsJi4NfbBbDV43KkB+Ypsb/Ao3cMrekGlwZo+Y31JcOA1cO
         4g2heoeKM1S8RrPQFqYEC1M+bDsy+wKEyNcraWMWThkGjCtZJajPHW9yJsc7ClaHw96o
         GR22LDl39y9Cx9ce25q7qxAMKU7oHKiOQiqcbm/PQjsvtSe2X15ZpO7I6gwXWgm2ydy2
         e8MqRjnwUAazVxQisZ+QUNbOTRF5B07g0Ou5CIvtDPmQv1r6+m7fhKqV+JqNNNrF1zxy
         1MCA==
X-Gm-Message-State: APjAAAW6ga9usSq6XqHwRqr4aY3lllYA6mL2JosQQcAd578uFmBYSf9O
        6vGxeGqmGlSTPWgi6ZhvdVlODoHIx20=
X-Google-Smtp-Source: APXvYqysI6E4QjSBf/ra2ac4/AmSwuKpxmhaiwV0qFwbUIPeEUqIalO8kRh/NeMF7HAUoxO5LCjFTA==
X-Received: by 2002:a17:90a:5207:: with SMTP id v7mr1640091pjh.127.1566332672285;
        Tue, 20 Aug 2019 13:24:32 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id k3sm36149846pfg.23.2019.08.20.13.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 13:24:31 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Spencer <christopher.spencer@sea.co.uk>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 10/16] crypto: caam - move cpu_to_caam_dma() selection to runtime
Date:   Tue, 20 Aug 2019 13:23:56 -0700
Message-Id: <20190820202402.24951-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820202402.24951-1-andrew.smirnov@gmail.com>
References: <20190820202402.24951-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of selecting the implementation of
cpu_to_caam_dma()/caam_dma_to_cpu() at build time using the
preprocessor, convert the code to do that at run-time using IS_ENABLED
macro. This is needed to add support for i.MX8MQ. No functional change
intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Spencer <christopher.spencer@sea.co.uk>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Horia Geantă <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/caam/regs.h | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index 489d6c1eec7d..0df4cf32fe78 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -188,13 +188,21 @@ static inline u64 caam_dma64_to_cpu(u64 value)
 	return caam64_to_cpu(value);
 }
 
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-#define cpu_to_caam_dma(value) cpu_to_caam_dma64(value)
-#define caam_dma_to_cpu(value) caam_dma64_to_cpu(value)
-#else
-#define cpu_to_caam_dma(value) cpu_to_caam32(value)
-#define caam_dma_to_cpu(value) caam32_to_cpu(value)
-#endif /* CONFIG_ARCH_DMA_ADDR_T_64BIT */
+static inline u64 cpu_to_caam_dma(u64 value)
+{
+	if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
+		return cpu_to_caam_dma64(value);
+	else
+		return cpu_to_caam32(value);
+}
+
+static inline u64 caam_dma_to_cpu(u64 value)
+{
+	if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
+		return caam_dma64_to_cpu(value);
+	else
+		return caam32_to_cpu(value);
+}
 
 /*
  * jr_outentry
-- 
2.21.0

