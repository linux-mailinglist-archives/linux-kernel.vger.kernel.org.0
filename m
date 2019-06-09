Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E652E3ABC8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 22:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfFIUfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jun 2019 16:35:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39387 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFIUfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 16:35:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so4031999pfe.6;
        Sun, 09 Jun 2019 13:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=DJ9R2XlQXJKIHlHL3/N/vhTRIz38bxzVXxKS7ZNS8DY=;
        b=oPSARS9YLSxo/hDDXv2bo4hO/a/dKMiiB3HhJ+4bBtSZzKy9jbqPjhr9EssGdKOweL
         3xiLOcWqrMwl3xO34+XGcwE/8BNlTG+2PhjFXNVVLE9JfALHuzTySdKA/nhnv63VNRR+
         7q8oiPZCq92XSI65VcEobSwjYPw/GB8dXDwcBqMT9b0jFr1m76aUANdTgzio7Awb+Brj
         /3x11x9Uo8IgmhKMwgAxAUu7JE0sOYnLNGOX+mA0T+vhKYL6Xph70BCPxFF1oZJ1azlI
         +QxWxUwJO6AAtOVlkH9fXlbspYwbrHVRGSH/ZCAc9pJTgehPdq+KN8TGV0bZoLt0tYGP
         eZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=DJ9R2XlQXJKIHlHL3/N/vhTRIz38bxzVXxKS7ZNS8DY=;
        b=FjoykL5TGaJfjfuLb3WZ3F+ql1C9ecls1qUX+v7WX5pW3r40kaz8h7so+Mr13uz+Uv
         Y1nYsJK37ERaOQwyQYDgIzfF231+zjy/t1D8aR9ezWkBenbXwaM1+BqZHGObA8tJDu6r
         L9DQys4WStjxm7nEPfQgSuKS2cuS3VTiXbhvuBrn2ZFE/aBRl22VQKOyxkeJTNaTDKQc
         maAD55DER1cWzR4NDdjUDhl0K/p5ZWnejAE3cln2hY4Rqfj5UizGTtLX6hNqfxw9Zf9L
         BefFnPs2xnqom21GnbVQT8+LkrygcFFpwXamyf9q110vdPXrTflvxrdgrCmGYOnntusu
         5/gg==
X-Gm-Message-State: APjAAAVKSRNXbULK6YVobpTMSXztZd9H0WEsCT2dWgDKC5vozXM6w9R3
        Q6s+aIUGRmbFX/VzuELGyXQ=
X-Google-Smtp-Source: APXvYqxdmlhCfljGk7uU+LMdvvL9XWtqcmfUgTpmphzVwcdgmNBUZo20vdCQhwTeg9SIlYpJtYKC4Q==
X-Received: by 2002:a62:683:: with SMTP id 125mr63737117pfg.168.1560112547604;
        Sun, 09 Jun 2019 13:35:47 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l3sm8047998pgl.3.2019.06.09.13.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 13:35:46 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] s390: mark __ctl_set_bit and __ctl_clear_bit as __always_inline
Date:   Sun,  9 Jun 2019 13:35:44 -0700
Message-Id: <1560112544-10440-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s390:tinyconfig fails to build with gcc 8.3.0.

arch/s390/include/asm/ctl_reg.h:52:2: error: impossible constraint in 'asm'
  asm volatile(       \
  ^~~
arch/s390/include/asm/ctl_reg.h:62:2: note: in expansion of macro '__ctl_store'
  __ctl_store(reg, cr, cr);
  ^~~~~~~~~~~
s390/include/asm/ctl_reg.h:41:2: error: impossible constraint in 'asm'
  asm volatile(       \
  ^~~
arch/s390/include/asm/ctl_reg.h:64:2:
note: in expansion of macro '__ctl_load'
  __ctl_load(reg, cr, cr);
  ^~~~~~~~~~

Marking __ctl_set_bit and __ctl_clear_bit as __always_inline fixes the
problem.

Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/s390/include/asm/ctl_reg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/ctl_reg.h b/arch/s390/include/asm/ctl_reg.h
index 4600453536c2..3bda757317cf 100644
--- a/arch/s390/include/asm/ctl_reg.h
+++ b/arch/s390/include/asm/ctl_reg.h
@@ -55,7 +55,7 @@
 		: "i" (low), "i" (high));				\
 } while (0)
 
-static inline void __ctl_set_bit(unsigned int cr, unsigned int bit)
+static __always_inline void __ctl_set_bit(unsigned int cr, unsigned int bit)
 {
 	unsigned long reg;
 
@@ -64,7 +64,7 @@ static inline void __ctl_set_bit(unsigned int cr, unsigned int bit)
 	__ctl_load(reg, cr, cr);
 }
 
-static inline void __ctl_clear_bit(unsigned int cr, unsigned int bit)
+static __always_inline void __ctl_clear_bit(unsigned int cr, unsigned int bit)
 {
 	unsigned long reg;
 
-- 
2.7.4

