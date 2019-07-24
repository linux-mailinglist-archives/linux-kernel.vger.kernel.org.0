Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCBB732CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 17:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbfGXPdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 11:33:10 -0400
Received: from verein.lst.de ([213.95.11.211]:51929 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387619AbfGXPdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:33:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E22EC68B20; Wed, 24 Jul 2019 17:33:05 +0200 (CEST)
Date:   Wed, 24 Jul 2019 17:33:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH] mm/hmm: replace hmm_update with mmu_notifier_range
Message-ID: <20190724153305.GA10681@lst.de>
References: <20190723210506.25127-1-rcampbell@nvidia.com> <20190724070553.GA2523@lst.de> <20190724152858.GB28493@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724152858.GB28493@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 12:28:58PM -0300, Jason Gunthorpe wrote:
> Humm. Actually having looked this some more, I wonder if this is a
> problem:

What a mess.

Question: do we even care for the non-blocking events?  The only place
where mmu_notifier_invalidate_range_start_nonblock is called is the oom
killer, which means the process is about to die and the pagetable will
get torn down ASAP.  Should we just skip them unconditionally?  nouveau
already does so, but amdgpu currently tries to handle the non-blocking
notifications.
