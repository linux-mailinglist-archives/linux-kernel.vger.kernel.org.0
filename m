Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6001F310
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 14:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfEOMKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 08:10:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54624 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbfEOMKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:10:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id i3so2408846wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 05:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CFKFwgLozVIM6dscXeJBqjWNwAotJvVX+KZD7JqTJhw=;
        b=rEZd9BQCMnveEHnW1EzvyB1mf4vdRdsj1KDivixg8uQO3ZRtnIPm9n7ribcAB6WmAG
         rYiqArIQw4TWQrCbePoK51atfLhI8UASv873PwpBgqGeraXUomT8Q9OVMKqgS7zhUtW+
         e6Um4yftwThM428E24xFoAy485veY5Sz6ep54y79hQmhvXUa6eqATSFqIkOP6TGCzmOj
         rUwVPTteu1AsINuyrk5rKeuqH/sqc0lcyoon80pHmoRcsaKJzA2ElDkRnpVtpDu/jfrG
         q4yz7DVm+2lRxc5346NALN5LG+Lg99spJProW6l2dzcESBAqDycAnG1Z/OD7wigZC6Vm
         QQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=CFKFwgLozVIM6dscXeJBqjWNwAotJvVX+KZD7JqTJhw=;
        b=T0WhSFPDOMBbTOVKjyAg9j5/XyHBbXBtF7dQ+q1sPj/ehjoMU1EhswjLYOMJN/B0bj
         lr0/4XWhQTYdk4yEiwtHIYqpsbRZ+m/kcOvXbD4FCctO+fNSkHGhS93QwP98Bt6+5wIK
         T5ugpbtBIAFX+Z0ccsDM3oefg9/I3Tmy9/OWhaOekS2VZKNqO4j1Ps89VODo2qzZiSPE
         sjOsTpEQ/08ALS5dEXZE8sgFrSfaWu42sU7wGZDN81NbfBkSIf9ae4g15miSGQ+qYXnV
         7EjkoEiqubpm476+jJ/XMS95FEdL1lfHX0SlgGzh1Honta1Mo7U11eSOihuexrc8zDok
         fSHg==
X-Gm-Message-State: APjAAAUIVUrkla7kpUg8JoksHfz3HwVA67TrDMdEFIqNpWEjGKPZtAsV
        zVIziN/24PlRWPaNYDxk3Zs=
X-Google-Smtp-Source: APXvYqyeRa0AATRlHj/RBPnO2Noo/rUCYItU5+6CIHDBuomet4LfUmlnkJB5oFmYAn07J0K50gSbdQ==
X-Received: by 2002:a1c:5f02:: with SMTP id t2mr22591116wmb.19.1557922212170;
        Wed, 15 May 2019 05:10:12 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id v1sm1847403wrd.47.2019.05.15.05.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 05:10:11 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 7FB421146D7B; Wed, 15 May 2019 14:10:10 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Include <asm/pte-walk.h> header file to fix a warning
Date:   Wed, 15 May 2019 14:10:08 +0200
Message-Id: <20190515121008.3992-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to include <asm/pte-walk.h> to provide the following prototype:
__find_linux_pte.

Remove the following warning treated as error (W=1):

  arch/powerpc/mm/pgtable.c:316:8: error: no previous prototype for '__find_linux_pte' [-Werror=missing-prototypes]

Fixes: 0caed4de502c ("powerpc/mm: move __find_linux_pte() out of hugetlbpage.c")
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/mm/pgtable.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index db4a6253df92..2aa042193ace 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -31,6 +31,7 @@
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include <asm/hugetlb.h>
+#include <asm/pte-walk.h>
 
 static inline int is_exec_fault(void)
 {
-- 
2.20.1

