Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2BBB15BCE6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 11:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgBMKet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 05:34:49 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:57815 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgBMKet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 05:34:49 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c825c743;
        Thu, 13 Feb 2020 10:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=mail; bh=KtZ0R6I5rd1L3LwS/OgY7h9rrKQ=; b=gLm5/3y
        wGCk+Ly/53PgQmw5pBcSoBfnZgeVR6oqIALyYFiOyzjM0zxIFgA0pex1cjplFhJx
        5SSDItHjKW0CTs0HLn8J1AO77UU2SL8VeTuO1VfcXRgxqKZCKlV2VXpk0hQAEGFG
        ATmqyNd9iwiiVFBpTS4WMk3+N3VizgaD4033jGQfpjl8mnQLvYPA9nuYD4VHFzMD
        YNhE4fZFJzqtcuekbWj1bDC0IuKk8GNp/9sx3AnIPQs9NspKZTYOUlG0qQssGyAW
        mDRzCAVxH2XyeJgOzU4zTVY8ebKQRNr3vSTz29aFLp7oWw6eoGBjxTW9il3FCYvU
        7+ncwhCqsru/Q3w==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b6490da0 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Thu, 13 Feb 2020 10:32:48 +0000 (UTC)
Date:   Thu, 13 Feb 2020 11:34:44 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Matteo Croce <mcroce@redhat.com>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] crypto: arm64/poly1305: ignore build files
Message-ID: <20200213103444.GA700076@zx2c4.com>
References: <20200203233933.19577-1-mcroce@redhat.com>
 <20200213092355.i77luefms23jkud2@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200213092355.i77luefms23jkud2@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 05:23:55PM +0800, Herbert Xu wrote:
> On Tue, Feb 04, 2020 at 12:39:33AM +0100, Matteo Croce wrote:
> > Add arch/arm64/crypto/poly1305-core.S to .gitignore
> > as it's built from poly1305-core.S_shipped
> > 
> > Fixes: f569ca164751 ("crypto: arm64/poly1305 - incorporate OpenSSL/CRYPTOGAMS NEON implementation")
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
> > ---
> >  arch/arm64/crypto/.gitignore | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Patch applied.  Thanks.

Probably makes sense for 5.6, no?
