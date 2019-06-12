Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDE041B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 06:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfFLEem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 00:34:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38796 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbfFLEel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 00:34:41 -0400
Received: by mail-pl1-f194.google.com with SMTP id f97so6074401plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 21:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FXV5Ws8+r5RPo/nKXnoHiLtGYbtFqiKOKRPXyhCi7kk=;
        b=WF6XEcrjnYm/TJx+cI4M997rrpyH1cFTH/f3AQedIs7pSSTy79gf+vaznSHQIU0Ezg
         ayYK7Azudp1Y8gy7eeukeYwME2A85H/PSOe3OM5sjWoSvbRQ/iRC3xvytM4I2hRtcL0H
         2zFtgHFPl3zJ4Q+z9IKlwaWjBy24AtA4JKSR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FXV5Ws8+r5RPo/nKXnoHiLtGYbtFqiKOKRPXyhCi7kk=;
        b=BPxr+ncclYVVcsSLxGHXVLunQiPwgUliyvV8WBu1c4J5ACA8Hxt9fjVHqwYI8ghqsa
         j9Td2z0eUygvzPOhmoberRNFrF43fB0+Yw1Wff+Txu/x2hkLDd4qj2uZXY1dPDG+RTm/
         xm20nAvu3YTYDDT7ROw8zzV5NhR/7vMtde1y5/zlTcGa2G+/d/08Gx4Zu3ad11/FIUk5
         BlhrnDjjNMaA/1DgWlWGc5a6tBCybMIEcd8sy1RdhlSCLNpSpZt3b1bdLGXe33ffuSOe
         TJCbq8M3GyoMKtID9G1xyiJQn0ux9MVyFHE1/Td2NcRXzZhe7fb7SIlo2tb1HL8NJIGL
         L0+w==
X-Gm-Message-State: APjAAAU6rx/q9E17GFo2jt6XepQYpbpIGTnpD/MwvfkayrEMxsVScuJP
        mcmozfcvcJYm+JP3c4qeC5uQSQ==
X-Google-Smtp-Source: APXvYqz0+oRQaQKhKlFNFx2+LDkTLS6Wb5yc/KHLfWZ3BuaHUGMHH37CG2EOx1uhfwpyGdes4XBmEw==
X-Received: by 2002:a17:902:b705:: with SMTP id d5mr44143880pls.274.1560314080888;
        Tue, 11 Jun 2019 21:34:40 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id k8sm15285998pfi.168.2019.06.11.21.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jun 2019 21:34:40 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v6 2/3] fdt: add support for rng-seed
Date:   Wed, 12 Jun 2019 12:33:00 +0800
Message-Id: <20190612043258.166048-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190612043258.166048-1-hsinyi@chromium.org>
References: <20190612043258.166048-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing a chosen node, rng-seed, which is an entropy that can be
passed to kernel called very early to increase initial device
randomness. Bootloader should provide this entropy and the value is
read from /chosen/rng-seed in DT.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
change log v5->v6:
* remove Documentation change
---
 drivers/of/fdt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 3d36b5afd9bd..369130dbd42c 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -24,6 +24,7 @@
 #include <linux/debugfs.h>
 #include <linux/serial_core.h>
 #include <linux/sysfs.h>
+#include <linux/random.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -1052,6 +1053,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 {
 	int l;
 	const char *p;
+	const void *rng_seed;
 
 	pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
 
@@ -1086,6 +1088,14 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 
 	pr_debug("Command line is: %s\n", (char*)data);
 
+	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
+	if (rng_seed && l > 0) {
+		add_device_randomness(rng_seed, l);
+
+		/* try to clear seed so it won't be found. */
+		fdt_nop_property(initial_boot_params, node, "rng-seed");
+	}
+
 	/* break now */
 	return 1;
 }
-- 
2.20.1

