Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE40DBF3D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 10:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437610AbfJRICb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 04:02:31 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37276 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729376AbfJRICb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:02:31 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iLNDN-0001qE-70; Fri, 18 Oct 2019 19:02:26 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Oct 2019 19:02:25 +1100
Date:   Fri, 18 Oct 2019 19:02:25 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH] crypto: jitter - add header to fix buildwarnings
Message-ID: <20191018080225.GB25128@gondor.apana.org.au>
References: <20191009091256.12896-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009091256.12896-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 10:12:56AM +0100, Ben Dooks wrote:
> Fix the following build warnings by adding a header for
> the definitions shared between jitterentropy.c and
> jitterentropy-kcapi.c. Fixes the following:
> 
> crypto/jitterentropy.c:445:5: warning: symbol 'jent_read_entropy' was not declared. Should it be static?
> crypto/jitterentropy.c:475:18: warning: symbol 'jent_entropy_collector_alloc' was not declared. Should it be static?
> crypto/jitterentropy.c:509:6: warning: symbol 'jent_entropy_collector_free' was not declared. Should it be static?
> crypto/jitterentropy.c:516:5: warning: symbol 'jent_entropy_init' was not declared. Should it be static?
> crypto/jitterentropy-kcapi.c:59:6: warning: symbol 'jent_zalloc' was not declared. Should it be static?
> crypto/jitterentropy-kcapi.c:64:6: warning: symbol 'jent_zfree' was not declared. Should it be static?
> crypto/jitterentropy-kcapi.c:69:5: warning: symbol 'jent_fips_enabled' was not declared. Should it be static?
> crypto/jitterentropy-kcapi.c:74:6: warning: symbol 'jent_panic' was not declared. Should it be static?
> crypto/jitterentropy-kcapi.c:79:6: warning: symbol 'jent_memcpy' was not declared. Should it be static?
> crypto/jitterentropy-kcapi.c:93:6: warning: symbol 'jent_get_nstime' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  crypto/jitterentropy-kcapi.c |  8 +-------
>  crypto/jitterentropy.c       |  7 +------
>  crypto/jitterentropy.h       | 17 +++++++++++++++++
>  3 files changed, 19 insertions(+), 13 deletions(-)
>  create mode 100644 crypto/jitterentropy.h

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
