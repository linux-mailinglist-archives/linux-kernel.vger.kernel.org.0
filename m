Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73B667785E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 13:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfG0LKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 07:10:15 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:47810 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfG0LKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 07:10:13 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hrKaW-0003Xy-V7; Sat, 27 Jul 2019 21:10:09 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hrKaT-0004ep-Ho; Sat, 27 Jul 2019 21:10:05 +1000
Date:   Sat, 27 Jul 2019 21:10:05 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Hook, Gary" <Gary.Hook@amd.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the crypto tree
Message-ID: <20190727111004.GA17611@gondor.apana.org.au>
References: <20190727150738.3640330a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727150738.3640330a@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 03:07:38PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   53a5d5192803 ("crypto: ccp - Log an error message when ccp-crypto fails to load")
> 
> is missing a Signed-off-by from its author.

Thanks Stephen.

Gary, I've backed this patch out.  Please resubmit with a sign-off.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
