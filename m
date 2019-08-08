Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5379F85C46
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 10:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbfHHIAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 04:00:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45025 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731801AbfHHIAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:00:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so43633701pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 01:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xMV6uY/vHKVkmIKzViydmdx5B5e/xYSR7IpOeW3QoL8=;
        b=h2q0oFr6RoQTAhYh9x7GZGp+e7kwYU3qvNAgbY6MX792jT3Zcvv9hdNTD84955pr8g
         FDV6QHHKfYGqd5So/bC4uFNydlNxO6ZY+ADSeZTY9ESDL71ySAAhewAFPUobvN1i2d7Q
         pADV1J9r8hvb6WhxAAq2rXg4E0ZfOF9G5jShMjxJ1HI6F0SFUe2xKk7Y2QA0zCIjXkK9
         RjszYfVEJOa68PGiNiS4e92mFNICczNniUepfrudUghE+up+YhHmrmRtwyQJ2aAt0VPv
         yoOUu9EGBVRFn+lWBdL7Ux6dqPc0V5AnEzB7C0s59aSjSq6fiS0lvSssgKIcbKSiLwyA
         yNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xMV6uY/vHKVkmIKzViydmdx5B5e/xYSR7IpOeW3QoL8=;
        b=d/mO1g3Iq3SHCA1hOWcCr67v+GpycX8Vby3G5ytVLd+ZQGcfddbUkKfNJfsTM+QnAj
         Diya/o9LIGm60R/ulV9cYyjlAKP9SRmJUNU/akJ+Zk0/lnD/TalEOjlBfYM96wt1g+Nq
         xHy0ke8V+QrNbTPF1qDGz7R6e5T8sfOgpq5Lqo2EInKponst8kZwu1koJouG8hSy6Rg9
         zxIH1UQQmeQCDBDcujo/S6C71GSzRrtZ94rac/BP/KgxvUtm2XuuJWWSDk35gyv9QoBs
         8k8V/loUEl9FRjO9JhorzBOTKAjBKV68kES9mXsWxtBvED1fsUrk8Nhy4uycEVSLIf9v
         pjmQ==
X-Gm-Message-State: APjAAAVCnNS9ilWA3UGW8D4tXAC4erG+lbphDiaztuMv1fPOxLNFN65j
        jT5l94/2M8/hRLrUDcQynQK53A==
X-Google-Smtp-Source: APXvYqzl/u71XCsVZLGazpQDqHur9BQxABWwvYEfmrFrgDr0o52f0uN0nguGi1Az1khXp/60g0wxDg==
X-Received: by 2002:a62:1444:: with SMTP id 65mr13849575pfu.145.1565251204644;
        Thu, 08 Aug 2019 01:00:04 -0700 (PDT)
Received: from localhost.localdomain (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id t8sm107697374pfq.31.2019.08.08.01.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Aug 2019 01:00:04 -0700 (PDT)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     paul.walmsley@sifive.com, palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH 2/2] riscv: Make __fstate_clean() can work correctly.
Date:   Thu,  8 Aug 2019 15:58:41 +0800
Message-Id: <1565251121-28490-3-git-send-email-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565251121-28490-1-git-send-email-vincent.chen@sifive.com>
References: <1565251121-28490-1-git-send-email-vincent.chen@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the __fstate_clean() function can correctly set the
state of sstatus.FS in pt_regs to SR_FS_CLEAN.

Tested on both QEMU and HiFive Unleashed using BBL + Linux.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/include/asm/switch_to.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index d5fe573..544f99a 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -16,7 +16,7 @@ extern void __fstate_restore(struct task_struct *restore_from);
 
 static inline void __fstate_clean(struct pt_regs *regs)
 {
-	regs->sstatus |= (regs->sstatus & ~(SR_FS)) | SR_FS_CLEAN;
+	regs->sstatus = (regs->sstatus & ~(SR_FS)) | SR_FS_CLEAN;
 }
 
 static inline void fstate_off(struct task_struct *task,
-- 
2.7.4

