Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 585E01529FF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 12:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgBELfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 06:35:31 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43053 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgBELfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 06:35:30 -0500
Received: by mail-lf1-f67.google.com with SMTP id 9so1223814lfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 03:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9dzJMqCXyJ0/sQ9WqS79itnSpMjlI4okwKhRKzVm4NM=;
        b=Cw/B6gNv6WrKuynnb0hGrn8XHxmwFGHBK6Kx3ISr6g8541JII8R/dNAUM8FBm3EG/z
         7mldHZr7bI2tp5pBfvfOfywWE8+h25kWovFkuNAA2Cj1Nuq4GHdG+S1n6nGJL+Qkvl7u
         DHVez+FLWMPQTo18ui7XxFbIAVT2/XZW7rBMXmKANw7Z3vjhI+/AgNja35tcKI2QrmWC
         iB0aW7cfR8lhqyI5gnu4EX1AdRGts8kF7neLmR0wRRiDXDyyZo4cXG1dDMjDe7evtrBV
         2VevE1g/382CgqcWrvzbCGiEIdnuWbHFIW8EwV4GVppGEzPCncLDF7f4SZMsf2BMC46d
         Gxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9dzJMqCXyJ0/sQ9WqS79itnSpMjlI4okwKhRKzVm4NM=;
        b=STb+mS7O4wZF+uVtT+cYy26MILluyJ7S3HXvAYrtVkp+WMjiJ93vwXpY3DSTpaRwSd
         AoNyIABhltQRplmW1ffMRkaISqnIRYnadNnEwY1JvGBFZ79bT7hU0uEYPbkG0qomj6cw
         lAO+WPFhVA7folussiL33SePRSU68xAAGKNfa1FcLokD8bUkhTXHAyK4eLGJ7yvYeAlD
         MPOvxgkUmFXPJ5NQ9EkIXeMmih1FVX1LhALgRE3114PjeBmWnW6aGWXGvG3IF4XmL86j
         OOX4hBH3g5hv64czOBkBoF15fjkwuLVM6VEm0NjS0f2AGfRsdpO871H2s5j1IpPf0G+Y
         qTCg==
X-Gm-Message-State: APjAAAW2ch1aVWsst8gquBDYuiJ8CG4CyJ+zCzHxdktexvyirzz7vG/L
        2F9TPVNdUhpxM94VmPdENzG4Vg==
X-Google-Smtp-Source: APXvYqy9hnTW8jGEcTDyskMINKlFV9FjmuWaaZRQe2WXLP2287ba30lwKa4xY42Duoj0vvlh1UVC8g==
X-Received: by 2002:a19:6b11:: with SMTP id d17mr17471991lfa.168.1580902528148;
        Wed, 05 Feb 2020 03:35:28 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f11sm14259401lfa.9.2020.02.05.03.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 03:35:27 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 96D43100AF6; Wed,  5 Feb 2020 14:35:41 +0300 (+03)
Date:   Wed, 5 Feb 2020 14:35:41 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 07/12] mm/gup: track FOLL_PIN pages
Message-ID: <20200205113541.mi4kys5erldwxiog@box>
References: <20200204234117.2974687-1-jhubbard@nvidia.com>
 <20200204234117.2974687-8-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200204234117.2974687-8-jhubbard@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 03:41:12PM -0800, John Hubbard wrote:
> Add tracking of pages that were pinned via FOLL_PIN. This tracking is
> implemented via overloading of page->_refcount: pins are added by
> adding GUP_PIN_COUNTING_BIAS (1024) to the refcount. This provides a
> fuzzy indication of pinning, and it can have false positives (and that's
> OK). Please see the pre-existing
> Documentation/core-api/pin_user_pages.rst for details.
> 
> As mentioned in pin_user_pages.rst, callers who effectively set FOLL_PIN
> (typically via pin_user_pages*()) are required to ultimately free such
> pages via unpin_user_page().
> 
> Please also note the limitation, discussed in pin_user_pages.rst under
> the "TODO: for 1GB and larger huge pages" section. (That limitation will
> be removed in a following patch.)
> 
> The effect of a FOLL_PIN flag is similar to that of FOLL_GET, and may be
> thought of as "FOLL_GET for DIO and/or RDMA use".
> 
> Pages that have been pinned via FOLL_PIN are identifiable via a
> new function call:
> 
>    bool page_maybe_dma_pinned(struct page *page);
> 
> What to do in response to encountering such a page, is left to later
> patchsets. There is discussion about this in [1], [2], [3], and [4].
> 
> This also changes a BUG_ON(), to a WARN_ON(), in follow_page_mask().
> 
> [1] Some slow progress on get_user_pages() (Apr 2, 2019):
>     https://lwn.net/Articles/784574/
> [2] DMA and get_user_pages() (LPC: Dec 12, 2018):
>     https://lwn.net/Articles/774411/
> [3] The trouble with get_user_pages() (Apr 30, 2018):
>     https://lwn.net/Articles/753027/
> [4] LWN kernel index: get_user_pages():
>     https://lwn.net/Kernel/Index/#Memory_management-get_user_pages
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Suggested-by: Jan Kara <jack@suse.cz>
> Suggested-by: J�r�me Glisse <jglisse@redhat.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
