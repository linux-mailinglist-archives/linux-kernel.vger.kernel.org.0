Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CECCF4C51
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 14:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfKHNB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 08:01:56 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33328 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfKHNBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:01:54 -0500
Received: by mail-lf1-f65.google.com with SMTP id d6so4017971lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z2c319/rjPUXp8iRV62XAcjKgiOjRbx515GvierWVkM=;
        b=fdJQuwFQEx3WiNuMOb1gdsH9SW9HI7w7+NIWF38nxViFmcIxtLR9epgSWnsWqGFr/4
         41v4fU4VePhq0oBGJYDl/RN7X1BEoWQl3Z5KthO6Przp/ZZJbJLo1K7p+2g9VgKelj7W
         2z4QZPD8TJ1MwkV9FRtWWs+r90Jdp/lOZJ2a4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z2c319/rjPUXp8iRV62XAcjKgiOjRbx515GvierWVkM=;
        b=OaEXNVH0ko3X7G1WX+WGjTxwFzLqD40RlUdtVzc4dBrNM4AbwQCWr4mdywrkORwiXL
         yeLAVuaSX/C4BcnaMLvuZYuDuisAjqtgpCpzkG0yNCVk7jLhNEwmDANSzWQkxHLjQj3R
         SMdzfqZal0ug5u2VGMEDzvQXQJ62+MNjXec0JfOWPMs6druzQ9nPBEmhnkU1jEazg5/3
         pVoZmaUSxY8QDv7Zz9KgdcVRmXWV/aFQFJitY4G4FJqNGEJOnIf5W8x715LHUWopjt5z
         j2Osmoij75g6Aw/Wwv+CEeveI9HTCBIi8S7rVGUvZtaL0qMCDpr+wfq8JH+VOyKufD5X
         fDfQ==
X-Gm-Message-State: APjAAAXw7+DrLWtQV6aU7D91zzpV36pItZ6mNxYM7Pz1Fsw+qEZmGQyy
        ByHjGIyfNQYZQYqNyWSwfPNEkg==
X-Google-Smtp-Source: APXvYqxHLvZgvF+EG0/l58iTz6Czvi2Tdy1nhKy8rpZoIP81L5RxYC4QrddV3/xHVXg3rNCq06dYbw==
X-Received: by 2002:a05:6512:509:: with SMTP id o9mr6810861lfb.28.1573218110212;
        Fri, 08 Nov 2019 05:01:50 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:01:49 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 17/47] soc: fsl: qe: remove unused qe_ic_set_* functions
Date:   Fri,  8 Nov 2019 14:00:53 +0100
Message-Id: <20191108130123.6839-18-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no current callers of these functions, and they use the
ppc-specific virq_to_hw(). So removing them gets us one step closer to
building QE support for ARM.

If the functionality is ever actually needed, the code can be dug out
of git and then adapted to work on all architectures, but for future
reference please note that I believe qe_ic_set_priority is buggy: The
"priority < 4" should be "priority <= 4", and in the else branch 24
should be replaced by 28, at least if I'm reading the data sheet right.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 94 --------------------------------------
 include/soc/fsl/qe/qe_ic.h |  4 --
 2 files changed, 98 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index de2ca2e3a648..4839dcd5c5d3 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -445,97 +445,3 @@ static int __init qe_ic_of_init(void)
 	return 0;
 }
 subsys_initcall(qe_ic_of_init);
-
-void qe_ic_set_highest_priority(unsigned int virq, int high)
-{
-	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
-	u32 temp = 0;
-
-	temp = qe_ic_read(qe_ic->regs, QEIC_CICR);
-
-	temp &= ~CICR_HP_MASK;
-	temp |= src << CICR_HP_SHIFT;
-
-	temp &= ~CICR_HPIT_MASK;
-	temp |= (high ? SIGNAL_HIGH : SIGNAL_LOW) << CICR_HPIT_SHIFT;
-
-	qe_ic_write(qe_ic->regs, QEIC_CICR, temp);
-}
-
-/* Set Priority level within its group, from 1 to 8 */
-int qe_ic_set_priority(unsigned int virq, unsigned int priority)
-{
-	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
-	u32 temp;
-
-	if (priority > 8 || priority == 0)
-		return -EINVAL;
-	if (WARN_ONCE(src >= ARRAY_SIZE(qe_ic_info),
-		      "%s: Invalid hw irq number for QEIC\n", __func__))
-		return -EINVAL;
-	if (qe_ic_info[src].pri_reg == 0)
-		return -EINVAL;
-
-	temp = qe_ic_read(qe_ic->regs, qe_ic_info[src].pri_reg);
-
-	if (priority < 4) {
-		temp &= ~(0x7 << (32 - priority * 3));
-		temp |= qe_ic_info[src].pri_code << (32 - priority * 3);
-	} else {
-		temp &= ~(0x7 << (24 - priority * 3));
-		temp |= qe_ic_info[src].pri_code << (24 - priority * 3);
-	}
-
-	qe_ic_write(qe_ic->regs, qe_ic_info[src].pri_reg, temp);
-
-	return 0;
-}
-
-/* Set a QE priority to use high irq, only priority 1~2 can use high irq */
-int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high)
-{
-	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
-	u32 temp, control_reg = QEIC_CICNR, shift = 0;
-
-	if (priority > 2 || priority == 0)
-		return -EINVAL;
-	if (WARN_ONCE(src >= ARRAY_SIZE(qe_ic_info),
-		      "%s: Invalid hw irq number for QEIC\n", __func__))
-		return -EINVAL;
-
-	switch (qe_ic_info[src].pri_reg) {
-	case QEIC_CIPZCC:
-		shift = CICNR_ZCC1T_SHIFT;
-		break;
-	case QEIC_CIPWCC:
-		shift = CICNR_WCC1T_SHIFT;
-		break;
-	case QEIC_CIPYCC:
-		shift = CICNR_YCC1T_SHIFT;
-		break;
-	case QEIC_CIPXCC:
-		shift = CICNR_XCC1T_SHIFT;
-		break;
-	case QEIC_CIPRTA:
-		shift = CRICR_RTA1T_SHIFT;
-		control_reg = QEIC_CRICR;
-		break;
-	case QEIC_CIPRTB:
-		shift = CRICR_RTB1T_SHIFT;
-		control_reg = QEIC_CRICR;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	shift += (2 - priority) * 2;
-	temp = qe_ic_read(qe_ic->regs, control_reg);
-	temp &= ~(SIGNAL_MASK << shift);
-	temp |= (high ? SIGNAL_HIGH : SIGNAL_LOW) << shift;
-	qe_ic_write(qe_ic->regs, control_reg, temp);
-
-	return 0;
-}
diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
index 43e4ce95c6a0..d47eb231519e 100644
--- a/include/soc/fsl/qe/qe_ic.h
+++ b/include/soc/fsl/qe/qe_ic.h
@@ -63,8 +63,4 @@ static inline unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 { return 0; }
 #endif /* CONFIG_QUICC_ENGINE */
 
-void qe_ic_set_highest_priority(unsigned int virq, int high);
-int qe_ic_set_priority(unsigned int virq, unsigned int priority);
-int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
-
 #endif /* _ASM_POWERPC_QE_IC_H */
-- 
2.23.0

