Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D597EBD8E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 07:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbfKAGHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 02:07:11 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37488 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbfKAGHL (ORCPT <rfc822;linux-kernel@vger.kernel.orG>);
        Fri, 1 Nov 2019 02:07:11 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iQQ5O-0001qg-VP; Fri, 01 Nov 2019 14:07:03 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iQQ5G-0004oZ-Jx; Fri, 01 Nov 2019 14:06:54 +0800
Date:   Fri, 1 Nov 2019 14:06:54 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     davem@davemloft.net, catalin.marinas@arm.com, will@kernel.org,
        ard.biesheuvel@linaro.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hushiyuan@huawei.com,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Subject: Re: [PATCH v3] crypto: arm64/aes-neonbs - add return value of
 skcipher_walk_done() in __xts_crypt()
Message-ID: <20191101060654.w3jigumlcjep26mu@gondor.apana.org.au>
References: <aaf0f585-3a06-8af1-e2f1-ab301e560d49@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaf0f585-3a06-8af1-e2f1-ab301e560d49@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 04:11:18PM +0800, Yunfeng Ye wrote:
> A warning is found by the static code analysis tool:
>   "Identical condition 'err', second condition is always false"
> 
> Fix this by adding return value of skcipher_walk_done().
> 
> Fixes: 67cfa5d3b721 ("crypto: arm64/aes-neonbs - implement ciphertext stealing for XTS")
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v2 -> v3:
>  - add "Acked-by:"
> 
> v1 -> v2:
>  - update the subject and comment
>  - add return value of skcipher_walk_done()
> 
>  arch/arm64/crypto/aes-neonbs-glue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
