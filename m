Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96B80B5ED6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 10:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbfIRIPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 04:15:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:36046 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727569AbfIRIPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:15:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8004EAF80;
        Wed, 18 Sep 2019 08:14:58 +0000 (UTC)
Date:   Wed, 18 Sep 2019 10:14:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] memalloc_noio: update the comment to make it cleaner
Message-ID: <20190918081431.GD12770@dhcp22.suse.cz>
References: <20190917232820.23504-1-xiubli@redhat.com>
 <20190918072542.GC12770@dhcp22.suse.cz>
 <315246db-ec28-f5e0-e9b3-eba0cb60b796@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315246db-ec28-f5e0-e9b3-eba0cb60b796@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-09-19 16:02:52, Xiubo Li wrote:
> On 2019/9/18 15:25, Michal Hocko wrote:
> > On Wed 18-09-19 04:58:20, xiubli@redhat.com wrote:
> > > From: Xiubo Li <xiubli@redhat.com>
> > > 
> > > The GFP_NOIO means all further allocations will implicitly drop
> > > both __GFP_IO and __GFP_FS flags and so they are safe for both the
> > > IO critical section and the the critical section from the allocation
> > > recursion point of view. Not only the __GFP_IO, which a bit confusing
> > > when reading the code or using the save/restore pair.
> > Historically GFP_NOIO has always implied GFP_NOFS as well. I can imagine
> > that this might come as an surprise for somebody not familiar with the
> > code though.
> 
> Yeah, it true.
> 
> >   I am wondering whether your update of the documentation
> > would be better off at __GFP_FS, __GFP_IO resp. GFP_NOFS, GFP_NOIO level.
> > This interface is simply a way to set a scoped NO{IO,FS} context.
> 
> The "Documentation/core-api/gfp_mask-from-fs-io.rst" is already very detail
> about them all.
> 
> This fixing just means to make sure that it won't surprise someone who is
> having a quickly through some code and not familiar much about the detail.
> It may make not much sense ?

Ohh, I do not think this would be senseless. I just think that the NOIO
implying NOFS as well should be described at the level where they are
documented rather than the api you have chosen.
-- 
Michal Hocko
SUSE Labs
