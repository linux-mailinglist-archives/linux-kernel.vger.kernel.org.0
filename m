Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB19EC2EF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 13:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbfKAMnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 08:43:06 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33615 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730835AbfKAMnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:43:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id y127so7144635lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OvUZNskoObmKKJYsbx/wH8iXu8sDYM+jDByiAdju3Rg=;
        b=H/DAgeFpcXJo0tjQoKHDP9cxo5/LdWTfUYmStbr2surKVlSluXRlwhQhQqZBDV3k8Q
         V8XC7DhjRHkNy4MfzEF3RCs5zjs3EyE2i5o/5CqiOOUhAXU+FENj52DK5J/CDQ4y4ykB
         JZklD1t78EAgDyVROxcq9bHmO3TgMHqlhpfuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OvUZNskoObmKKJYsbx/wH8iXu8sDYM+jDByiAdju3Rg=;
        b=GI5jWWsvcJRMamoZfwGghaS3b3nL+ioUyl4I/TjckkNYLIV2XMwOkefKkiVB690ofM
         eIrJStAubAu+tTuBoHU6RWitVA4pd6PAXyhloLHAtWASdCIRRlSBYWZTYvR1U4Advm58
         OZW7EY+g8JRrwPEp3ZWhfkwnrthW8UhyXKxLh3YY/BO3jBiI6cMX8O5I5TQCXFmSUt6n
         tCwl319fTW8oAZDFqusUPk/NipWju+eQ0XUAuwchge7YBBQu3hneDknBueSEOxnyrORN
         BMoUNzw39xBRH8FWZpuDEBdbU0QBQ9NK/P6w3enQgjq5a9Lj839KfuqYwEBpRMcSYO1V
         KEuw==
X-Gm-Message-State: APjAAAVoc8946jvzAg1+jpYkj0sxPVSskNPyzfzm4nuJo1zR7VChL7mQ
        hqqW1pSRUGmoVFylRwt74r05mw==
X-Google-Smtp-Source: APXvYqwI3iIuteE6/4JNe1O8E/8fB4CE3gTkq92/iVMjvlls7ufSCpNe/zR7/3vjwyl2n4K9sKAH+A==
X-Received: by 2002:a05:6512:146:: with SMTP id m6mr6989528lfo.98.1572612178764;
        Fri, 01 Nov 2019 05:42:58 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:58 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 36/36] soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE
Date:   Fri,  1 Nov 2019 13:42:10 +0100
Message-Id: <20191101124210.14510-37-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101124210.14510-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core QE code now also builds for ARM, so replace the FSL_SOC &&
PPC32 dependencies by the more lax requirements OF && HAS_IOMEM.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
index cfa4b2939992..0c5b8b8e46b6 100644
--- a/drivers/soc/fsl/qe/Kconfig
+++ b/drivers/soc/fsl/qe/Kconfig
@@ -5,7 +5,7 @@
 
 config QUICC_ENGINE
 	bool "QUICC Engine (QE) framework support"
-	depends on FSL_SOC && PPC32
+	depends on OF && HAS_IOMEM
 	select GENERIC_ALLOCATOR
 	select CRC32
 	help
-- 
2.23.0

