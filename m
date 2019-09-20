Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41D88B9022
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 15:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfITNCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 09:02:16 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34604 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbfITNCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 09:02:16 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iBIWN-0007ow-V7; Fri, 20 Sep 2019 23:00:25 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Sep 2019 23:00:21 +1000
Date:   Fri, 20 Sep 2019 23:00:21 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     wangzhou1@hisilicon.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon - Fix return value check in
 hisi_zip_acompress()
Message-ID: <20190920130021.GD23242@gondor.apana.org.au>
References: <23be2eb5-8256-0c19-aef9-994974d11c9d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23be2eb5-8256-0c19-aef9-994974d11c9d@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 02:38:25PM +0800, Yunfeng Ye wrote:
> The return valude of add_comp_head() is int, but @head_size is size_t,
> which is a unsigned type.
> 
> 	size_t head_size;
> 	...
> 	if (head_size < 0)  // it will never work
> 		return -ENOMEM
> 
> Modify the type of @head_size to int, then change the type to size_t
> when invoke hisi_zip_create_req() as a parameter.
> 
> Fixes: 62c455ca853e ("crypto: hisilicon - add HiSilicon ZIP accelerator support")
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
>  drivers/crypto/hisilicon/zip/zip_crypto.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
