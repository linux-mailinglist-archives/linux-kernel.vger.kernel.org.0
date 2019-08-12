Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEA189E44
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 14:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfHLM2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 08:28:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39260 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbfHLM2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:28:16 -0400
Received: by mail-qk1-f196.google.com with SMTP id 125so3702921qkl.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F3NVoBe9n1v2ZfRa55FdnUViyntY9dM8fBRiLu0L+fw=;
        b=hj/Fuo5ytWHe0SJ+13jcDdQMsbU/i1ZIACgIViMzJiw64MJCvg0Xb2wHJG7iO+F4CY
         aU/8Q4e5EoRTDQDpyyngxGAd8VRdCivVvM9K4kJH8VkohD0SyifJp3mGzN0GcVbvBsA6
         4Y51i7Ejn6Y8PGCOwhEemjauQp1RbvuAk+XvQ3vNiR6Z8yE71AQmuSIriJA5+G1/cPmw
         b9Fve7MbxQYSmPLxPc8WFWQFK9ggMft0bP6KTFKqQIAdoHpT+phxWGWiOfnw0VACG5Ib
         rBDe3YqIH8M46+Mj9gTd05nIVBhQ30Y1/5SkXNdMnFNsQXrdNcqB8yDxa3rqTHlr6dLq
         iK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F3NVoBe9n1v2ZfRa55FdnUViyntY9dM8fBRiLu0L+fw=;
        b=d+m2C8Xs+hyH9uPl3OIPC5xVGNkYc/Aa7PbqgHzonFvGI3o1r5XcmZ/eIoezk7svyI
         OLYWAFXAO4uew3FPQ9l0NlaxKH1DTZZC2srMUKP2fBFxzUcNnodSxVpZvCIMZ2y/+02Z
         wu/3E6CdiodoW6AAQAsE80cW+otCZ2JwcWJqN2zSJwVcGO67iublzoZptQm4iSY2PjSe
         TKy2TZaZT5cqH2eu8fL+Omqq0yNq+IKHifYZId/NYEhElXJobbmZah8HIJVpbKfLWV6B
         f8+X6y+VG8Q8343Yk2NbGzzUGJgQIUeQZ/CkoFe/jE3RRJHgMPfwvvAdpLYKJmZIW3xH
         Z5dg==
X-Gm-Message-State: APjAAAXF5xwKQUz8qtCOR2lS73gU2sf4eO3jUhCCgKyqyCOVqA62T9j5
        m8X3xNko419bSgsEZTmCJY94Gw==
X-Google-Smtp-Source: APXvYqwODBrrpXeLg1uZt60+w4xuw/RA5y0XlK9HIDJS76yjPxmVou6ZmWwl4OVp2Tm+2EwyPKY3dw==
X-Received: by 2002:a05:620a:12d2:: with SMTP id e18mr29712440qkl.176.1565612895187;
        Mon, 12 Aug 2019 05:28:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z2sm9588656qtq.7.2019.08.12.05.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 05:28:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hx9Qs-00079D-9F; Mon, 12 Aug 2019 09:28:14 -0300
Date:   Mon, 12 Aug 2019 09:28:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 15/19] mm/gup: Introduce vaddr_pin_pages()
Message-ID: <20190812122814.GC24457@ziepe.ca>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-16-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809225833.6657-16-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 03:58:29PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The addition of FOLL_LONGTERM has taken on additional meaning for CMA
> pages.
> 
> In addition subsystems such as RDMA require new information to be passed
> to the GUP interface to track file owning information.  As such a simple
> FOLL_LONGTERM flag is no longer sufficient for these users to pin pages.
> 
> Introduce a new GUP like call which takes the newly introduced vaddr_pin
> information.  Failure to pass the vaddr_pin object back to a vaddr_put*
> call will result in a failure if pins were created on files during the
> pin operation.

Is this a 'vaddr' in the traditional sense, ie does it work with
something returned by valloc?

Maybe another name would be better?

I also wish GUP like functions took in a 'void __user *' instead of
the unsigned long to make this clear :\

Jason
