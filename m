Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4B6106E43
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 12:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbfKVLFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 06:05:45 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:53590 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731735AbfKVLFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:05:37 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iY6kj-0004hU-NU; Fri, 22 Nov 2019 19:05:29 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iY6kj-0002h0-Iw; Fri, 22 Nov 2019 19:05:29 +0800
Date:   Fri, 22 Nov 2019 19:05:29 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3] crypto: arm64/sha: fix function types
Message-ID: <20191122110529.um7wyexxlmp5l6ac@gondor.apana.org.au>
References: <20191112223046.176097-1-samitolvanen@google.com>
 <20191119201353.2589-1-samitolvanen@google.com>
 <20191122110446.wjuyo5b5i3ebqbsd@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122110446.wjuyo5b5i3ebqbsd@gondor.apana.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 07:04:46PM +0800, Herbert Xu wrote:
> On Tue, Nov 19, 2019 at 12:13:53PM -0800, Sami Tolvanen wrote:
> > Instead of casting pointers to callback functions, add C wrappers
> > to avoid type mismatch failures with Control-Flow Integrity (CFI)
> > checking.
> > 
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> > Changes in v3:
> >   - Removed unnecessary inline attributes.
> > 
> > Changes in v2:
> >   - Added wrapper functions instead of changing parameter types
> >     for the assembly functions.
> > 
> > ---
> >  arch/arm64/crypto/sha1-ce-glue.c   | 17 +++++++++------
> >  arch/arm64/crypto/sha2-ce-glue.c   | 34 ++++++++++++++++++------------
> >  arch/arm64/crypto/sha256-glue.c    | 32 +++++++++++++++++-----------
> >  arch/arm64/crypto/sha512-ce-glue.c | 26 ++++++++++++-----------
> >  arch/arm64/crypto/sha512-glue.c    | 15 ++++++++-----
> >  5 files changed, 76 insertions(+), 48 deletions(-)
> 
> Patch applied.  Thanks.

Scratch that.  This patch is still in the queue.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
