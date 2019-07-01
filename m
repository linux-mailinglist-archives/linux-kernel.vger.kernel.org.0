Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B680376A4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 16:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfFFO1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 10:27:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbfFFO1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:27:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1AEF30BC595;
        Thu,  6 Jun 2019 14:27:49 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E6F125F7D8;
        Thu,  6 Jun 2019 14:27:44 +0000 (UTC)
Date:   Thu, 6 Jun 2019 10:27:43 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     rcampbell@nvidia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/5] mm/hmm: Clean up some coding style and comments
Message-ID: <20190606142743.GA8053@redhat.com>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
 <20190506232942.12623-3-rcampbell@nvidia.com>
 <20190606141644.GA2876@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190606141644.GA2876@ziepe.ca>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 06 Jun 2019 14:27:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 11:16:44AM -0300, Jason Gunthorpe wrote:
> On Mon, May 06, 2019 at 04:29:39PM -0700, rcampbell@nvidia.com wrote:
> > From: Ralph Campbell <rcampbell@nvidia.com>
> > 
> > There are no functional changes, just some coding style clean ups and
> > minor comment changes.
> > 
> > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > Reviewed-by: J�r�me Glisse <jglisse@redhat.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Balbir Singh <bsingharora@gmail.com>
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Souptick Joarder <jrdr.linux@gmail.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> >  include/linux/hmm.h | 71 +++++++++++++++++++++++----------------------
> >  mm/hmm.c            | 51 ++++++++++++++++----------------
> >  2 files changed, 62 insertions(+), 60 deletions(-)
> 
> Applied to hmm.git, thanks

Can you hold off, i was already collecting patches and we will
be stepping on each other toe ... for instance i had

https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-5.3

But i have been working on more collection.

Cheers,
J�r�me
