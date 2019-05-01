Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8E7103A6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 03:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfEABHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 21:07:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45684 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbfEABGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 21:06:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id i21so4204679pgi.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 18:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yW25BIpw+3OdLrz2ZA6bQCaxdj/ZNzRUZJYjM1RP07U=;
        b=tiw+3vW/xxGdEdVQeatzmXTfVuogkzZBodBCn8i10QdmiHdpiuKNmOIzbFj/lGWaEU
         omHsStfCtPyxVQR0mUcLN7MBvJskP/61dOLBl+Vg3DBmTjStMmkbCUg2EyCaR4p1NKLR
         p+3ycGH9rzLatFO2VJbk12e71aLkL0ATFhmWBaAhR3lIsjhRXob80GjATLBZ1UEs4Z4r
         RrDTT4aZEjvtSzp58qMvy8X8hwFiAewX7nMHOu8MGg//ZmbR/tdTVak2TWYZGMT5J3G2
         JOOsptdALjpKS2p2G4838hJis1a0kefqDRE7i6rZdkQ2J/jM3YL2jYsmKec4EBBcBmma
         isoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yW25BIpw+3OdLrz2ZA6bQCaxdj/ZNzRUZJYjM1RP07U=;
        b=eVdI1cBpVcjG9dHXLPE1si5I4FbeMwfFfrihklz4nmNG0TPbwItYwdTY1UwbrMIlHu
         7C8Vbjt4OBTzVyhSvbsruQLzKCNl5E++WtHODP0ivUHew424ijH4Yb/xvDuI98aPizRp
         fUy+FLVEW2ddi1TAiy6VFFWk84lgmTV72DvaFwmsCUCmB5G/Cpkra5NqEI+2MNLYE1AA
         VntRKcaAnCYvvBAfsXb2G0U4rX3epsZ6prmYrEU+4rjdzvgJ9SbmTrD262x9rVOrzZJa
         DsVkSK5nSHYPOjDqMOAHZxka/7BeI6QnCASRgI/Kw00yI/bwsMwueAWAbevxOjdJWFMA
         pPpg==
X-Gm-Message-State: APjAAAWKzffyiTSu2AuS/BXSvLwF5vNISaLngesv5AcaaP2gGaGUEtJs
        MCwBBI0luLI8PiWsu5wVSy8=
X-Google-Smtp-Source: APXvYqz4M+QQmOmmCEQmONTF8EZI8GdJ3Xwm5c3zOwzBAg/JaIZesYp5e2BWI4rzee6ckJP+tTO7Hw==
X-Received: by 2002:a65:534b:: with SMTP id w11mr11874654pgr.210.1556672810728;
        Tue, 30 Apr 2019 18:06:50 -0700 (PDT)
Received: from localhost ([2601:640:7:332f:bc53:6e04:b584:e900])
        by smtp.gmail.com with ESMTPSA id b5sm3931194pfo.153.2019.04.30.18.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 18:06:50 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
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
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4/7] lib: make bitmap_parse_user a wrapper on bitmap_parse
Date:   Tue, 30 Apr 2019 18:06:33 -0700
Message-Id: <20190501010636.30595-5-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501010636.30595-1-ynorov@marvell.com>
References: <20190501010636.30595-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we parse user data byte after byte which leads to
overcomplicating of parsing algorithm. There are no performance
critical users of bitmap_parse_user(), and so we can duplicate
user data to kernel buffer and simply call bitmap_parselist().
This rework lets us unify and simplify bitmap_parse() and
bitmap_parse_user(), which is done in the following patch.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/bitmap.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index f235434df87b..300732031fad 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -434,22 +434,22 @@ EXPORT_SYMBOL(__bitmap_parse);
  *    then it must be terminated with a \0.
  * @maskp: pointer to bitmap array that will contain result.
  * @nmaskbits: size of bitmap, in bits.
- *
- * Wrapper for __bitmap_parse(), providing it with user buffer.
- *
- * We cannot have this as an inline function in bitmap.h because it needs
- * linux/uaccess.h to get the access_ok() declaration and this causes
- * cyclic dependencies.
  */
 int bitmap_parse_user(const char __user *ubuf,
 			unsigned int ulen, unsigned long *maskp,
 			int nmaskbits)
 {
-	if (!access_ok(ubuf, ulen))
-		return -EFAULT;
-	return __bitmap_parse((const char __force *)ubuf,
-				ulen, 1, maskp, nmaskbits);
+	char *buf;
+	int ret;
 
+	buf = memdup_user_nul(ubuf, ulen);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	ret = bitmap_parse(buf, ulen, maskp, nmaskbits);
+
+	kfree(buf);
+	return ret;
 }
 EXPORT_SYMBOL(bitmap_parse_user);
 
-- 
2.17.1

