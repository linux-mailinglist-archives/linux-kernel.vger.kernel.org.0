Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDD59765B9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 14:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfGZM3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 08:29:47 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:46362 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfGZM3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:29:46 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hqzLs-0003d7-Q3; Fri, 26 Jul 2019 22:29:36 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hqzLr-00025O-J9; Fri, 26 Jul 2019 22:29:35 +1000
Date:   Fri, 26 Jul 2019 22:29:35 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     davem@davemloft.net, ofir.drang@arm.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] crypto: ccree: cleanups, fixes and TEE FIPS support
Message-ID: <20190726122935.GA8011@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702113922.24911-1-gilad@benyossef.com>
Organization: Core
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> Clean up unused ivgen support code and add support for notifiying
> Trusted Execution Enviornment of FIPS tests failures in FIPS mode.
> 
> Gilad Ben-Yossef (4):
>  crypto: ccree: drop legacy ivgen support
>  crypto: ccree: account for TEE not ready to report
>  crypto: fips: add FIPS test failure notification chain
>  crypto: ccree: notify TEE on FIPS tests errors
> 
> crypto/fips.c                         |  11 +
> crypto/testmgr.c                      |   4 +-
> drivers/crypto/ccree/Makefile         |   2 +-
> drivers/crypto/ccree/cc_aead.c        |  76 +------
> drivers/crypto/ccree/cc_aead.h        |   3 +-
> drivers/crypto/ccree/cc_driver.c      |  12 +-
> drivers/crypto/ccree/cc_driver.h      |  10 -
> drivers/crypto/ccree/cc_fips.c        |  31 ++-
> drivers/crypto/ccree/cc_ivgen.c       | 276 --------------------------
> drivers/crypto/ccree/cc_ivgen.h       |  55 -----
> drivers/crypto/ccree/cc_pm.c          |   2 -
> drivers/crypto/ccree/cc_request_mgr.c |  47 +----
> include/linux/fips.h                  |   7 +
> 13 files changed, 68 insertions(+), 468 deletions(-)
> delete mode 100644 drivers/crypto/ccree/cc_ivgen.c
> delete mode 100644 drivers/crypto/ccree/cc_ivgen.h

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
