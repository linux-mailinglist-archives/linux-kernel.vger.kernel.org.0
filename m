Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB109D9BF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 01:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfHZXFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 19:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfHZXFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 19:05:17 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2C02206BA;
        Mon, 26 Aug 2019 23:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566860716;
        bh=cl70OECwhOCqI7sxkc/Ft+EL3YyE5brFJ+VFfmAluBE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sECy1IDonKrYQ2nLaj1eiMbxLkbkQ25Ax1DH8KDGu91ViEAU5zM+pMa7lSZY2HIAS
         oyHC5+L9IuinAqpcegYdcRykO4IfktmcVG510+/9LUwyoYqk791/6hOCdM6ZEHdnE8
         E2xpgPr+F7ymNwxz5XjrQqRNz8FzLgvzPhVZcTYM=
Date:   Mon, 26 Aug 2019 16:05:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Henry Burns <henryburns@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/z3fold.c: fix lock/unlock imbalance in
 z3fold_page_isolate
Message-Id: <20190826160515.446dabc587706fc80e5c6e6b@linux-foundation.org>
In-Reply-To: <20190826030634.GA4379@embeddedor>
References: <20190826030634.GA4379@embeddedor>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Aug 2019 22:06:34 -0500 "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> Fix lock/unlock imbalance by unlocking *zhdr* before return.
> 
> Addresses-Coverity-ID: 1452811 ("Missing unlock")
> Fixes: d776aaa9895e ("mm/z3fold.c: fix race between migration and destruction")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  mm/z3fold.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index e31cd9bd4ed5..75b7962439ff 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -1406,6 +1406,7 @@ static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
>  				 * should freak out.
>  				 */
>  				WARN(1, "Z3fold is experiencing kref problems\n");
> +				z3fold_page_unlock(zhdr);
>  				return false;
>  			}
>  			z3fold_page_unlock(zhdr);

Looks good, thanks.


This is a bit silly:

			if (..) {
				...
				z3fold_page_unlock(zhdr);
				return false;
			}
			z3fold_page_unlock(zhdr);
			return false;

but presumably the compiler will clean up after us.
