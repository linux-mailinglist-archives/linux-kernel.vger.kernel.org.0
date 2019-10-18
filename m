Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CED56DBF6A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 10:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504872AbfJRIHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 04:07:18 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37426 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391374AbfJRIHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:07:17 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iLNHu-000226-7t; Fri, 18 Oct 2019 19:07:07 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Oct 2019 19:07:06 +1100
Date:   Fri, 18 Oct 2019 19:07:06 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     xuzaibo@huawei.com, davem@davemloft.net,
        forest.zhouchang@huawei.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        tanghui20@huawei.com
Subject: Re: [PATCH] crypto: hisilicon: Fix misuse of GENMASK macro
Message-ID: <20191018080706.GO25128@gondor.apana.org.au>
References: <1569835209-44326-2-git-send-email-xuzaibo@huawei.com>
 <20191015201330.25973-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015201330.25973-1-rikard.falkeborn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 10:13:30PM +0200, Rikard Falkeborn wrote:
> Arguments are supposed to be ordered high then low.
> 
> Fixes: c8b4b477079d ("crypto: hisilicon - add HiSilicon HPRE accelerator")
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
> Spotted when trying to introduce compile time checking that the order
> of the arguments to GENMASK are correct [0]. I have only compile tested
> the patch.
> 
> [0]: https://lore.kernel.org/lkml/20191009214502.637875-1-rikard.falkeborn@gmail.com/
> 
>  drivers/crypto/hisilicon/hpre/hpre_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
