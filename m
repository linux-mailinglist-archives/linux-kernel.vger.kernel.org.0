Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39CF313D509
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 08:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgAPH3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 02:29:47 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:39988 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgAPH3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 02:29:47 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1irzb0-0005b6-Vv; Thu, 16 Jan 2020 15:29:39 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1irzaz-0000nz-Ah; Thu, 16 Jan 2020 15:29:37 +0800
Date:   Thu, 16 Jan 2020 15:29:37 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jiri Kosina <trivial@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH trivial] crypto: essiv - fix AEAD capitalization and
 preposition use in help text
Message-ID: <20200116072937.jtez3s73ztyzsrbz@gondor.apana.org.au>
References: <20200112165858.21214-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200112165858.21214-1-geert@linux-m68k.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2020 at 05:58:58PM +0100, Geert Uytterhoeven wrote:
> "AEAD" is capitalized everywhere else.
> Use "an" when followed by a written or spoken vowel.
> 
> Fixes: be1eb7f78aa8fbe3 ("crypto: essiv - create wrapper template for ESSIV generation")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  crypto/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
