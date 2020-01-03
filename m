Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6C0312FDEE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 21:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgACU3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 15:29:00 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45838 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbgACU26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 15:28:58 -0500
Received: by mail-qv1-f67.google.com with SMTP id l14so16681431qvu.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 12:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7BXejbsWE/rThMpuxRfrU7buBJImEObkv77kB9gVvuE=;
        b=pCI6cUxVnrqY0DP6jP3mTBmI1JdKHG4nCIc62hrvDWxFpHP5jWK2wDFKd68yaCHQxj
         2Zo3PaDaUh7EC5FZoPO7VkZDVpwU6WV+HbcUEiznNC6ZRo1qJixezOM6HZRroJzKjk+r
         Dfj5Rera5ctZXxsg6SkjCsrvAy2ZA1QieQp2qtasc0HixOKXLc/rPFFaBN3+4WlPVRk9
         fUF8fhPKqtcYzaUBVtikbd/vT1aJisjIHhVlGQ0UC5GiUQjsqjKhm0ZsK9mOxB1L3aAZ
         TcDKhbk2eW3il7O9ZXLRNRed0rUBgZQgzjKt1/kh9Jn77JLPyiVrqpO9kJcpbIQWEazI
         +FAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7BXejbsWE/rThMpuxRfrU7buBJImEObkv77kB9gVvuE=;
        b=DN50p+NH41Fl4GqzuyjXfjN6ukG7fe9XDFhITAFVJ1WvddHEs4QgqVZJ0bgf3ENV4+
         K/CMaI6RrLvw9ovLrWO5D1+SbMwFqbR9TK9G40hcrQJ1+FB9zQwbTzKj2HkD3aA8cNxp
         p4KknB0OFlhhvhkM2nGIpEyn/I9AzmSpbVtDwTzlkNvBk42D0EakxxA3AURpiCwIj1q4
         2R5Dj//DKuAUapprEJ+6N0jjow5nAnaQ58F0oLJ9APtDyxLufDeDCrAXmG5TBxZQpth4
         LNCe7u10Eiawj8ZutV9eK8tJhn/mSjlf+SID/CeBQXeuPVJeck487QfeQDLqnp3OwAIe
         OgVw==
X-Gm-Message-State: APjAAAWHJk1sRDMHJbKZ/fmAQJfuJe3iJMFnVhYCAQ4UREdQWvTPgDrw
        hbw/QxAYOocEQpWc6ozM2Es=
X-Google-Smtp-Source: APXvYqx5+71pDJJzUeQ5XDLHnXRxJcRW2vVyDOh9NLsFVrFNP7pvCpTwBYlAS1tWE/FsN99f5SDIfw==
X-Received: by 2002:a05:6214:1745:: with SMTP id dc5mr67100723qvb.230.1578083337550;
        Fri, 03 Jan 2020 12:28:57 -0800 (PST)
Received: from yury-thinkpad.dhcp.amer.jpmchase.net ([2604:2000:4185:2300:b196:4884:e960:2cb8])
        by smtp.gmail.com with ESMTPSA id y91sm19048347qtd.28.2020.01.03.12.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 12:28:56 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Allison Randal <allison@lohutok.net>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] lib/find_bit.c: uninline helper _find_next_bit()
Date:   Fri,  3 Jan 2020 12:28:46 -0800
Message-Id: <20200103202846.21616-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103202846.21616-1-yury.norov@gmail.com>
References: <20200103202846.21616-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It saves 25% of .text for arm64, and more for BE architectures.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/find_bit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/find_bit.c b/lib/find_bit.c
index c03cbecb2b1f6..0e4b2b90c9c02 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -27,7 +27,7 @@
  *    searching it for one bits.
  *  - The optional "addr2", which is anded with "addr1" if present.
  */
-static inline unsigned long _find_next_bit(const unsigned long *addr1,
+static unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
 		unsigned long start, unsigned long invert, unsigned long le)
 {
-- 
2.20.1

