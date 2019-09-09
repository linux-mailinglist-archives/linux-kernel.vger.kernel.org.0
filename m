Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61D75AD237
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 05:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbfIIDdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Sep 2019 23:33:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43884 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387585AbfIIDdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 23:33:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id q27so9259623lfo.10
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 20:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/o6vLt7GIbUQdyckyHWDfK4HG927PsLZ3wVdNVov93Q=;
        b=bf60jgc9U+mH+vWLl1PtoV3ZBpkdYgZmpnb6Hxza20mkVEtbxDDCQCb7zsC4VideSS
         6vBlLuoL1JC9uOQy8Ta4GBER3Vis+jboLzFPDoo87GAlUNunSy1PckguIUdby4Th1KNl
         jeD6mgwB3OoyhZ9rGWhAzSvmzLll6oP6pgviSghQo4I+B/iQijI4dRz1wKHwFUwwd3sR
         lZqPqRLkCkBmI/HGD4VEa98U+A1YX7iUWCIZ3fuU0c8d+ns1NsWP5WMtLQZxEnaalnTJ
         RIFnw13UjnTWXN/6O2sheajLtEfcRD+WJ8TnL7VZdZtUvdiuR3EW8dHtv7r3EwV2Z65z
         qBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/o6vLt7GIbUQdyckyHWDfK4HG927PsLZ3wVdNVov93Q=;
        b=D2V0xT4hCVXyrC7+ARsu/wLpWdgXEZBTtkJ4Ov5bBMXWAJYg3w0symahdqXuN2boR1
         5Fh225BxupkIk7NfrVqeuvT8S4YC8Dro2nGltNK6BDwOyD41e4yRsfHr3WYk5OqKFQQ2
         xZi/7AEt5a7b6FRT46C7/HI7yw5w65hAHIBnc4iEVN02GhvoJLQ9agaWKX1nXZSNcwoQ
         5UOdRwuZ04UEnwueKO544MGZ8MVauv8mJjcct9q8s8WTeQy4zCAlliTijwxnmdMQSZH+
         X03szMPi/5XqFrRxCdk8FJGZXecLj5K3mMmb3y/at5gfIYIt+7ElPau57okpqVphNnA1
         5GaA==
X-Gm-Message-State: APjAAAVD7LCCQ7GY8/B7sTyePLMKnKOCcnG37ylB1Dk0yJoLgZMWnEj6
        PgkNaCXZLmY5/o05IB9vOhU=
X-Google-Smtp-Source: APXvYqwp07U2bz1sBYCMgWfDdLWolOMbuv+nOiibrT8ZLwfUqwD7a7cgOru15dMNvUTqVyYcnZ2JXQ==
X-Received: by 2002:a19:c396:: with SMTP id t144mr15001346lff.14.1567999991764;
        Sun, 08 Sep 2019 20:33:11 -0700 (PDT)
Received: from localhost.localdomain (128-73-37-85.broadband.corbina.ru. [128.73.37.85])
        by smtp.gmail.com with ESMTPSA id f22sm2783605lfk.56.2019.09.08.20.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 20:33:11 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 2/7] bitops: more BITS_TO_* macros
Date:   Sun,  8 Sep 2019 20:30:16 -0700
Message-Id: <20190909033021.11600-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909033021.11600-1-yury.norov@gmail.com>
References: <20190909033021.11600-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce BITS_TO_U64, BITS_TO_U32 and BITS_TO_BYTES as they are handy
in the following patches (BITS_TO_U32 specifically). Reimplement tools/
version of the macros according to the kernel implementation.

Also fix indentation for BITS_PER_TYPE definition.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitops.h       | 5 ++++-
 tools/include/linux/bitops.h | 9 +++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index cf074bce3eb32..e61c4e6142641 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -4,8 +4,11 @@
 #include <asm/types.h>
 #include <linux/bits.h>
 
-#define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
+#define BITS_TO_U64(nr)		DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
+#define BITS_TO_U32(nr)		DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
+#define BITS_TO_BYTES(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
 
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
diff --git a/tools/include/linux/bitops.h b/tools/include/linux/bitops.h
index 140c8362f1139..5fca38fe1ba83 100644
--- a/tools/include/linux/bitops.h
+++ b/tools/include/linux/bitops.h
@@ -14,10 +14,11 @@
 #include <linux/bits.h>
 #include <linux/compiler.h>
 
-#define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
-#define BITS_TO_U64(nr)		DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(u64))
-#define BITS_TO_U32(nr)		DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(u32))
-#define BITS_TO_BYTES(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE)
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
+#define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
+#define BITS_TO_U64(nr)		DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
+#define BITS_TO_U32(nr)		DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
+#define BITS_TO_BYTES(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
 
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
-- 
2.20.1

