Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA396143FDC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 15:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgAUOnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 09:43:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25191 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727817AbgAUOnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579617803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P/kFNLOn149gl4f8L/s6aC62LAQxTpZ4AIKpdDtErUw=;
        b=TbHhKA7MJc8CkYJoq0PwYm0HX2Pe2cBHjIJza7T7J0BG9mTZr6s1BNqFgsmzut5HXGMagt
        8Yg3BhIv2S5gy88U7pHeI9uHmnSwe04Qn5hWEUu8jMOTsdFaAJLcX2BhKg/op6Dqi4rPvh
        cmADOeVZF4D4nz1M9H/qN6SLyfW2Nng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-nMbHgjLMPE6MiAMlKZu2_Q-1; Tue, 21 Jan 2020 09:43:21 -0500
X-MC-Unique: nMbHgjLMPE6MiAMlKZu2_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA0168018AE;
        Tue, 21 Jan 2020 14:43:16 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A0EC8BE1B;
        Tue, 21 Jan 2020 14:43:11 +0000 (UTC)
Date:   Tue, 21 Jan 2020 09:43:10 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, bob.liu@oracle.com, axboe@kernel.dk,
        agk@redhat.com, dm-devel@redhat.com, song@kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, darrick.wong@oracle.com,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com
Subject: Re: [PATCH v4 6/7] dm: Directly disable max_allocate_sectors for now
Message-ID: <20200121144310.GA10055@redhat.com>
References: <157960325642.108120.13626623438131044304.stgit@localhost.localdomain>
 <157960337238.108120.18048939587162465175.stgit@localhost.localdomain>
 <20200121122458.GA9365@redhat.com>
 <f7e0fb38-a894-da33-c46b-e192ed907ee0@virtuozzo.com>
 <619a7a14-44e6-eca7-c1ea-3f04abeee53d@virtuozzo.com>
 <20200121134840.GA9944@redhat.com>
 <a19d5957-9aaa-b518-5855-e5fa2b5d3b22@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a19d5957-9aaa-b518-5855-e5fa2b5d3b22@virtuozzo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21 2020 at  9:20am -0500,
Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> On 21.01.2020 16:48, Mike Snitzer wrote:
> > On Tue, Jan 21 2020 at  8:33am -0500,
> > Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> > 
> >> On 21.01.2020 15:36, Kirill Tkhai wrote:
> >>> On 21.01.2020 15:24, Mike Snitzer wrote:
> >>>> On Tue, Jan 21 2020 at  5:42am -0500,
> >>>> Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>>>
> >>>>> Since dm inherits limits from underlining block devices,
> >>>>> this patch directly disables max_allocate_sectors for dm
> >>>>> till full allocation support is implemented.
> >>>>>
> >>>>> This prevents high-level primitives (generic_make_request_checks(),
> >>>>> __blkdev_issue_write_zeroes(), ...) from sending REQ_ALLOCATE
> >>>>> requests.
> >>>>>
> >>>>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> >>>>> ---
> >>>>>  drivers/md/dm-table.c |    2 ++
> >>>>>  drivers/md/md.h       |    1 +
> >>>>>  2 files changed, 3 insertions(+)
> >>>>
> >>>> You're mixing DM and MD changes in the same patch.
> >>>>
> >>>> But I'm wondering if it might be best to set this default for stacking
> >>>> devices in blk_set_stacking_limits()?
> >>>>
> >>>> And then it is up to each stacking driver to override as needed.
> >>>
> >>> Hm. Sound like a good idea. This "lim->max_allocate_sectors = 0" in blk_set_stacking_limits()
> >>> should work for dm's dm_calculate_queue_limits(), since it calls blk_stack_limits(), which is:
> >>>
> >>> 	t->max_allocate_sectors = min(t->max_allocate_sectors,
> >>> 				      b->max_allocate_sectors);
> >>>
> >>> Could you please tell is this fix is also enough for md?
> >>
> >> It looks like it's enough since queue defaults are set in md_alloc()->blk_set_stacking_limits().
> >> In case of we set "max_allocate_sectors = 0", in further it can be changed only manually,
> >> but nobody does this.
> > 
> > Yes, it will work to disable this capability for MD and DM.
> > 
> > But if/when a stacked device _dooes_ want to support this then it'll be
> > awkward to override this stacking default to allow blk_stack_limits()
> > to properly stack up this limit.  blk_limits are extremely fiddley so
> > this isn't necessarily new.  But by explicitly defaulting to 0 and then
> > having blk_stack_limits use min() for this limit: it results in stacking
> > drivers needing to clumsily unwind the default.  E.g. DM will need to
> > tweak its blk_stack_limits() related code to allow override that
> > actually _does_  stack up the underlying devices' capability (and not
> > just impose its own limit that ignores the underlying devices).
> > 
> > So I'm not convinced this is the right way to go (be it the v4 approach
> > you took or the cleaner use of blk_set_stacking_limits I suggested).
> 
> Is there a strong vision about the way we should go? Or you leave this choose
> up to me?

I don't have time to work through it at the moment (e.g. implementing
dm-thinp support to know what the block core code should be) so I'll
just defer to you on a disabling it for now.

> > And to be clear, I'm interested in having DM thinp support this
> > capability to preallocate blocks.
> 
> My opinion is it would be better to not mix several subsystem related
> support in a single patch set. Both of the approaches (v4 or that you
> suggested) do not prevents us to implement allocation support in next
> patch series. After we have the base functionality enabled, we may add
> support in other subsystems and drivers one by one with more focus
> on the subsystem specificities and with the best possible attention.

Yeah, I'm aware nothing is ever set in stone.

Setting to 0 in blk_set_stacking_limits() is OK for now.

Thanks,
Mike

