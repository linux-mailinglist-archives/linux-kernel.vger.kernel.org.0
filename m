Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A363A2C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 03:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfH3BhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 21:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfH3BhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 21:37:09 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2665821726;
        Fri, 30 Aug 2019 01:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567129028;
        bh=wblmtwAPChh3pCJc193Sn72+9+tyKF8aXZAv7ytdG80=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gH7sjdEq3ppqk1qjdFYzMatBtsJBLj0iAfB8MpFHaWARSglXLrGojpXQ/2dLwo4/b
         fHq54qBu5XfxNbY+3zndxiNkLPXH+umnmVwEJoB6ogmOSt9YQk6cB5Km9NrKnNBXBF
         mvduXpDEjDhSGvVQ4HyyJD/xPohoqaXalCeDGJOA=
Date:   Thu, 29 Aug 2019 18:37:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/z3fold.c: remove useless code in z3fold_page_isolate
Message-Id: <20190829183707.71f13473d1b034dd424f85d7@linux-foundation.org>
In-Reply-To: <20190829191312.GA20298@embeddedor>
References: <20190829191312.GA20298@embeddedor>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 14:13:12 -0500 "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> Remove duplicate and useless code.
> 
> ...
>
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -1400,15 +1400,13 @@ static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
>  			 * can call the release logic.
>  			 */
>  			if (unlikely(kref_put(&zhdr->refcount,
> -					      release_z3fold_page_locked))) {
> +					      release_z3fold_page_locked)))
>  				/*
>  				 * If we get here we have kref problems, so we
>  				 * should freak out.
>  				 */
>  				WARN(1, "Z3fold is experiencing kref problems\n");
> -				z3fold_page_unlock(zhdr);
> -				return false;
> -			}
> +
>  			z3fold_page_unlock(zhdr);
>  			return false;
>  		}

Thanks.

We prefer to retain the braces around a code block which is more than a
single line - it's easier on the eyes.

--- a/mm/z3fold.c~mm-z3foldc-remove-useless-code-in-z3fold_page_isolate-fix
+++ a/mm/z3fold.c
@@ -1400,13 +1400,13 @@ static bool z3fold_page_isolate(struct p
 			 * can call the release logic.
 			 */
 			if (unlikely(kref_put(&zhdr->refcount,
-					      release_z3fold_page_locked)))
+					      release_z3fold_page_locked))) {
 				/*
 				 * If we get here we have kref problems, so we
 				 * should freak out.
 				 */
 				WARN(1, "Z3fold is experiencing kref problems\n");
-
+			}
 			z3fold_page_unlock(zhdr);
 			return false;
 		}
_

