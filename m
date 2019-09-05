Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1C7A98CC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 05:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbfIEDNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 23:13:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbfIEDM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 23:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WEjrnZDEQ7TEULc6lJk+4RAyKQtPI4nwd9rxNIbJ2jo=; b=cHAm9zd5r9eSCAYO8QFECjnW4
        0Dk5zbKC31VWKl/JUYWtv00YeI7QfLQiGXbxIlOorWOUanHJ2hMa99ADeWrROCZg9JNGf4ksACh6z
        zRF696B1RJbXdL8oQ4SrmxJLHvYh7hr5eMXUrNrBCErM17z5ixySKuhuBYvLvKP4OesVV8HxaURg/
        39Asm8TljlGNtzOvKofXbjApxD89NCGNtbNSOXb/H0XiE1KXes2DaxJu7DqLVaUYIIJGFNGXomtE4
        7iVN3beLW0y90LSzkhJPK9u4wuiEZ4d5jo6DycTHi6fvygzFTpvnXz+k0OwKvkt6Zozn17mu/LxUM
        F18Z+LMjA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5iCa-0004wA-Mu; Thu, 05 Sep 2019 03:12:52 +0000
Date:   Wed, 4 Sep 2019 20:12:52 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, mhocko@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Unsigned 'nr_pages' always larger than zero
Message-ID: <20190905031252.GN29434@bombadil.infradead.org>
References: <1567649871-60594-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567649871-60594-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 10:17:51AM +0800, zhong jiang wrote:
> With the help of unsigned_lesser_than_zero.cocci. Unsigned 'nr_pages'
> compare with zero. And __gup_longterm_locked pass an long local variant
> 'rc' to check_and_migrate_cma_pages. Hence it is nicer to change the
> parameter to long to fix the issue.

I think this patch is right, but I have concerns about this cocci grep.

The code says:

                if ((nr_pages > 0) && migrate_allow) {

There's nothing wrong with this (... other than the fact that nr_pages might
happen to be a negative errno).  nr_pages might be 0, and this would be
exactly the right test for that situation.  I suppose some might argue
that this should be != 0 instead of > 0, but it depends on the situation
which one would read better.

So please don't blindly make these changes; you're right this time.
