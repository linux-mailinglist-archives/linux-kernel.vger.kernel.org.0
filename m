Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0FD9A9224
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387968AbfIDTCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 15:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730410AbfIDTCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 15:02:01 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE7CD2087E;
        Wed,  4 Sep 2019 19:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567623720;
        bh=A0p265L38NV6UyAt6+h0NKJkV9Yhds5FJHvN1ygxV4c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pDxHacczS7aRbBpwyiXA4vrhf5y08lCIaa7YP/dIu1wq26LCRg6bclT5fKTTVLyGH
         1U3klZixQDuOyfP5k6u7kLvIMKM4+3SRc7wXpKnAnVKk8yB7IRbiJtdR3maDYRkAfA
         mu7Oteopa+BITB2kX1vIAZjqSCc0R63PbOkQ7VYE=
Date:   Wed, 4 Sep 2019 12:01:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     zhong jiang <zhongjiang@huawei.com>, mhocko@kernel.org,
        anshuman.khandual@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm: Unsigned 'nr_pages' always larger than zero
Message-Id: <20190904120159.d4026b573f419838d77e991d@linux-foundation.org>
In-Reply-To: <5505fa16-117e-8890-0f48-38555a61a036@suse.cz>
References: <1567592763-25282-1-git-send-email-zhongjiang@huawei.com>
        <5505fa16-117e-8890-0f48-38555a61a036@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019 13:24:58 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 9/4/19 12:26 PM, zhong jiang wrote:
> > With the help of unsigned_lesser_than_zero.cocci. Unsigned 'nr_pages"'
> > compare with zero. And __get_user_pages_locked will return an long value.
> > Hence, Convert the long to compare with zero is feasible.
> 
> It would be nicer if the parameter nr_pages was long again instead of unsigned
> long (note there are two variants of the function, so both should be changed).
> 
> > Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> 
> Fixes: 932f4a630a69 ("mm/gup: replace get_user_pages_longterm() with FOLL_LONGTERM")
> 
> (which changed long to unsigned long)
> 
> AFAICS... stable shouldn't be needed as the only "risk" is that we goto
> check_again even when we fail, which should be harmless.
> 

Really?  If nr_pages gets a value of -EFAULT from the
__get_user_pages_locked() call, check_and_migrate_cma_pages() will go
berzerk?

And does __get_user_pages_locked() correctly handle a -ve errno
returned by __get_user_pages()?  It's hard to see how...

