Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A96BC172DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 01:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbgB1Ax7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 19:53:59 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:55702 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbgB1Ax7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:53:59 -0500
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1j7TuX-0000P4-WD; Fri, 28 Feb 2020 11:53:51 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Feb 2020 11:53:49 +1100
Date:   Fri, 28 Feb 2020 11:53:49 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Colin King <colin.king@canonical.com>
Cc:     Zaibo Xu <xuzaibo@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon: remove redundant assignment of
 pointer ctx
Message-ID: <20200228005349.GE9506@gondor.apana.org.au>
References: <20200222142409.141057-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222142409.141057-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 02:24:09PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer ctx is being re-assigned with the same value as it
> was initialized with. The second assignment is redundant and
> can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/crypto/hisilicon/sec2/sec_crypto.c | 1 -
>  1 file changed, 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
