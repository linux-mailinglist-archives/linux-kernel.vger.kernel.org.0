Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EADD2144B89
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 06:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgAVF5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 00:57:46 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:48864 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgAVF5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 00:57:46 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iu91L-0002IE-9Z; Wed, 22 Jan 2020 13:57:43 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iu91K-0002uz-7T; Wed, 22 Jan 2020 13:57:42 +0800
Date:   Wed, 22 Jan 2020 13:57:42 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] crypto: sm2 - introduce OSCCA SM2 asymmetric cipher
 algorithm
Message-ID: <20200122055742.x3lruabxmv6elnuu@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121095718.52404-4-tianjia.zhang@linux.alibaba.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tianjia Zhang <tianjia.zhang@linux.alibaba.com> wrote:
> This new module implement the SM2 public key algorithm. It was
> published by State Encryption Management Bureau, China.
> List of specifications for SM2 elliptic curve public key cryptography:
> 
> * GM/T 0003.1-2012
> * GM/T 0003.2-2012
> * GM/T 0003.3-2012
> * GM/T 0003.4-2012
> * GM/T 0003.5-2012
> 
> IETF: https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02
> oscca: http://www.oscca.gov.cn/sca/xxgk/2010-12/17/content_1002386.shtml
> scctc: http://www.gmbz.org.cn/main/bzlb.html
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
> crypto/Kconfig         |   17 +
> crypto/Makefile        |   10 +
> crypto/sm2.c           | 1073 ++++++++++++++++++++++++++++++++++++++++
> crypto/sm2privkey.asn1 |    5 +
> crypto/sm2pubkey.asn1  |    3 +
> 5 files changed, 1108 insertions(+)
> create mode 100644 crypto/sm2.c
> create mode 100644 crypto/sm2privkey.asn1
> create mode 100644 crypto/sm2pubkey.asn1

We don't add algorithms unless they have a kernel user.  Who is
going to use this within the kernel?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
