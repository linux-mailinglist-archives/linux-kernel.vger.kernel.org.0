Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B532BA323C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 10:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfH3IZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 04:25:32 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59708 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfH3IZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 04:25:30 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i3cDE-0005fd-OT; Fri, 30 Aug 2019 18:24:53 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Aug 2019 18:24:47 +1000
Date:   Fri, 30 Aug 2019 18:24:47 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     leitao@debian.org, nayna@linux.ibm.com, pfsmorigo@gmail.com,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crypto: nx - remove unused variables
 'nx_driver_string' and 'nx_driver_version'
Message-ID: <20190830082447.GG8033@gondor.apana.org.au>
References: <20190822144649.19880-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822144649.19880-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 10:46:49PM +0800, YueHaibing wrote:
> drivers/crypto/nx/nx.h:12:19: warning:
>  nx_driver_string defined but not used [-Wunused-const-variable=]
> drivers/crypto/nx/nx.h:13:19: warning:
>  nx_driver_version defined but not used [-Wunused-const-variable=]
> 
> They are never used, so just remove it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/crypto/nx/nx.h | 3 ---
>  1 file changed, 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
