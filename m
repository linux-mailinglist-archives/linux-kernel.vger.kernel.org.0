Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED14D7EBB6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 06:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbfHBE4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 00:56:04 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48706 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbfHBE4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 00:56:04 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1htPbi-0006KJ-QV; Fri, 02 Aug 2019 14:55:58 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1htPbi-0004kk-CJ; Fri, 02 Aug 2019 14:55:58 +1000
Date:   Fri, 2 Aug 2019 14:55:58 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Matt Mackall <mpm@selenic.com>, linux-crypto@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: timeriomem - add include guard to timeriomem-rng.h
Message-ID: <20190802045558.GI18077@gondor.apana.org.au>
References: <20190728153236.9937-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728153236.9937-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 12:32:36AM +0900, Masahiro Yamada wrote:
> Add a header include guard just in case.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  include/linux/timeriomem-rng.h | 5 +++++
>  1 file changed, 5 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
