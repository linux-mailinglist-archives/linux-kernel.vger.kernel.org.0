Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B56315E6B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 16:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfGCO36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 10:29:58 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:52306 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfGCO35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:29:57 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1higGi-0000ly-18; Wed, 03 Jul 2019 22:29:56 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1higGg-0000Yc-7T; Wed, 03 Jul 2019 22:29:54 +0800
Date:   Wed, 3 Jul 2019 22:29:54 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, rabinv@axis.com
Subject: Re: [PATCH] crypto: cryptd - Fix skcipher instance memory leak
Message-ID: <20190703142954.pxvp3hcvnff3cg3o@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702075325.27940-1-vincent.whitchurch@axis.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> cryptd_skcipher_free() fails to free the struct skcipher_instance
> allocated in cryptd_create_skcipher(), leading to a memory leak.  This
> is detected by kmemleak on bootup on ARM64 platforms:
> 
> unreferenced object 0xffff80003377b180 (size 1024):
>   comm "cryptomgr_probe", pid 822, jiffies 4294894830 (age 52.760s)
>   backtrace:
>     kmem_cache_alloc_trace+0x270/0x2d0
>     cryptd_create+0x990/0x124c
>     cryptomgr_probe+0x5c/0x1e8
>     kthread+0x258/0x318
>     ret_from_fork+0x10/0x1c
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> crypto/cryptd.c | 1 +
> 1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
