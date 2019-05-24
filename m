Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47328295E7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 12:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390525AbfEXKdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 06:33:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34591 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389942AbfEXKdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:33:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id f8so9492016wrt.1;
        Fri, 24 May 2019 03:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xy3TJvnccS7kGUcSZLX9sdDSzruBA3cqxWDF1khBA+4=;
        b=a5ovVBZw+lCIGJjdJVOqP7nQ8+/GJah+4KRJNDsic1i593Xr2molZadc/TTL321dhs
         6h+tDBCJh+WhiklO4rE7x07qlQCGLadG/4db6XsJZ7moFJvtkuRQfYWyfjS2T9GngewH
         bMnu2E9D2iCPv0O9425dOC58fFLEK1jnINmW17ztiyXog0siLAICmazaUr/J4MiDKQOd
         z+7yzpWYUgIY+NfxG8GjpXRohOqAQUayvuosE7qiIzeziUuxFWlUaBSTUWZCsFXFqMkb
         eLqN7GY91W5+taYvQfV+j+e34K43aY0vn8KSGGULj/ouBjNlp/RcGHHtbYFnrV6g4gmA
         +uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=xy3TJvnccS7kGUcSZLX9sdDSzruBA3cqxWDF1khBA+4=;
        b=XNKs8gEz1CNReDq4fOZUu0fPS44gKtmO5eYkHQWSmQx2uhU6jqUhLCWLYOxI21oUfZ
         IDMb6lJquRbDnX/q+9nqPSU9i44mALiCgfvLc1UmKJ7fYE54kYq2mhPlWxS/efMkz8zL
         +HzspWOxlhyTMt8KAXQ5wbDzmyPisLEN1tAC87FBkZNWwmTxLz6EfUisPWiKbguSKK/C
         LaZ9gpQ4cJ4Qsa5bK/9uGL2d/qbv83YyPLKNBHHbnw19f9O6q2s/dCswRrW1yKtJuzcp
         rABfyc56ogGFI3DtmPasyoDvG3qiTUghGhLcz7pBCx0Ea5nednw9qt0QlDEzVkzKGWxa
         /DBQ==
X-Gm-Message-State: APjAAAUkKg54p3EMTue7hTZvEvSnJR/1+dDUC6QLUAwz/XPwTUeMkTWP
        IZ9hWAFZZMVdv+qFNk17ysdoI22M
X-Google-Smtp-Source: APXvYqxaatb4farmltlaj0cwWSTh0PzBX2v0mslJ3vCUXBT5o/rX4TmsParooCTTZ8kwa95GD1gYcw==
X-Received: by 2002:adf:ec0f:: with SMTP id x15mr63377772wrn.120.1558694023967;
        Fri, 24 May 2019 03:33:43 -0700 (PDT)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id f16sm1976736wrx.58.2019.05.24.03.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 03:33:43 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 8D3EB11415E7; Fri, 24 May 2019 12:33:41 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     trivial@kernel.org, kernel-janitors@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource: Move inline keyword to the beginning of function declarations
Date:   Fri, 24 May 2019 12:33:39 +0200
Message-Id: <20190524103339.28787-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inline keyword was not at the beginning of the function declarations.
Fix the following warnings triggered when using W=1:

  kernel/time/clocksource.c:108:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
  kernel/time/clocksource.c:113:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 kernel/time/clocksource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 3bcc19ceb073..fff5f64981c6 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -105,12 +105,12 @@ static DEFINE_SPINLOCK(watchdog_lock);
 static int watchdog_running;
 static atomic_t watchdog_reset_pending;
 
-static void inline clocksource_watchdog_lock(unsigned long *flags)
+static inline void clocksource_watchdog_lock(unsigned long *flags)
 {
 	spin_lock_irqsave(&watchdog_lock, *flags);
 }
 
-static void inline clocksource_watchdog_unlock(unsigned long *flags)
+static inline void clocksource_watchdog_unlock(unsigned long *flags)
 {
 	spin_unlock_irqrestore(&watchdog_lock, *flags);
 }
-- 
2.20.1

