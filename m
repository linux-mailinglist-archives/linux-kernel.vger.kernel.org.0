Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01B471E81E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 08:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfEOGGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 02:06:02 -0400
Received: from orcrist.hmeau.com ([5.180.42.13]:34972 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfEOGGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:06:01 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hQn37-0001Sz-Tb; Wed, 15 May 2019 14:05:57 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hQn32-0004ja-LG; Wed, 15 May 2019 14:05:52 +0800
Date:   Wed, 15 May 2019 14:05:52 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT] Crypto Fixes for 5.2
Message-ID: <20190515060552.ecfwhazt2fnthepg@gondor.apana.org.au>
References: <20180212031702.GA26153@gondor.apana.org.au>
 <20180428080517.haxgpvqrwgotakyo@gondor.apana.org.au>
 <20180622145403.6ltjip7che227fuo@gondor.apana.org.au>
 <20180829033353.agnzxra3jk2r2mzg@gondor.apana.org.au>
 <20181116063146.e7a3mep3ghnfltxe@gondor.apana.org.au>
 <20181207061409.xflg423nknleuddw@gondor.apana.org.au>
 <20190118104006.ye5amhxkgd4xrbmc@gondor.apana.org.au>
 <20190201054204.ehl7u7aaqmkdh5b6@gondor.apana.org.au>
 <20190215024738.fynl64d5u5htcy2l@gondor.apana.org.au>
 <20190312045818.bgpiuxogmaxyscdv@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312045818.bgpiuxogmaxyscdv@gondor.apana.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus: 

This push fixes a number of issues in the chelsio driver and the
caam driver.


Please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus


Atul Gupta (4):
      crypto: chelsio - Fix NULL pointer dereference
      crypto: chelsio - Fix softlockup with heavy I/O
      crypto: chelsio - count incomplete block in IV
      MAINTAINERS: Maintainer for Chelsio crypto driver

Herbert Xu (2):
      crypto: caam - fix DKP detection logic
      Revert "crypto: caam/jr - Remove extra memory barrier during job ring dequeue"

Iuliana Prodan (1):
      crypto: caam - fix caam_dump_sg that iterates through scatterlist

 MAINTAINERS                         |  2 +-
 drivers/crypto/caam/caamalg.c       |  9 +++++++--
 drivers/crypto/caam/caamalg_qi.c    |  7 +++++--
 drivers/crypto/caam/caamalg_qi2.c   |  8 +++++++-
 drivers/crypto/caam/error.c         |  2 +-
 drivers/crypto/caam/jr.c            |  2 +-
 drivers/crypto/caam/regs.h          |  8 --------
 drivers/crypto/chelsio/chcr_algo.c  | 17 +++++------------
 drivers/crypto/chelsio/chcr_core.c  |  4 ----
 drivers/crypto/chelsio/chcr_ipsec.c |  3 ++-
 10 files changed, 29 insertions(+), 33 deletions(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
