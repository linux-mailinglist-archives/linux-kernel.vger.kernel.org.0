Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFD0D2A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 14:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387695AbfJJM6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 08:58:17 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37674 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733300AbfJJM6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:58:16 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iIY1C-0001zY-Hq; Thu, 10 Oct 2019 23:58:11 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 10 Oct 2019 23:58:06 +1100
Date:   Thu, 10 Oct 2019 23:58:06 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: user - fix memory leak in crypto_report
Message-ID: <20191010125806.GI31566@gondor.apana.org.au>
References: <20191004192923.17491-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004192923.17491-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 02:29:16PM -0500, Navid Emamdoost wrote:
> In crypto_report, a new skb is created via nlmsg_new(). This skb should
> be released if crypto_report_alg() fails.
> 
> Fixes: a38f7907b926 ("crypto: Add userspace configuration API")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  crypto/crypto_user_base.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
