Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB0E39568
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 21:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbfFGTSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 15:18:11 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42047 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbfFGTSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 15:18:11 -0400
Received: by mail-qt1-f193.google.com with SMTP id s15so3553948qtk.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 12:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dBja0SaABhJ+vkH9oPP7a19xf2P1INI9IB5AOePiwvA=;
        b=HGyoiJk46WZXALckZqXAv4TDiqPCegoidYZZjWY7PoqQNvjs9DPkpooeU4PvBTNaOi
         PazRcvhLTQMU/UnjtO6jXv8SlzxazE+VJkcJ4Q5xItcQihAuw0SP3qnyz5a0wiiHiSue
         qXlsA72lxUpE2qtlBg4nakCyxoFedqJA8BnAJXNqWsU/WRiAVNg/1RvHe7/OPP9pFe/5
         7qU1PnoLmALXiQFoguW3R51sdTFFD1ps9euwnhwMujleUNf4YSOcijqw62yMcSFJitgR
         jCTmb2A/q4dZAgp0XV1Dxafj5THK9WvZ72TXfqHVAnx1AZJa0HfbDpZr9RkG36Pvq4dK
         Ycdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dBja0SaABhJ+vkH9oPP7a19xf2P1INI9IB5AOePiwvA=;
        b=qxt23nRuoNFZTeh5BlPPRMnIQcHVyPT5SXeCoSF9r9kCOGALmOZjitl97ia7eeu4ic
         k/1wyDKk7nxEvzx7AgC+ymbqV4JR6DYc9QqKc8tzIhHbaoYWORS7/y8/oRzbWk2WjXUf
         AjUkzs6QyckMe529sTNovGo/jFSksCHJDSNRqqyqmxvoy+yaVHpTs9heCWy22PhlwUfk
         t+u3tl6pvFP1iL7JYWvL/pbuik90dot+6vL7ltVRHX6Yjx6D4bQwpjsBVdH78Sq89m1A
         1/8Wq/oTXoZ4kQcTtWtliFTRPUX0QsQEUGxtIkPM95X47I0WyR6IRtEK+bgSta26vxts
         RS1A==
X-Gm-Message-State: APjAAAVxwR+re1WlV1WcnuflABgq5NzDjx2TuLLFFiHdzikOxw5Co/po
        Sr4ItUhqrEdg4qRJmMafOCe4OkDBX8o=
X-Google-Smtp-Source: APXvYqxcKoB0QsUOsyool9cAmaWLxyFtfiCIl+a5IdSf0kYmEwuYWP82X6YRRmeVT8wz3gTTAO00GA==
X-Received: by 2002:a0c:96b9:: with SMTP id a54mr26876867qvd.135.1559935090299;
        Fri, 07 Jun 2019 12:18:10 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h128sm1638507qkc.27.2019.06.07.12.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 12:18:09 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     ard.biesheuvel@linaro.org, dvhart@infradead.org,
        andy@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [RESEND PATCH] x86/efi: fix a -Wtype-limits compilation warning
Date:   Fri,  7 Jun 2019 15:17:47 -0400
Message-Id: <1559935067-4076-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling a kernel with W=1 generates this warning,

arch/x86/platform/efi/quirks.c:731:16: warning: comparison of unsigned
expression >= 0 is always true [-Wtype-limits]

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/platform/efi/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 632b83885867..3b9fd679cea9 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -728,7 +728,7 @@ void efi_recover_from_page_fault(unsigned long phys_addr)
 	 * Address range 0x0000 - 0x0fff is always mapped in the efi_pgd, so
 	 * page faulting on these addresses isn't expected.
 	 */
-	if (phys_addr >= 0x0000 && phys_addr <= 0x0fff)
+	if (phys_addr <= 0x0fff)
 		return;
 
 	/*
-- 
1.8.3.1

