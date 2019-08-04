Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 422E9809F8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2019 10:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfHDIWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Aug 2019 04:22:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38979 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfHDIWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 04:22:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so59905955wmc.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 01:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pYN9gkYL6vVtTjfxiL3Lq98onbiyK/SbUpNkwpGBVmU=;
        b=ZVYxGgI8KUR44t7ZL2MLh6V/7CbEbUiXI5fe8LeaHlOL2YG92+q9ifnjBIj+5ssWdE
         v9MCxIND1DFPbJPGJJZSlsppM7qoCv23E2LSkrSVQjn00qJOwcbhePh7/muVZwvpkFYz
         YMMc4iJ2QimtqSLENB8aDmvjnzQBIXue0JeLjFpWRWEbjnPXLucu6Eb6wMuq0DZ2YAmA
         Z/frSZL3E9ykTfArjzwrlTaHqwUcqTrFF8IobnCPrTfId1iRmPd4E/MMLhC5LL6f1NN9
         qGgAaCKg/XHbNjZAlVrTOoq8SNuSo5y7XMtCNA6hNkiEIT9XGdsrZzr/818yiIiQHGYL
         MgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pYN9gkYL6vVtTjfxiL3Lq98onbiyK/SbUpNkwpGBVmU=;
        b=Qin4yO6lKgAvG8AJcjYLnoSEwzN2N7UTMSEiLtPcxAv+pPYE46u0qOYScXuMMzxcW1
         1cKgKcN600OonipoXfa0aAiZSeYYviwvFA3mJ/KaterzxQineI5ABL2HqC0K+dKLw0FG
         +gASwl3zPYKExm72d1jO44W3Fa/QaWgAtdhE36h7cDyFl2NsXo3D+YCphck9yFdtaoUL
         TBmz/AOoXcGB64pPvG2AM7tAY6a1hdUOcNt+m1nm6p/ytdfhqwsaO1dHwDCVPtGAtLNW
         zc3e4qXLsN1Fc8chrBcmSUIsCVz4F/GfYawbiT9oNcn7ByDY5ndzt721jr11YYYayMRv
         /DDA==
X-Gm-Message-State: APjAAAUrsEGNwDrgh1Kj0dFLu84yNAaI56WnzReStd3BNkC2ug9PkDcp
        zmEYV4O/0G5G6gsJ4YHQw6zmswBY
X-Google-Smtp-Source: APXvYqwAe4QKRBxeCL9L+PxLE5wWMuK6XfLw5rr0D9iRT3lEFR53t+YaHRQSh/lM/ZroYu2DKCWxTQ==
X-Received: by 2002:a1c:9c8a:: with SMTP id f132mr12955396wme.29.1564906963793;
        Sun, 04 Aug 2019 01:22:43 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f28:9900:d80f:58c5:990d:c59b? (p200300EA8F289900D80F58C5990DC59B.dip0.t-ipconnect.de. [2003:ea:8f28:9900:d80f:58c5:990d:c59b])
        by smtp.googlemail.com with ESMTPSA id o20sm213726672wrh.8.2019.08.04.01.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 01:22:43 -0700 (PDT)
Subject: [PATCH 1/3] x86/irq: improve definition of VECTOR_SHUTDOWN et al
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <c9b51ac3-b1d6-89a6-e323-4600af22d9de@gmail.com>
Message-ID: <239931b5-d066-6015-6726-1758dd5ecce4@gmail.com>
Date:   Sun, 4 Aug 2019 10:19:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c9b51ac3-b1d6-89a6-e323-4600af22d9de@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These values are used with IS_ERR(), so it's more intuitive to define
them like a standard PTR_ERR() of a negative errno.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/x86/include/asm/hw_irq.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index cbd97e22d..4154bc5f6 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -153,8 +153,8 @@ extern char irq_entries_start[];
 extern char spurious_entries_start[];
 
 #define VECTOR_UNUSED		NULL
-#define VECTOR_SHUTDOWN		((void *)~0UL)
-#define VECTOR_RETRIGGERED	((void *)~1UL)
+#define VECTOR_SHUTDOWN		((void *)-1L)
+#define VECTOR_RETRIGGERED	((void *)-2L)
 
 typedef struct irq_desc* vector_irq_t[NR_VECTORS];
 DECLARE_PER_CPU(vector_irq_t, vector_irq);
-- 
2.22.0


