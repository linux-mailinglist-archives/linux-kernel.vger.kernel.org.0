Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D86081570E3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 09:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgBJIf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 03:35:26 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34459 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbgBJIfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 03:35:24 -0500
Received: by mail-pg1-f195.google.com with SMTP id j4so3539449pgi.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 00:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/nZnIc67c2Uk/CN3G2tIHWPR653imWhXfxakv+5Ocgc=;
        b=daG8Oq75DnpoQAvJWB6XbRvynaKNvFo8AHdCxeD90PwK0I5LUrjCjHV+6QgJQwMl2p
         FnR8IjrCkqcwi7rHIAezum+vzXNFA4Ro5WUhsy5cFpp3iS9y+oHHmP/YbRZEMBCx9mDt
         sathdMRh8AmPFzGk4btWpRhh0bIWmXCreib5k1PGhqy5YZEo0MXdjQPshJo5jvrbtsmE
         y9VV8/8DaFw/yqmN2rNP8uuW0e/8JhGkWqQ0A1N3b7/23eJpQShP/7DSl8RNMSq1CEAC
         GjCHmO6KRPWJ4pQDgf8uIDgBgYAb8CAl13GAuH+AsOjKhP+Jkqhv4bTS8aMHetefr64c
         dvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/nZnIc67c2Uk/CN3G2tIHWPR653imWhXfxakv+5Ocgc=;
        b=lu1Rv4swipBr1VE1kitscZxV2b82ltaXiTrigVBCvVG3Zq7ZwxawTmP7oWAwPfUu5J
         s4qWegvkWJPDodtlr8JaCdnxOB8WbbTqtaZtxnd8Rd/AzBwBAFutJhGfUHz7iAGtQg+T
         HXv+hGaHzoDV6IzyF7KadFHkf9rQr4NmdSNfZTcK/4dS59OJ/dicViOvqljAYAQCa6d0
         c2ZGZp9jTBPDRBFDPHVM+NCpHIIBTQnnDyM32hxN6SxHXXhb9WthjAPkNfABxMpK4liu
         luniGshFigj8B0h0C9GHAmtX/zNMWg67JbCaRlC+8Y9wsoGOD5vN01JH7KFhVTm0wYTa
         NRYA==
X-Gm-Message-State: APjAAAVDA0P3UjsB9u5Z6TzkFmBdMnRw03p07FPmHw8XilOOc3d2sb0S
        KsrRzD7xj5Fwit3oyNis1ZF63w==
X-Google-Smtp-Source: APXvYqwySTsDZ7ffIr6LWs5uEkv6SmFd4RFmzerUCF2XeNERGDjMBzIWnzSRUEexwVgQUUojJ+9NFg==
X-Received: by 2002:a62:16d0:: with SMTP id 199mr132682pfw.96.1581323724176;
        Mon, 10 Feb 2020 00:35:24 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id q8sm10582409pje.2.2020.02.10.00.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 00:35:23 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 2/2] riscv: Use macro definition instead of magic number
Date:   Mon, 10 Feb 2020 16:35:15 +0800
Message-Id: <20200210083515.10864-3-zong.li@sifive.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210083515.10864-1-zong.li@sifive.com>
References: <20200210083515.10864-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KERN_VIRT_START defines the start virtual address of kernel space.
Use this macro instead of magic number.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/include/asm/kasan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasan.h
index eee6e6588b12..b47045cb85ce 100644
--- a/arch/riscv/include/asm/kasan.h
+++ b/arch/riscv/include/asm/kasan.h
@@ -13,7 +13,7 @@
 #define KASAN_SHADOW_SCALE_SHIFT	3
 
 #define KASAN_SHADOW_SIZE	(UL(1) << (38 - KASAN_SHADOW_SCALE_SHIFT))
-#define KASAN_SHADOW_START	0xffffffc000000000 /* 2^64 - 2^38 */
+#define KASAN_SHADOW_START	KERN_VIRT_START /* 2^64 - 2^38 */
 #define KASAN_SHADOW_END	(KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
 
 #define KASAN_SHADOW_OFFSET	(KASAN_SHADOW_END - (1ULL << \
-- 
2.25.0

