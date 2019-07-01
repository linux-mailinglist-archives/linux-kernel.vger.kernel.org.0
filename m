Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C07012EEF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 15:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfECNZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 09:25:34 -0400
Received: from [5.180.42.13] ([5.180.42.13]:38092 "EHLO deadmen.hmeau.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfECNZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:25:33 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hMRPb-0005pD-0A; Fri, 03 May 2019 14:11:11 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hMRPa-0003EY-SN; Fri, 03 May 2019 14:11:10 +0800
Date:   Fri, 3 May 2019 14:11:10 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     gilad@benyossef.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH v2 -next] crypto: ccree - remove set but not used
 variable 'du_size'
Message-ID: <20190503061110.sknqnrr3gsqiynnc@gondor.apana.org.au>
References: <20190426151821.36944-1-yuehaibing@huawei.com>
 <20190428082827.38184-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428082827.38184-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 04:28:27PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/crypto/ccree/cc_cipher.c: In function cc_setup_key_desc:
> drivers/crypto/ccree/cc_cipher.c:645:15: warning: variable du_size set but not used [-Wunused-but-set-variable]
> 
> It is never used since introduction in
> commit dd8486c75085 ("crypto: ccree - move key load desc. before flow desc.")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/crypto/ccree/cc_cipher.c | 8 --------
>  1 file changed, 8 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
