Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F93D17B40A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 02:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCFBw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 20:52:58 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:46192 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCFBw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 20:52:58 -0500
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jA2AF-0005ws-Lf; Fri, 06 Mar 2020 12:52:36 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Mar 2020 12:52:35 +1100
Date:   Fri, 6 Mar 2020 12:52:35 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stefan Agner <stefan@agner.ch>
Cc:     davem@davemloft.net, linux@armlinux.org.uk, manojgupta@google.com,
        jiancai@google.com, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] crypto: arm/ghash-ce - define fpu before fpu registers
 are referenced
Message-ID: <20200306015235.GO30653@gondor.apana.org.au>
References: <c41cc67321d0b366e356440e6dbc9eceb1babfe4.1583105749.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c41cc67321d0b366e356440e6dbc9eceb1babfe4.1583105749.git.stefan@agner.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 12:37:14AM +0100, Stefan Agner wrote:
> Building ARMv7 with Clang's integrated assembler leads to errors such
> as:
> arch/arm/crypto/ghash-ce-core.S:34:11: error: register name expected
>  t3l .req d16
>           ^
> 
> Since no FPU has selected yet Clang considers d16 not a valid register.
> Moving the FPU directive on-top allows Clang to parse the registers and
> allows to successfully build this file with Clang's integrated assembler.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/crypto/ghash-ce-core.S | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
