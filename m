Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF3C11F109
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 09:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfLNIr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 03:47:57 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:38502 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfLNIr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 03:47:57 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ig35e-00047a-5m; Sat, 14 Dec 2019 16:47:54 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ig35Z-0005rb-Ua; Sat, 14 Dec 2019 16:47:49 +0800
Date:   Sat, 14 Dec 2019 16:47:49 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 5.5
Message-ID: <20191214084749.jt5ekav5o5pd2dcp@gondor.apana.org.au>
References: <20190916084901.GA20338@gondor.apana.org.au>
 <20190923050515.GA6980@gondor.apana.org.au>
 <20191202062017.ge4rz72ki3vczhgb@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202062017.ge4rz72ki3vczhgb@gondor.apana.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

This push fixes another build problem for Wireguard without Crypto
API.

The following changes since commit 8a6b8f4d7a891ac66db4f97900a86b55c84a5802:

  crypto: hisilicon - fix a NULL vs IS_ERR() bug in sec_create_qp_ctx() (2019-11-27 13:08:50 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

for you to fetch changes up to 84faa307249b341f6ad8de3e1869d77a65e26669:

  crypto: arm/curve25519 - add arch-specific key generation function (2019-12-12 14:07:14 +0800)

----------------------------------------------------------------
Jason A. Donenfeld (1):
      crypto: arm/curve25519 - add arch-specific key generation function

 arch/arm/crypto/curve25519-glue.c | 7 +++++++
 1 file changed, 7 insertions(+)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
