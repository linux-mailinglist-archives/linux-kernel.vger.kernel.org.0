Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24739160549
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2020 19:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgBPSXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 13:23:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:32808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgBPSXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 13:23:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 412C8206D6;
        Sun, 16 Feb 2020 18:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581877402;
        bh=BV3v8W+iI6KTFyzijgZYgxWjFHLlykiVDGhdEVQN/bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OHSUsh/dQwqfDoLwtvrCy35G3qdKBMZK3qZw7HvTAsdhIBFxkBtCXDEoJNFbHUzgw
         Bx16M1CV+ZdKxUrWUsScfaFAyXgi6ALrAdkf++kJPCAQQApYmxGR/HWJAhjNXfYgYx
         9qqCymJ7YEJ+42h3SxIJ352dJbrxJloGhJHdU+70=
Date:   Sun, 16 Feb 2020 19:23:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: always use batched entropy for
 get_random_u{32,64}
Message-ID: <20200216182319.GA54139@kroah.com>
References: <20200216161836.1976-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200216161836.1976-1-Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 05:18:36PM +0100, Jason A. Donenfeld wrote:
> It turns out that RDRAND is pretty slow. Comparing these two
> constructions:
> 
>   for (i = 0; i < CHACHA_BLOCK_SIZE; i += sizeof(ret))
>     arch_get_random_long(&ret);
> 
> and
> 
>   long buf[CHACHA_BLOCK_SIZE / sizeof(long)];
>   extract_crng((u8 *)buf);
> 
> it amortizes out to 352 cycles per long for the top one and 107 cycles
> per long for the bottom one, on Coffee Lake Refresh, Intel Core i9-9880H.
> 
> And importantly, the top one has the drawback of not benefiting from the
> real rng, whereas the bottom one has all the nice benefits of using our
> own chacha rng. As get_random_u{32,64} gets used in more places (perhaps
> beyond what it was originally intended for when it was introduced as
> get_random_{int,long} back in the md5 monstrosity era), it seems like it
> might be a good thing to strengthen its posture a tiny bit. Doing this
> should only be stronger and not any weaker because that pool is already
> initialized with a bunch of rdrand data (when available). This way, we
> get the benefits of the hardware rng as well as our own rng.
> 
> Another benefit of this is that we no longer hit pitfalls of the recent
> stream of AMD bugs in RDRAND. One often used code pattern for various
> things is:
> 
>   do {
>   	val = get_random_u32();
>   } while (hash_table_contains_key(val));
> 
> That recent AMD bug rendered that pattern useless, whereas we're really
> very certain that chacha20 output will give pretty distributed numbers,
> no matter what.
> 
> So, this simplification seems better both from a security perspective
> and from a performance perspective.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/char/random.c | 12 ------------
>  1 file changed, 12 deletions(-)

Looks good to me, thank for doing this:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

