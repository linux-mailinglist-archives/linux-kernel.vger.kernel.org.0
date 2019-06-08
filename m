Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21F6A39B89
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2019 09:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfFHH1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 03:27:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42538 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfFHH1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 03:27:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id go2so1658522plb.9
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 00:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=u3CahkhmSiM44HPpH15qbfZKuXzf9Enid5wRXgbVRzs=;
        b=oI7K3Ky5YWP4vEmEaG26Gk7Hc9F18TkCUNPvTuvYtP1PLJEPrkU7rHxO2v/L0GPDSf
         BEnT7rW+WK62rddCmTDAEXQ9LhbNsBYG3VoMDHsTahKzGFReGtuR7ciBJVm71523pBNm
         bh0UR5op5/VSqeA8OMy1rNCV7efUGgEAvchjrt4z77pRY+URwnhPR8QPq8IrsZ6dHHa6
         VjqEf8yV7a1m6cq/3ApvhOm8knVZwRBD95I33fbhqnYDVyLDLjZ76o4We3G31hni/nrb
         gNdngn7cgP4WTwDg51wl0Sv7JmWLRxIRcB8iUDZ91KoNYWkx/5eQT6eCl/xHWzCDgxFS
         W04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u3CahkhmSiM44HPpH15qbfZKuXzf9Enid5wRXgbVRzs=;
        b=YIXuk45/ftdR1JGX1Lh9aJQ4i6HejXwBXrEey8xHWTWZECuNn+jkDPCUkdY98yJ9T3
         vk5i1eLz+V6YHj15iXM8RtSyjrCW0e3cHqf4oIjUkiTGXUHK2P4LsFh/tXOgYvKQJN3i
         y/8qs1A4vgplBkhDVSVLwSJNlsV8eO7jaPMp6XVR9DzsqTB9udSPkd7q4mwI6mJe5K/5
         wIYsFA/D2XHHDULCS/LSJ5IUwP6BLGByNfi4gKWC1OyH1bFpwpOUIrwBbWA93GqVLat6
         RVktPHLRP9uXoof7/bJ9q3jfL0sg07Cnwuwx6cjrnVGsWzbJ8WWmC72eXFrfGgFvlneG
         t9+g==
X-Gm-Message-State: APjAAAVS9vWieTCaYwUySp+z3+ffXqxYc7FZUQUl2phtW+zhR7RcUQqq
        kUrWhY8GOHXWH9+fU2xiyxE=
X-Google-Smtp-Source: APXvYqx4asH8uTguE/RI7yxJFB3rZqVXoepMJxIxz+Z42k0MFHzygCvVUYr7k9FIYhZI1VEUX5f6yw==
X-Received: by 2002:a17:902:24d:: with SMTP id 71mr61476859plc.166.1559978871004;
        Sat, 08 Jun 2019 00:27:51 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.157.107.159])
        by smtp.gmail.com with ESMTPSA id b8sm5092440pff.20.2019.06.08.00.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 00:27:50 -0700 (PDT)
From:   Hao Xu <haoxu.linuxkernel@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, haoxu.linuxkernel@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: kpc2000: kpc2000_i2c: void* -> void *
Date:   Sat,  8 Jun 2019 15:27:46 +0800
Message-Id: <1559978867-3693-1-git-send-email-haoxu.linuxkernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

modify void* to void * for #define inb_p(a) readq((void*)a)
and #define outb_p(d,a) writeq(d,(void*)a)

Signed-off-by: Hao Xu <haoxu.linuxkernel@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index a434dd0..de3a0c8 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -124,9 +124,9 @@ struct i2c_device {
 
 // FIXME!
 #undef inb_p
-#define inb_p(a) readq((void*)a)
+#define inb_p(a) readq((void *)a)
 #undef outb_p
-#define outb_p(d,a) writeq(d,(void*)a)
+#define outb_p(d,a) writeq(d,(void *)a)
 
 /* Make sure the SMBus host is ready to start transmitting.
  * Return 0 if it is, -EBUSY if it is not.
-- 
1.8.3.1

