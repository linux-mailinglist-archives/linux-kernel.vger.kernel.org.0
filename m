Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2EA814523A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 11:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgAVKN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 05:13:28 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:39082 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAVKN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:13:28 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iuD0n-0000Tv-43; Wed, 22 Jan 2020 18:13:25 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iuD0m-00041X-7S; Wed, 22 Jan 2020 18:13:24 +0800
Date:   Wed, 22 Jan 2020 18:13:24 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-crypto@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v3] crypto, x86/sha: Eliminate casts on asm
 implementations
Message-ID: <20200122101324.zitzy7doyh3nlzuh@gondor.apana.org.au>
References: <202001141955.C4136E9C5@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202001141955.C4136E9C5@keescook>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 07:57:29PM -0800, Kees Cook wrote:
> In order to avoid CFI function prototype mismatches, this removes the
> casts on assembly implementations of sha1/256/512 accelerators. The
> safety checks from BUILD_BUG_ON() remain.
> 
> Additionally, this renames various arguments for clarity, as suggested
> by Eric Biggers.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v3: fix missed variable name change, now correctly allmodconfig build tested
> v2: https://lore.kernel.org/lkml/202001141825.8CD52D0@keescook
> v1: https://lore.kernel.org/lkml/20191122030620.GD32523@sol.localdomain/
> ---
>  arch/x86/crypto/sha1_avx2_x86_64_asm.S |  6 +--
>  arch/x86/crypto/sha1_ssse3_asm.S       | 14 ++++--
>  arch/x86/crypto/sha1_ssse3_glue.c      | 70 +++++++++++---------------
>  arch/x86/crypto/sha256-avx-asm.S       |  4 +-
>  arch/x86/crypto/sha256-avx2-asm.S      |  4 +-
>  arch/x86/crypto/sha256-ssse3-asm.S     |  6 ++-
>  arch/x86/crypto/sha256_ssse3_glue.c    | 34 ++++++-------
>  arch/x86/crypto/sha512-avx-asm.S       | 11 ++--
>  arch/x86/crypto/sha512-avx2-asm.S      | 11 ++--
>  arch/x86/crypto/sha512-ssse3-asm.S     | 13 +++--
>  arch/x86/crypto/sha512_ssse3_glue.c    | 31 ++++++------
>  11 files changed, 102 insertions(+), 102 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
