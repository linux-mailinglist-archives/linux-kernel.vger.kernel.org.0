Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F131A590B8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 04:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfF1CPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 22:15:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfF1CPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:15:52 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07A5420656;
        Fri, 28 Jun 2019 02:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561688152;
        bh=SEuwoxb+YxWbpWoq3cFNrSyjo+k+UVoi+9JyvlZdzGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FOltpbKkKBV0rOJa6nZeGdrmkjaKE6WFqbeQzX9IlBP2SZHVnBXF1ZOsrFaYwrkQ3
         DB+gGkb3utGJFCiFilbXlogi4SOSfcmEX41rtkbso5nEQZnlC0grFJqdEnK8JS6c5D
         9+Z+SLQ30czmAOHLUBVY89NRjpCAYYL7PXNeepEg=
Date:   Thu, 27 Jun 2019 19:15:51 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: allocate blocks for pinned file
Message-ID: <20190628021551.GA10489@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190627170504.71700-1-jaegeuk@kernel.org>
 <f64cdddd-807e-2918-744b-56ced47a94dd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f64cdddd-807e-2918-744b-56ced47a94dd@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/28, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2019/6/28 1:05, Jaegeuk Kim wrote:
> > This patch allows fallocate to allocate physical blocks for pinned file.
> 
> Quoted from manual of fallocate(2):
> "
> Any subregion within the range specified by offset and len that did not contain
> data before the  call  will  be  initialized  to zero.
> 
> If  the  FALLOC_FL_KEEP_SIZE  flag  is specified in mode .... Preallocating
> zeroed blocks beyond the end of the file in this manner is useful for optimizing
> append workloads.
> "
> 
> As quoted description, our change may break the rule of fallocate(, mode = 0),
> because with after this change, we can't guarantee that preallocated physical
> block contains zeroed data
> 
> Should we introduce an additional ioctl for this case? Or maybe add one more
> flag in fallocate() for unzeroed block preallocation, not sure.

I thought like that, but this is a very corner case for the pinned file only in
f2fs. And, the pinned file is also indeed used by this purpose.

Thanks,

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/file.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index e7c368db8185..cdfd4338682d 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1528,7 +1528,12 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
> >  	if (off_end)
> >  		map.m_len++;
> >  
> > -	err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
> > +	if (f2fs_is_pinned_file(inode))
> > +		map.m_seg_type = CURSEG_COLD_DATA;
> > +
> > +	err = f2fs_map_blocks(inode, &map, 1, (f2fs_is_pinned_file(inode) ?
> > +						F2FS_GET_BLOCK_PRE_DIO :
> > +						F2FS_GET_BLOCK_PRE_AIO));
> >  	if (err) {
> >  		pgoff_t last_off;
> >  
> > 
