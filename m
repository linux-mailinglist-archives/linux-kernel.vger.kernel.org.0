Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24762150696
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 14:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgBCNJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 08:09:31 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34985 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgBCNJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:09:31 -0500
Received: by mail-lf1-f66.google.com with SMTP id z18so9675838lfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 05:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qX9+IdrLD31YQlGzgAks4lbqLbuGK1+4/0ILCkggpL4=;
        b=ezSYe3ZEhGKKa6bl/nq2SThBohBllo4QdKKCbOJNjEpL5bZ3OMGJrYPiQDo/g5DnMy
         /C4WdkFAJ+X6GNj0G7Sfa+VSkus4CUEPWCOmpJ5mjgOWvntD0g+lgLs3+YQxcrHe5yJ1
         A41twJP8CuBuCbro1S0ZJk27UeL4yhpFC6UrHrDv6Rf8feqyy7k+4hpH0+FkNQsVOpuQ
         IWElYn3AaF9E6WYT70uca9rL0T4MxbIeowGjIk0sLseZ1TCZgrvpXhwVVAf2b1ZXs8aL
         zSBhdupTvbIPfbWZu/xNG5BEhE8NafO7fKlpSJiG8LuWsIZlDEcNRUyOPrb2EhH3fyVg
         K25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qX9+IdrLD31YQlGzgAks4lbqLbuGK1+4/0ILCkggpL4=;
        b=DyqDPlIqf4vknqmUQv8xOelj9Et7dXBsSMZoji52eEgCVodRuktiRvx9IOp+/IuKim
         6cgl5xx8vqqkWYE/Bl0qHtNyoedy84bJqpU9fyYEbAla4nwNrHaavxd3f4rss4wkstlK
         OQ98UdDIg1WtZOnAeS2elVStGZRkd+i126v+zizSBiOF2bzKWj7/QpPcG2+kNV1Xs+n5
         qpOw7+D6NO3Rj0J/nYDDKdQssG8rpCYz7GzkeU/qhJ9AM+cJQ2jJHg5Hi1uw8Q2ZiMrK
         jbzGrZi85NiCWrDFUzmulaSeCqsBXexALLSDXJtpD5MCjuO4RblPUzWAVZ4kNGxJUn0h
         e0wQ==
X-Gm-Message-State: APjAAAVmGI/+L9zyaIf8etQW4+V+fFIUgN+LULC/4Z2HKzo30Tszvut2
        RdpwwNVyDjOKji4e84vsNnuX4A==
X-Google-Smtp-Source: APXvYqxh3OZBPWowc6Fe84mkvkj5F/0u6eAEcPtl0SfxU4CoqAtQMEg1CcaKCPhc+kDjgLQ+RiLKhg==
X-Received: by 2002:a19:740a:: with SMTP id v10mr11746781lfe.65.1580735368851;
        Mon, 03 Feb 2020 05:09:28 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e5sm3662660lfn.66.2020.02.03.05.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 05:09:27 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 331DB100DC8; Mon,  3 Feb 2020 16:09:40 +0300 (+03)
Date:   Mon, 3 Feb 2020 16:09:40 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>, Jesse Barnes <jsbarnes@google.com>
Subject: Re: [PATCH v2] mm: Add MREMAP_DONTUNMAP to mremap().
Message-ID: <20200203130940.enfvdsbn42hhoaki@box>
References: <20200123014627.71720-1-bgeffon@google.com>
 <20200124190625.257659-1-bgeffon@google.com>
 <20200126220650.i4lwljpvohpgvsi2@box>
 <CADyq12xCK_3MhGi88Am5P6DVZvrW8vqtyJMHO0zjNhvhYegm1w@mail.gmail.com>
 <20200129104655.egvpavc2tzozlbqe@box>
 <CADyq12xgnVByYOkL=GcszYYKzDpg254QEOFoW8=e1y=bmOCcFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12xgnVByYOkL=GcszYYKzDpg254QEOFoW8=e1y=bmOCcFQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 02, 2020 at 05:17:53AM +0100, Brian Geffon wrote:
> On Wed, Jan 29, 2020 at 11:46 AM Kirill A. Shutemov
> <kirill@shutemov.name> wrote:
> > Any better options for the flag name? (I have none)
> 
> The other option is that it's broken up into two new flags the first
> MREMAP_MUSTMOVE which can be used regardless of whether or not you're
> leaving the original mapping mapped. This would do exactly what it
> describes: move the mapping to a new address with or without
> MREMAP_FIXED, this keeps consistency with MAYMOVE.
> 
> The second flag would be the new MREMAP_DONTUNMAP flag which requires
> MREMAP_MUSTMOVE, again with or without MREMAP_FIXED.
> 
> What are your thoughts on this?

Sounds reasonable.

MREMAP_DONTUNMAP doesn't really convey that you move pages to the new
mapping, but leave empty mapping behind. But I guess there's only so much
you can encode into the name. (Patch to the man page should do the rest)

-- 
 Kirill A. Shutemov
