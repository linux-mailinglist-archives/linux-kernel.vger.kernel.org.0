Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 560BF15BCF3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 11:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgBMKjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 05:39:01 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:44252 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbgBMKjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 05:39:01 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1j2BtX-0004dU-3m; Thu, 13 Feb 2020 18:38:55 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1j2BtT-0006xr-LO; Thu, 13 Feb 2020 18:38:51 +0800
Date:   Thu, 13 Feb 2020 18:38:51 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Matteo Croce <mcroce@redhat.com>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] crypto: arm64/poly1305: ignore build files
Message-ID: <20200213103851.d26zufgvivamulcg@gondor.apana.org.au>
References: <20200203233933.19577-1-mcroce@redhat.com>
 <20200213092355.i77luefms23jkud2@gondor.apana.org.au>
 <20200213103444.GA700076@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213103444.GA700076@zx2c4.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 11:34:44AM +0100, Jason A. Donenfeld wrote:
> On Thu, Feb 13, 2020 at 05:23:55PM +0800, Herbert Xu wrote:
> > On Tue, Feb 04, 2020 at 12:39:33AM +0100, Matteo Croce wrote:
> > > Add arch/arm64/crypto/poly1305-core.S to .gitignore
> > > as it's built from poly1305-core.S_shipped
> > > 
> > > Fixes: f569ca164751 ("crypto: arm64/poly1305 - incorporate OpenSSL/CRYPTOGAMS NEON implementation")
> > > Signed-off-by: Matteo Croce <mcroce@redhat.com>
> > > ---
> > >  arch/arm64/crypto/.gitignore | 1 +
> > >  1 file changed, 1 insertion(+)
> > 
> > Patch applied.  Thanks.
> 
> Probably makes sense for 5.6, no?

No this is too minor.  Only critical bug fixes (e.g., user
triggerable crashes) or build issues are routinely accepted.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
