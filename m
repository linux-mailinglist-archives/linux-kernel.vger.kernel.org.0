Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB9F011EDAD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 23:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfLMWXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 17:23:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:41604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfLMWXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 17:23:34 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C55E20706;
        Fri, 13 Dec 2019 22:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576275813;
        bh=4iChmOKy+iWyzBUqX73EkorUxBHm0c/M19HO10x0in0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i4KM7W9Nv9QULJGh6tsFLMg6kACWSO3TPSt+iFvi0Lmz60OcH9UvQYZkapZjopQ6L
         bOgaiNRrN7wdN5Mmbr2wp6ipHtOVbzipeY8UqU1PrQLF0EPQmZFQ4R45mFjBf38I8E
         uhU1UDTTCEr1/BijD37EO8cG4BCMHJkEZpIVroA0=
Date:   Fri, 13 Dec 2019 14:23:32 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <emamd001@umn.edu>
Subject: Re: [PATCH] mm/gup: Fix memory leak in __gup_benchmark_ioctl
Message-Id: <20191213142332.d7fafc243291eac302375c32@linux-foundation.org>
In-Reply-To: <9a692d27-4654-f1fc-d4c5-c6efba02c8a9@nvidia.com>
References: <20191211174653.4102-1-navid.emamdoost@gmail.com>
        <9a692d27-4654-f1fc-d4c5-c6efba02c8a9@nvidia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019 13:40:15 -0800 John Hubbard <jhubbard@nvidia.com> wrote:

> On 12/11/19 9:46 AM, Navid Emamdoost wrote:
> > In the implementation of __gup_benchmark_ioctl() the allocated pages
> > should be released before returning in case of an invalid cmd. Release
> > pages via kvfree().
> > 
> > Fixes: 714a3a1ebafe ("mm/gup_benchmark.c: add additional pinning methods")
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> >  mm/gup_benchmark.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
> > index 7dd602d7f8db..b160638f647e 100644
> > --- a/mm/gup_benchmark.c
> > +++ b/mm/gup_benchmark.c
> > @@ -63,6 +63,7 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
> >  					    NULL);
> >  			break;
> >  		default:
> > +			kvfree(pages);
> >  			return -1;
> >  		}
> >  
> 
> Hi,
> 
> The patch is correct, but I would like to second Ira's request for a ret value,
> and a "goto done" to use a single place to kvfree, if you don't mind. 
> 

Fair enough.

And let's make it return -EINVAL rather than -1, which appears to be
-EPERM.

--- a/mm/gup_benchmark.c~mm-gup-fix-memory-leak-in-__gup_benchmark_ioctl-fix
+++ a/mm/gup_benchmark.c
@@ -26,6 +26,7 @@ static int __gup_benchmark_ioctl(unsigne
 	unsigned long i, nr_pages, addr, next;
 	int nr;
 	struct page **pages;
+	int ret = 0;
 
 	if (gup->size > ULONG_MAX)
 		return -EINVAL;
@@ -64,7 +65,8 @@ static int __gup_benchmark_ioctl(unsigne
 			break;
 		default:
 			kvfree(pages);
-			return -1;
+			ret = -EINVAL;
+			goto out;
 		}
 
 		if (nr <= 0)
@@ -86,7 +88,8 @@ static int __gup_benchmark_ioctl(unsigne
 	gup->put_delta_usec = ktime_us_delta(end_time, start_time);
 
 	kvfree(pages);
-	return 0;
+out:
+	return ret;
 }
 
 static long gup_benchmark_ioctl(struct file *filep, unsigned int cmd,
_

