Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71CEB94E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 21:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfHSTg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 15:36:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41646 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfHSTgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:36:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id j16so9899351wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 12:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nsw6SAWRbaUWjCgBm0sqobaSwadARZ8HUG7Bhcdnm88=;
        b=UL5jLFgFok1dLDa6GhMNEIzLo/N0dufbp1zdhWrvf5lD3ECnQsEufb/3s5MUbT7x5n
         7QM+s5fY7kiu0tPUz/mp8Ea34vIh7imRCWuII1z9rw5ps1mpCKpO78oCY2mHdolUAzyV
         KujPeb5j1Gh0JYOwig9FHXB8+2E+2xDsLdYikNJab+o1sP200ACrIWOp5dpr5Bs3irE/
         Lf4ERM5MMi3EFcpKTLBI/vgeEJZB4jItzRiEmnL5xGj2LwqwCWfjcBqDvpDToldDMpY1
         oJ93+k7ZGQKfn8WBVtG3Sjw7xVKhaORP4HkUBSzWCR140dbF1KqQlhLkz1/rCj8l4GW0
         M82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nsw6SAWRbaUWjCgBm0sqobaSwadARZ8HUG7Bhcdnm88=;
        b=GSKlwliVzloMaaL93mWt86QxA5roR2mtvh2qMNxi9P8B7fbInfVG3GoJEsn9lByCnT
         1GUX8j83UXQXhQPQEcmVtwT3K2OOwQ7ZIVjWFGEKHQxdlMctJqHFDGrtl7ZDhe3GSjE0
         tRtrLPtD2VTaGzK54vxo++qsqTBjgYpZxD7eR+H+u0JJgEu+wlbW8Uwe5/uV6CbRFI6U
         mC/dVx00Ece+S7Msl8I7P5NlRWJkd5mxwC/CMUBCDZA+8PaSxxs5wm7Y1u8YdKjkwJ6g
         Pdxkn4nhN7RTdtBR+jCM2LSxM/5Fy0C9/dQ1Hbl2fyBmqfZi38Bxw6SClodoGEMKDLSZ
         gWWA==
X-Gm-Message-State: APjAAAXxEAsL4G+dljrQ7Z21MA66N4mbA4nKhvShd0V1fFvl/siumEwD
        wN7fmFaxCgw/sstN6wSOVnCvgKr0
X-Google-Smtp-Source: APXvYqw9sah/I5Hly5q6qBZvIL6zhC7U9zreGgixGw6nNm05lzqDHk376+BZpFF81g98MCj+gmTyTg==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr27335141wrm.161.1566243412808;
        Mon, 19 Aug 2019 12:36:52 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f47:db00:69f9:84c:2cc6:baef? (p200300EA8F47DB0069F9084C2CC6BAEF.dip0.t-ipconnect.de. [2003:ea:8f47:db00:69f9:84c:2cc6:baef])
        by smtp.googlemail.com with ESMTPSA id p13sm18970170wrw.90.2019.08.19.12.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 12:36:52 -0700 (PDT)
Subject: [PATCH v2 3/3] x86/irq: slightly improve do_IRQ
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <c81f3440-f4cc-65bc-66fd-abe9cb2ec318@gmail.com>
Message-ID: <caeaca93-5ee1-cea1-8894-3aa0d5b19241@gmail.com>
Date:   Mon, 19 Aug 2019 21:36:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c81f3440-f4cc-65bc-66fd-abe9cb2ec318@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's simpler and more intuitive to directly check for VECTOR_UNUSED.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/x86/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index f1c8f350d..857b4d7ae 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -252,7 +252,7 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
 	} else {
 		ack_APIC_irq();
 
-		if (desc != VECTOR_RETRIGGERED && desc != VECTOR_SHUTDOWN) {
+		if (desc == VECTOR_UNUSED) {
 			pr_emerg_ratelimited("%s: %d.%d No irq handler for vector\n",
 					     __func__, smp_processor_id(),
 					     vector);
-- 
2.22.1


