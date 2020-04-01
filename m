Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 215C219AD04
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 15:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbgDANms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 09:42:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45588 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732370AbgDANms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=phd5kLezoWzhv+zq6NfHJxhtn1HcBOvVhCX2VSrRkwI=; b=kwi78sSEhcSExLqgEM42sBDLP2
        pymfreP9aKaw+oPmxQyAOGWC55oHYud4NULSY/XurHbnuAp8qqAlk7lvIUxQKGdF30AmrIKwnhlc3
        OLHaY05QFmREqtXPAiOcJE+URAvKhhoRVREtM58NP8tF7flo4NioCtJiCsjSVAZ8mCIBRPlLdKxJn
        lAXwH06dgYnsGmeWHUOGRD4rjDVv2e2Ap9WCwVQfJHRwOO/ABMi23/05faNVhZCatw4g1NYu1DHqN
        575/s7NZ4WC2DHxKJs4MrJkCfPWwZQuAgXli0l5Bo0fRDYQjvLgK2izGf9QbGz/Iu1lb4bpfcdm+h
        5oOpQP3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJddd-0004vK-Uh; Wed, 01 Apr 2020 13:42:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2496C3025C3;
        Wed,  1 Apr 2020 15:42:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0876B29D8616E; Wed,  1 Apr 2020 15:42:35 +0200 (CEST)
Date:   Wed, 1 Apr 2020 15:42:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3 06/10] mmap locking API: convert nested write lock
 sites
Message-ID: <20200401134234.GR20696@hirez.programming.kicks-ass.net>
References: <20200327225102.25061-1-walken@google.com>
 <20200327225102.25061-7-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327225102.25061-7-walken@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 03:50:58PM -0700, Michel Lespinasse wrote:

> @@ -26,6 +31,12 @@ static inline void mmap_write_unlock(struct mm_struct *mm)
>  	up_write(&mm->mmap_sem);
>  }
>  
> +/* Pairs with mmap_write_lock_nested() */
> +static inline void mmap_write_unlock_nested(struct mm_struct *mm)
> +{
> +	up_write(&mm->mmap_sem);
> +}
> +
>  static inline void mmap_downgrade_write_lock(struct mm_struct *mm)
>  {
>  	downgrade_write(&mm->mmap_sem);

Why does unlock_nested() make sense ?
