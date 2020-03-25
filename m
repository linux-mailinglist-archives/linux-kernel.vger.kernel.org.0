Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E443B191EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 03:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgCYCRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 22:17:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbgCYCRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 22:17:03 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7359720722;
        Wed, 25 Mar 2020 02:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585102622;
        bh=XlRkxTBt/TBT87nkAoXqhlaE/B9x/buZGWZ1KNMNLRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O9hk2njNRPuQj1azXPNGorbu7E4XupFHowJFqGbXkjF2utBsOoDDnzdvRCtT7BXHm
         FaOqc1/TZxq4Ly+kLBbiaR4IPim/Cfc4CzQUL+UmFT4C2Wi0r3FIlGIE6fs5eBheXK
         JyZCgv/goWUMrEjc+UH2q7aebvXWy+5+ClVVEyws=
Date:   Tue, 24 Mar 2020 19:17:02 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: remove redundant compress inode check
Message-ID: <20200325021702.GC198420@google.com>
References: <20200229104906.12061-1-yuchao0@huawei.com>
 <6aab59b9-6e33-5b01-acf8-ccbacd9318e3@huawei.com>
 <20200324154322.GB198420@google.com>
 <b0306fcf-27f2-20ab-9e5b-e54a924d4a61@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0306fcf-27f2-20ab-9e5b-e54a924d4a61@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25, Chao Yu wrote:
> On 2020/3/24 23:43, Jaegeuk Kim wrote:
> > On 03/24, Chao Yu wrote:
> >> Jaegeuk,
> >>
> >> Missed to apply this patch?
> >>
> >> On 2020/2/29 18:49, Chao Yu wrote:
> >>> due to f2fs_post_read_required() has did that.
> >>>
> >>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >>> ---
> >>>  fs/f2fs/f2fs.h | 2 --
> >>>  1 file changed, 2 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>> index f4bcbbd5e9ed..882f9ad3445b 100644
> >>> --- a/fs/f2fs/f2fs.h
> >>> +++ b/fs/f2fs/f2fs.h
> >>> @@ -4006,8 +4006,6 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
> >>>  		return true;
> >>>  	if (f2fs_is_multi_device(sbi))
> >>>  		return true;
> >>> -	if (f2fs_compressed_file(inode))
> >>> -		return true;
> > 
> > I thought that we can keep this to avoid any confusion when porting to old
> > production kernel which uses ICE.
> 
> That old kernel w/ ICE doesn't have f2fs_post_read_required(), right?

We do have.

> 
> I thought we backport features with order of the time fsverity/compression
> feature was introduced, then f2fs_post_read_required() should be there
> when we backport compression feature.
> 
> Thanks,
> 
> > 
> >>>  	/*
> >>>  	 * for blkzoned device, fallback direct IO to buffered IO, so
> >>>  	 * all IOs can be serialized by log-structured write.
> >>>
> > .
> > 
