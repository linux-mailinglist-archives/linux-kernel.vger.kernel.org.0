Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5411E180E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 04:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgCKDHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 23:07:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgCKDHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:07:43 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 551A32146E;
        Wed, 11 Mar 2020 03:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583896062;
        bh=WJTonuZBHjT2gmhJN5zqDlZVwWoWWxEFvlg0bLkgcg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BlJ4JbogrNYdixG1Oj5q7F5cAsJpnZceO2kKG3ORkTbq8cZKavuMhj2NhkmuqYyQq
         V9JFpe/ztou8PEXtRCplLa35qZdEIddXbPhDmhQAo2J5krlVS1tXv7Xoz/xlMAjDcV
         VQ45Hozkk46oYOKTfr2rmEA39J30tHA5TRCG9v9E=
Date:   Tue, 10 Mar 2020 20:07:41 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 1/5] f2fs: change default compression algorithm
Message-ID: <20200311030741.GA119277@google.com>
References: <20200310125009.12966-1-yuchao0@huawei.com>
 <20200310161515.GA1067@sol.localdomain>
 <4d8384b9-88fe-2a15-13ff-238d9fd4027a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8384b9-88fe-2a15-13ff-238d9fd4027a@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11, Chao Yu wrote:
> On 2020/3/11 0:15, Eric Biggers wrote:
> > On Tue, Mar 10, 2020 at 08:50:05PM +0800, Chao Yu wrote:
> >> Use LZ4 as default compression algorithm, as compared to LZO, it shows
> >> almost the same compression ratio and much better decompression speed.
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/super.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >> index db3a63f7c769..ebffe7aa08ee 100644
> >> --- a/fs/f2fs/super.c
> >> +++ b/fs/f2fs/super.c
> >> @@ -1577,7 +1577,7 @@ static void default_options(struct f2fs_sb_info *sbi)
> >>  	F2FS_OPTION(sbi).test_dummy_encryption = false;
> >>  	F2FS_OPTION(sbi).s_resuid = make_kuid(&init_user_ns, F2FS_DEF_RESUID);
> >>  	F2FS_OPTION(sbi).s_resgid = make_kgid(&init_user_ns, F2FS_DEF_RESGID);
> >> -	F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZO;
> >> +	F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZ4;
> >>  	F2FS_OPTION(sbi).compress_log_size = MIN_COMPRESS_LOG_SIZE;
> >>  	F2FS_OPTION(sbi).compress_ext_cnt = 0;
> >>  	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
> > 
> > This makes sense, but it's unclear to me why comparing the different compression
> > algorithms is happening just now, after support for both LZO and LZ4 was already
> > merged into mainline and now has to be supported forever.  During review months
> > ago, multiple people suggested that LZ4 is better than LZO, so there's not much
> > reason to support LZO at all.
> 
> Agreed,
> 
> Jaegeuk, thoughts?

Supporting LZO or whatever algorithms looks fine to me as long as kernel
supports without huge maintenance effort. I think it'd be good to provide
a way for users to compare several algorithms in whatever their ways.

And, unfortunately, I don't think we can remove LZO at this point, even for -rc.

Thanks,

> 
> Let me remove lzo if you have no objection on this.
> 
> Thanks,
> 
> > 
> > - Eric
> > .
> > 
