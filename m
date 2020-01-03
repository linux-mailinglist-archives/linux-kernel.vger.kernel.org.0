Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D59C912FC68
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 19:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgACSYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 13:24:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:51704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgACSYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:24:21 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E5D62253D;
        Fri,  3 Jan 2020 18:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578075860;
        bh=8GmiGoiad9F9euDfaoUwzGv677+r1T028Av3cwwRv6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bPxjWmALj3hc2NssGsqvfXfjehi1BLi7pQyf7+AtV81a6iJ2RYCuiZWS3y3hx7aGb
         Edf17kriv2eIp1Ia9jDengpgxuFnzMCKvXTHrOHRaJTXciDUVPq8LZhrr4eClKbsp/
         kvw7g+bhKc0Wm2KxP/3QIGGuCC7ljjjy3XC6YCAI=
Date:   Fri, 3 Jan 2020 10:24:19 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     =?utf-8?B?eGlhbnJvbmcuemhvdSjlkajlhYjojaMp?= 
        <xianrong.zhou@transsion.com>
Cc:     =?utf-8?B?d2VpbWluLm1hbyjmr5vljavmsJEp?= <weimin.mao@transsion.com>,
        =?utf-8?B?aGFpemhvdS5zb25nKOWui+a1t+iInyk=?= 
        <haizhou.song@transsion.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        =?utf-8?B?d2FuYmluLndhbmco5rGq5LiH5paMKQ==?= 
        <wanbin.wang@transsion.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?eXVhbmppb25nLmdhbyjpq5jmuIrngq8p?= 
        <yuanjiong.gao@transsion.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        =?utf-8?B?cnV4aWFuLmZlbmco5Yav5YSS5ai0KQ==?= 
        <ruxian.feng@transsion.com>, "agk@redhat.com" <agk@redhat.com>
Subject: Re: [dm-devel] [PATCH] dm-verity: unnecessary data blocks that need
 not read hash blocks
Message-ID: <20200103182418.GQ19521@gmail.com>
References: <727b9e9279a546beb2ae63a18eae6ab0@transsion.com>
 <20191216185025.GF139479@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191216185025.GF139479@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:50:26AM -0800, Eric Biggers wrote:
> On Mon, Dec 16, 2019 at 02:02:33AM +0000, xianrong.zhou(周先荣) wrote:
> > hey Eric:
> > 
> > On Wed, Dec 11, 2019 at 11:32:40AM +0800, zhou xianrong wrote:
> > > From: "xianrong.zhou" <xianrong.zhou@transsion.com>
> > > 
> > > If check_at_most_once enabled, just like verity work the prefetching 
> > > work should check for data block bitmap firstly before reading hash 
> > > block as well. Skip bit-set data blocks from both ends of data block 
> > > range by testing the validated bitmap. This can reduce the amounts of 
> > > data blocks which need to read hash blocks.
> > > 
> > > Launching 91 apps every 15s and repeat 21 rounds on Android Q.
> > > In prefetching work we can let only 2602/360312 = 0.72% data blocks 
> > > really need to read hash blocks.
> > > 
> > > But the reduced data blocks range would be enlarged again by 
> > > dm_verity_prefetch_cluster later.
> > > 
> > > Signed-off-by: xianrong.zhou <xianrong.zhou@transsion.com>
> > > Signed-off-by: yuanjiong.gao <yuanjiong.gao@transsion.com>
> > > Tested-by: ruxian.feng <ruxian.feng@transsion.com>
> > > ---
> > >  drivers/md/dm-verity-target.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/drivers/md/dm-verity-target.c 
> > > b/drivers/md/dm-verity-target.c index 4fb33e7562c5..7b8eb754c0b6 
> > > 100644
> > > --- a/drivers/md/dm-verity-target.c
> > > +++ b/drivers/md/dm-verity-target.c
> > > @@ -581,6 +581,22 @@ static void verity_prefetch_io(struct work_struct *work)
> > >  	struct dm_verity *v = pw->v;
> > >  	int i;
> > >  
> > > +	if (v->validated_blocks) {
> > > +		while (pw->n_blocks) {
> > > +			if (unlikely(!test_bit(pw->block, v->validated_blocks)))
> > > +				break;
> > > +			pw->block++;
> > > +			pw->n_blocks--;
> > > +		}
> > > +		while (pw->n_blocks) {
> > > +			if (unlikely(!test_bit(pw->block + pw->n_blocks - 1,
> > > +				v->validated_blocks)))
> > > +				break;
> > > +			pw->n_blocks--;
> > > +		}
> > > +		if (!pw->n_blocks)
> > > +			return;
> > > +	}
> > 
> > This is a good idea, but shouldn't this logic go in verity_submit_prefetch()
> > prior to the struct dm_verity_prefetch_work being allocated?  Then if no
> > prefeching is needed, allocating and scheduling the work object can be
> > skipped.
> > 
> > Eric, Do you mean it is more suitable in dm_bufio_prefetch which is called on
> > different paths even though prefeching is disabled ?
> > 
> 
> No, I'm talking about verity_submit_prefetch().  verity_submit_prefetch()
> allocates and schedules a work object, which executes verity_prefetch_io().
> If all data blocks in the I/O request were already validated, there's no need to
> allocate and schedule the prefetch work.
> 
> - Eric
> 

Are you planning to send a new version of this patch?

- Eric
