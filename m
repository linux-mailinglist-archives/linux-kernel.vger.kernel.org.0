Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55E491604C5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2020 17:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgBPQSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 11:18:47 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:56103 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbgBPQSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 11:18:47 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id edd63ee0;
        Sun, 16 Feb 2020 16:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=m5m/7j7VWIeglScROPaBC7iLYfc=; b=eEXRae13a/dhQflP7lPv
        sTfZxzQzVvQoR5zTiksnzlnD7sMraXB8nv1RSHR9MGThb99In6kQdLUe14J5SmjY
        Qc6ZKfCLMFFqRx5rmueU2WONNOHucl8wm8MRhcxwjBrFi6vnzVDXTR+xWLxt1p6N
        Dzfr19kpcVaHthOjAba8vw1TF5CM30CPSXn/BRGiUaX9Y7bQf5PI/qc4RrPDeijl
        jIa+NVV3m8EBa9l2g7BcAA+MWMlr72zmYeT3VbVekW2/ZvQP7yNBKDKjpzs3ib4J
        mHy48YOs4i1oA4GspsM43xhMRslaOQsUZeiMV9aztdL0rFIQZz8ObGNAz/RxZGFI
        IA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id db5c0f5f (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Sun, 16 Feb 2020 16:16:22 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     tytso@mit.edu, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] random: always use batched entropy for get_random_u{32,64}
Date:   Sun, 16 Feb 2020 17:18:36 +0100
Message-Id: <20200216161836.1976-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that RDRAND is pretty slow. Comparing these two
constructions:

  for (i = 0; i < CHACHA_BLOCK_SIZE; i += sizeof(ret))
    arch_get_random_long(&ret);

and

  long buf[CHACHA_BLOCK_SIZE / sizeof(long)];
  extract_crng((u8 *)buf);

it amortizes out to 352 cycles per long for the top one and 107 cycles
per long for the bottom one, on Coffee Lake Refresh, Intel Core i9-9880H.

And importantly, the top one has the drawback of not benefiting from the
real rng, whereas the bottom one has all the nice benefits of using our
own chacha rng. As get_random_u{32,64} gets used in more places (perhaps
beyond what it was originally intended for when it was introduced as
get_random_{int,long} back in the md5 monstrosity era), it seems like it
might be a good thing to strengthen its posture a tiny bit. Doing this
should only be stronger and not any weaker because that pool is already
initialized with a bunch of rdrand data (when available). This way, we
get the benefits of the hardware rng as well as our own rng.

Another benefit of this is that we no longer hit pitfalls of the recent
stream of AMD bugs in RDRAND. One often used code pattern for various
things is:

  do {
  	val = get_random_u32();
  } while (hash_table_contains_key(val));

That recent AMD bug rendered that pattern useless, whereas we're really
very certain that chacha20 output will give pretty distributed numbers,
no matter what.

So, this simplification seems better both from a security perspective
and from a performance perspective.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/random.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c7f9584de2c8..037fdb182b4d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2166,15 +2166,6 @@ u64 get_random_u64(void)
 	struct batched_entropy *batch;
 	static void *previous;
 
-#if BITS_PER_LONG == 64
-	if (arch_get_random_long((unsigned long *)&ret))
-		return ret;
-#else
-	if (arch_get_random_long((unsigned long *)&ret) &&
-	    arch_get_random_long((unsigned long *)&ret + 1))
-	    return ret;
-#endif
-
 	warn_unseeded_randomness(&previous);
 
 	batch = raw_cpu_ptr(&batched_entropy_u64);
@@ -2199,9 +2190,6 @@ u32 get_random_u32(void)
 	struct batched_entropy *batch;
 	static void *previous;
 
-	if (arch_get_random_int(&ret))
-		return ret;
-
 	warn_unseeded_randomness(&previous);
 
 	batch = raw_cpu_ptr(&batched_entropy_u32);
-- 
2.25.0

