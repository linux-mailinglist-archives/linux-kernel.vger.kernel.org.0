Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E83D73A410
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 08:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfFIG6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jun 2019 02:58:16 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:26926 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfFIG6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 02:58:16 -0400
Received: from grover.flets-west.jp (softbank126125154139.bbtec.net [126.125.154.139]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x596vHjR016968;
        Sun, 9 Jun 2019 15:57:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x596vHjR016968
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1560063438;
        bh=aYer5eaUX0jo6zJ4FAQB9HvsSWCvDxkv4u3/G3QNkYM=;
        h=From:To:Cc:Subject:Date:From;
        b=NI54pJHpgRUMzU8yFtXRf4eQOB7y/n2ngkcysUp/Mtlulk+euiFeQdtST9nF0vTMc
         tHfzRqcO9QPGAO1bRpV01Wt/T43CDDfprus8O52e+iOoh/wtaDPD07ETQU8X43xyd3
         tDXm4sqTEYec5sXKUX6iWuA7z0FNAoKaC6rXUD62S0etkMQeM20v0bm7Lsy1lIqK9c
         jQUhxtQl2l8rhzFy8fvFM5nClIjeEVLkdTrnlvmJh6kTfGraBDtDcuB7BOZ2kzCqSd
         ha41JddYgy7xprSNCOX2ZV7LuJYL7YZp2toO1wi5vrCZlDcTNY7iCAXXP4ZfS5Q0ew
         Xm+TQws6PDmoQ==
X-Nifty-SrcIP: [126.125.154.139]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] crypto: user - fix potential warnings in cryptouser.h
Date:   Sun,  9 Jun 2019 15:57:10 +0900
Message-Id: <20190609065710.18735-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function definitions in headers are usually marked as 'static inline'.

Since 'inline' is missing for crypto_reportstat(), if it were not
referenced from a .c file that includes this header, it would produce
a warning.

Also, 'struct crypto_user_alg' should be forward declared so that
we do not rely on the specific order of header inclusion.

Detected by compile-testing cryptouser.h as a standalone unit:

/include/crypto/internal/cryptouser.h:6:44: warning: ‘struct crypto_user_alg’ declared inside parameter list will not be visible outside of this definition or declaration
 struct crypto_alg *crypto_alg_match(struct crypto_user_alg *p, int exact);
                                            ^~~~~~~~~~~~~~~
./include/crypto/internal/cryptouser.h:11:12: warning: ‘crypto_reportstat’ defined but not used [-Wunused-function]
 static int crypto_reportstat(struct sk_buff *in_skb, struct nlmsghdr *in_nlh, struct nlattr **attrs)
            ^~~~~~~~~~~~~~~~~

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/crypto/internal/cryptouser.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/crypto/internal/cryptouser.h b/include/crypto/internal/cryptouser.h
index 8c602b187c58..2339cb06dbf8 100644
--- a/include/crypto/internal/cryptouser.h
+++ b/include/crypto/internal/cryptouser.h
@@ -3,12 +3,15 @@
 
 extern struct sock *crypto_nlsk;
 
+struct crypto_user_alg;
 struct crypto_alg *crypto_alg_match(struct crypto_user_alg *p, int exact);
 
 #ifdef CONFIG_CRYPTO_STATS
 int crypto_reportstat(struct sk_buff *in_skb, struct nlmsghdr *in_nlh, struct nlattr **attrs);
 #else
-static int crypto_reportstat(struct sk_buff *in_skb, struct nlmsghdr *in_nlh, struct nlattr **attrs)
+static inline int crypto_reportstat(struct sk_buff *in_skb,
+				    struct nlmsghdr *in_nlh,
+				    struct nlattr **attrs)
 {
 	return -ENOTSUPP;
 }
-- 
2.17.1

