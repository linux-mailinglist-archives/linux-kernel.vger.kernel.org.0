Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8C513C6F5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 16:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgAOPIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 10:08:18 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:44770 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbgAOPIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:08:18 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1irkHH-0000I4-3S; Wed, 15 Jan 2020 23:08:15 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1irkHE-0005d1-JT; Wed, 15 Jan 2020 23:08:12 +0800
Date:   Wed, 15 Jan 2020 23:08:12 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 5.5
Message-ID: <20200115150812.mo2eycc53lbsgvue@gondor.apana.org.au>
References: <20190916084901.GA20338@gondor.apana.org.au>
 <20190923050515.GA6980@gondor.apana.org.au>
 <20191202062017.ge4rz72ki3vczhgb@gondor.apana.org.au>
 <20191214084749.jt5ekav5o5pd2dcp@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191214084749.jt5ekav5o5pd2dcp@gondor.apana.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

This push fixes a build problem for the hisilicon driver.

The following changes since commit 84faa307249b341f6ad8de3e1869d77a65e26669:

  crypto: arm/curve25519 - add arch-specific key generation function (2019-12-12 14:07:14 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus 

for you to fetch changes up to cb1eeb75cf3dd84ced81333967200583993dfd73:

  crypto: hisilicon/sec2 - Use atomics instead of __sync (2020-01-09 11:28:08 +0800)

----------------------------------------------------------------
Arnd Bergmann (1):
      crypto: hisilicon/sec2 - Use atomics instead of __sync

 drivers/crypto/hisilicon/sec2/sec.h        |  6 +++---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 12 ++++++------
 drivers/crypto/hisilicon/sec2/sec_main.c   | 14 ++++++++++++--
 3 files changed, 21 insertions(+), 11 deletions(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
