Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 012C319605D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 22:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgC0VY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 17:24:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40174 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbgC0VYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 17:24:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id u10so13235550wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 14:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=md+qLZf6jlB2TWcs3jNatI8krmg3DHFDovsw6g2VMMw=;
        b=azbjhuylivsenpiyEmxUiv4wG/EgSxXc0RGAbvQtpoPEsksdel/3DGSndMYA+Z9CGk
         4hk0sjJy7PIQHsndldvlP8+l6ihufc5epfRZOy3epHDkkHvldG7pHrSgLO9lAbogL3ip
         2ihZyhhxhLqdEcL4YJQmpBtZCio8mZUSIzy2zSV7GiKsSxeBRAeFARuu65p545fzKw3C
         bU4ZumMLaZRLHVT5yDBWvzBcTLtYfPhMEm+Evxda8dkVRwbCnA0AGPU/5hJ0lvffETZq
         Hq/YhlsIH6Q3Lnjc08Ss+5EVAK85kElt0lFql8Z+tEpNkw6wjcmM0+2VxY+B3Vw+9Nig
         bAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=md+qLZf6jlB2TWcs3jNatI8krmg3DHFDovsw6g2VMMw=;
        b=d5oHVAFxSypM00ny/lK8E6hfs6aBcwVWQgtpIPdtc5bxO4W1k5JUZ+kmsa4uQrGFFA
         g4S/j+LRQUIR4EJ/7F/xBjtHPi23HXbqFosTeTWoOjm8Yg4AKgK+GEDdbQZXYLVPt9Gg
         l0Vt/d1Az8Omw9MgLgJhddAJLo9/0hIUjcanq3ZI0SOiyzqbkoiUkLdpr1IoqpTPna0A
         syh7sxwMuGPKq5wBr5EJ0xUeNw3AUDpy08wYqfM6qPHzQr4/TolydB/2yVlbfdByMKN3
         sTf8quIPlzP+GASB6MCJjgnpZEUd+Ew8YgYgZsOyJG5CSvmburJCW88tDI9PtjE2eY+c
         IhjQ==
X-Gm-Message-State: ANhLgQ1aKdUBtgjp0UppL2unPsUs/r+Y/biEmDok4aO0fpzMzUB0wMAW
        bKGPgLc/z9ZgLQ+UI2H10Q==
X-Google-Smtp-Source: ADFU+vvBnzYVvHis3Wln/w8bECkvXW/SeezcJJ44FX5ilks1O1oHCz8cGJYf0ui3x48BYxRaDcCyqA==
X-Received: by 2002:adf:a549:: with SMTP id j9mr1408013wrb.183.1585344261719;
        Fri, 27 Mar 2020 14:24:21 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-82-35.as13285.net. [92.23.82.35])
        by smtp.gmail.com with ESMTPSA id h132sm10215141wmf.18.2020.03.27.14.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 14:24:21 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     julia.lawall@lip6.fr
Cc:     boqun.feng@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org (open list:IRQ SUBSYSTEM)
Subject: [PATCH 04/10] irq: Replace 1  by true
Date:   Fri, 27 Mar 2020 21:23:51 +0000
Message-Id: <20200327212358.5752-5-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327212358.5752-1-jbi.octave@gmail.com>
References: <0/10>
 <20200327212358.5752-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinelle reports a warning

WARNING: Assignment of 0/1 to bool variable

To fix this, 1 is replaced by true.
Given that variable noirqdebug is of bool type.
This fixes the warnings.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/irq/spurious.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index f865e5f4d382..70ba6d55d02a 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -431,7 +431,7 @@ bool noirqdebug __read_mostly;
 
 int noirqdebug_setup(char *str)
 {
-	noirqdebug = 1;
+	noirqdebug = true;
 	printk(KERN_INFO "IRQ lockup detection disabled\n");
 
 	return 1;
-- 
2.25.1

