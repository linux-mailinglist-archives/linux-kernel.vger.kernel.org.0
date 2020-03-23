Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52BC0190167
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 23:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgCWWy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 18:54:56 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:33292 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgCWWyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 18:54:55 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jGVxM-00071z-4E; Tue, 24 Mar 2020 09:54:05 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 24 Mar 2020 09:54:03 +1100
Date:   Tue, 24 Mar 2020 09:54:03 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 5.6
Message-ID: <20200323225403.GA10100@gondor.apana.org.au>
References: <20190916084901.GA20338@gondor.apana.org.au>
 <20190923050515.GA6980@gondor.apana.org.au>
 <20191202062017.ge4rz72ki3vczhgb@gondor.apana.org.au>
 <20191214084749.jt5ekav5o5pd2dcp@gondor.apana.org.au>
 <20200115150812.mo2eycc53lbsgvue@gondor.apana.org.au>
 <20200213033231.xjwt6uf54nu26qm5@gondor.apana.org.au>
 <20200224060042.GA26184@gondor.apana.org.au>
 <20200312115714.GA21470@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312115714.GA21470@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

This push fixes a correctness bug in the ARM64 version of ChaCha
for lib/crypto used by WireGuard.

The following changes since commit 1579f1bc3b753d17a44de3457d5c6f4a5b14c752:

  crypto: x86/curve25519 - support assemblers with no adx support (2020-03-05 18:28:09 +1100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus 

for you to fetch changes up to c8cfcb78c65877313cda7bcbace624d3dbd1f3b3:

  crypto: arm64/chacha - correctly walk through blocks (2020-03-20 14:35:27 +1100)

----------------------------------------------------------------
Jason A. Donenfeld (1):
      crypto: arm64/chacha - correctly walk through blocks

 arch/arm64/crypto/chacha-neon-glue.c   |  8 ++++----
 lib/crypto/chacha20poly1305-selftest.c | 11 ++++++++---
 2 files changed, 12 insertions(+), 7 deletions(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
