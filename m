Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB69CBF9B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 17:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390042AbfJDPoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 11:44:54 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42614 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389669AbfJDPoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:44:54 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iGPkl-0001RR-QK; Sat, 05 Oct 2019 01:44:24 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2019 01:44:20 +1000
Date:   Sat, 5 Oct 2019 01:44:20 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Mao Wenan <maowenan@huawei.com>,
        Hao Fang <fanghao11@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] [v2] crypto: hisilicon - allow compile-testing on x86
Message-ID: <20191004154420.GW5148@gondor.apana.org.au>
References: <20190919140650.1289963-2-arnd@arndb.de>
 <20190919140917.1290556-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919140917.1290556-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 04:09:06PM +0200, Arnd Bergmann wrote:
> To avoid missing arm64 specific warnings that get introduced
> in this driver, allow compile-testing on all 64-bit architectures.
> 
> The only actual arm64 specific code in this driver is an open-
> coded 128 bit MMIO write. On non-arm64 the same can be done
> using memcpy_toio. What I also noticed is that the mmio store
> (either one) is not endian-safe, this will only work on little-
> endian configurations, so I also add a Kconfig dependency on
> that, regardless of the architecture.
> Finally, a depenndecy on CONFIG_64BIT is needed because of the
> writeq().
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: actually add !CPU_BIG_ENDIAN dependency as described in the
> changelog
> ---
>  drivers/crypto/hisilicon/Kconfig | 9 ++++++---
>  drivers/crypto/hisilicon/qm.c    | 6 ++++++
>  2 files changed, 12 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
