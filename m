Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20230191533
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 16:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgCXPnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 11:43:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727216AbgCXPnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:43:23 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D41C020714;
        Tue, 24 Mar 2020 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585064602;
        bh=Qv9VoaJbPxXb6ifsksLylG5aLk2K8GMbJDDMXCV0fjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Db7a4hxBMH6eTuRq4g4f/SP8qeiY1OeXIglgiiJ8R6LPnJmd0IqRJtQZ0/iNu3TxT
         F3t180Ea6Mp/IKTYldRu4jZnCH6mZkRdFBJveCbCVoHEkZbYNmAVhEadf1lKoCh02Z
         GoAT/zBpm+7YXYrUYpJszrUX/wfU13ebDuydDRgk=
Date:   Tue, 24 Mar 2020 08:43:22 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: remove redundant compress inode check
Message-ID: <20200324154322.GB198420@google.com>
References: <20200229104906.12061-1-yuchao0@huawei.com>
 <6aab59b9-6e33-5b01-acf8-ccbacd9318e3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aab59b9-6e33-5b01-acf8-ccbacd9318e3@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/24, Chao Yu wrote:
> Jaegeuk,
> 
> Missed to apply this patch?
> 
> On 2020/2/29 18:49, Chao Yu wrote:
> > due to f2fs_post_read_required() has did that.
> > 
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > ---
> >  fs/f2fs/f2fs.h | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index f4bcbbd5e9ed..882f9ad3445b 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -4006,8 +4006,6 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
> >  		return true;
> >  	if (f2fs_is_multi_device(sbi))
> >  		return true;
> > -	if (f2fs_compressed_file(inode))
> > -		return true;

I thought that we can keep this to avoid any confusion when porting to old
production kernel which uses ICE.

> >  	/*
> >  	 * for blkzoned device, fallback direct IO to buffered IO, so
> >  	 * all IOs can be serialized by log-structured write.
> > 
