Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BADE611D2DB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 17:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfLLQzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 11:55:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbfLLQzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:55:15 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B98A8214AF;
        Thu, 12 Dec 2019 16:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576169713;
        bh=kBSKM05Y5UlxkAax2yGnAlFKO9UJ0g7IYs5IpgkDhpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qtO+xA04fkDFG7FSHB/vAS7LNo+5gecWiievUp2aAkDlgZpJPXcaDMx4cRqvtW9SF
         NjnDptZKR/G1TIjibF6HgL8Z2DtmVkAY6JqKs+BMJkgTq2WvzlywWO1jgCR77YG+37
         BuhG7Bsr36M4cBqabjgMCvo2DD4lp3minkXPiFLA=
Date:   Thu, 12 Dec 2019 08:55:12 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 6/6] f2fs: set I_LINKABLE early to avoid wrong
 access by vfs
Message-ID: <20191212165512.GA12419@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191209222345.1078-1-jaegeuk@kernel.org>
 <20191209222345.1078-6-jaegeuk@kernel.org>
 <88dcbca9-3757-a440-ed73-9d99a56b816c@huawei.com>
 <20191211012121.GA52962@jaegeuk-macbookpro.roam.corp.google.com>
 <00ced682-9522-236d-4078-4c8f2e348d39@huawei.com>
 <20191211013124.GB57416@jaegeuk-macbookpro.roam.corp.google.com>
 <dd2021ff-6968-43ad-d8b2-3689668cd79e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd2021ff-6968-43ad-d8b2-3689668cd79e@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11, Chao Yu wrote:
> On 2019/12/11 9:31, Jaegeuk Kim wrote:
> > On 12/11, Chao Yu wrote:
> >> On 2019/12/11 9:21, Jaegeuk Kim wrote:
> >>> On 12/10, Chao Yu wrote:
> >>>> On 2019/12/10 6:23, Jaegeuk Kim wrote:
> >>>>> This patch moves setting I_LINKABLE early in rename2(whiteout) to avoid the
> >>>>> below warning.
> >>>>>
> >>>>> [ 3189.163385] WARNING: CPU: 3 PID: 59523 at fs/inode.c:358 inc_nlink+0x32/0x40
> >>>>> [ 3189.246979] Call Trace:
> >>>>> [ 3189.248707]  f2fs_init_inode_metadata+0x2d6/0x440 [f2fs]
> >>>>> [ 3189.251399]  f2fs_add_inline_entry+0x162/0x8c0 [f2fs]
> >>>>> [ 3189.254010]  f2fs_add_dentry+0x69/0xe0 [f2fs]
> >>>>> [ 3189.256353]  f2fs_do_add_link+0xc5/0x100 [f2fs]
> >>>>> [ 3189.258774]  f2fs_rename2+0xabf/0x1010 [f2fs]
> >>>>> [ 3189.261079]  vfs_rename+0x3f8/0xaa0
> >>>>> [ 3189.263056]  ? tomoyo_path_rename+0x44/0x60
> >>>>> [ 3189.265283]  ? do_renameat2+0x49b/0x550
> >>>>> [ 3189.267324]  do_renameat2+0x49b/0x550
> >>>>> [ 3189.269316]  __x64_sys_renameat2+0x20/0x30
> >>>>> [ 3189.271441]  do_syscall_64+0x5a/0x230
> >>>>> [ 3189.273410]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >>>>> [ 3189.275848] RIP: 0033:0x7f270b4d9a49
> >>>>>
> >>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>>>> ---
> >>>>>  fs/f2fs/namei.c | 27 +++++++++++++--------------
> >>>>>  1 file changed, 13 insertions(+), 14 deletions(-)
> >>>>>
> >>>>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> >>>>> index a1c507b0b4ac..5d9584281935 100644
> >>>>> --- a/fs/f2fs/namei.c
> >>>>> +++ b/fs/f2fs/namei.c
> >>>>> @@ -797,6 +797,7 @@ static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
> >>>>>  
> >>>>>  	if (whiteout) {
> >>>>>  		f2fs_i_links_write(inode, false);
> >>>>> +		inode->i_state |= I_LINKABLE;
> >>>>>  		*whiteout = inode;
> >>>>>  	} else {
> >>>>>  		d_tmpfile(dentry, inode);
> >>>>> @@ -867,6 +868,12 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
> >>>>>  			F2FS_I(old_dentry->d_inode)->i_projid)))
> >>>>>  		return -EXDEV;
> >>>>>  
> >>>>> +	if (flags & RENAME_WHITEOUT) {
> >>>>> +		err = f2fs_create_whiteout(old_dir, &whiteout);
> >>>>> +		if (err)
> >>>>> +			return err;
> >>>>> +	}
> >>>>
> >>>> To record quota info correctly, we need to create whiteout inode after
> >>>> dquot_initialize(old_dir)?
> >>>
> >>> __f2fs_tmpfile() will do it.
> >>
> >> Okay.
> >>
> >> Any comments on below question?
> >>
> >>>
> >>>>
> >>>>> +
> >>>>>  	err = dquot_initialize(old_dir);
> >>>>>  	if (err)
> >>>>>  		goto out;
> >>>>> @@ -898,17 +905,11 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
> >>>>>  		}
> >>>>>  	}
> >>>>>  
> >>>>> -	if (flags & RENAME_WHITEOUT) {
> >>>>> -		err = f2fs_create_whiteout(old_dir, &whiteout);
> >>>>> -		if (err)
> >>>>> -			goto out_dir;
> >>>>> -	}
> >>>>> -
> >>>>>  	if (new_inode) {
> >>>>>  
> >>>>>  		err = -ENOTEMPTY;
> >>>>>  		if (old_dir_entry && !f2fs_empty_dir(new_inode))
> >>>>> -			goto out_whiteout;
> >>>>> +			goto out_dir;
> >>>>>  
> >>>>>  		err = -ENOENT;
> >>>>>  		new_entry = f2fs_find_entry(new_dir, &new_dentry->d_name,
> >>>>> @@ -916,7 +917,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
> >>>>>  		if (!new_entry) {
> >>>>>  			if (IS_ERR(new_page))
> >>>>>  				err = PTR_ERR(new_page);
> >>>>> -			goto out_whiteout;
> >>>>> +			goto out_dir;
> >>>>>  		}
> >>>>>  
> >>>>>  		f2fs_balance_fs(sbi, true);
> >>>>> @@ -948,7 +949,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
> >>>>>  		err = f2fs_add_link(new_dentry, old_inode);
> >>>>>  		if (err) {
> >>>>>  			f2fs_unlock_op(sbi);
> >>>>> -			goto out_whiteout;
> >>>>> +			goto out_dir;
> >>>>>  		}
> >>>>>  
> >>>>>  		if (old_dir_entry)
> >>>>> @@ -972,7 +973,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
> >>>>>  				if (IS_ERR(old_page))
> >>>>>  					err = PTR_ERR(old_page);
> >>>>>  				f2fs_unlock_op(sbi);
> >>>>> -				goto out_whiteout;
> >>>>> +				goto out_dir;
> >>>>>  			}
> >>>>>  		}
> >>>>>  	}
> >>>>> @@ -991,7 +992,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
> >>>>>  	f2fs_delete_entry(old_entry, old_page, old_dir, NULL);
> >>>>>  
> >>>>>  	if (whiteout) {
> >>>>> -		whiteout->i_state |= I_LINKABLE;
> >>>>>  		set_inode_flag(whiteout, FI_INC_LINK);
> >>>>>  		err = f2fs_add_link(old_dentry, whiteout);
> >>>>
> >>>> [ 3189.256353]  f2fs_do_add_link+0xc5/0x100 [f2fs]
> >>>> [ 3189.258774]  f2fs_rename2+0xabf/0x1010 [f2fs]
> >>>>
> >>>> Does the call stack point here? if so, we have set I_LINKABLE before
> >>>> f2fs_add_link(), why the warning still be triggered?
> >>
> >> Am I missing something?
> > 
> > Not sure exactly tho, I suspect some races before/after unlock_new_inode().
> 
> Alright, I doubt some races on whiteout->i_state updating, as we set I_LINKABLE
> w/o holding inode.i_lock.
> 
> Could you have a try with holding i_lock?

I don't see the warning with this patch, and jumped to another issue. I'd like
to take a look at that later.

Thanks,

> 
> Thanks,
> 
> > 
> >>
> >> Thanks,
> >>
> >>>>
> >>>> Thanks,
> >>>>
> >>>>>  		if (err)
> >>>>> @@ -1027,15 +1027,14 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
> >>>>>  	f2fs_unlock_op(sbi);
> >>>>>  	if (new_page)
> >>>>>  		f2fs_put_page(new_page, 0);
> >>>>> -out_whiteout:
> >>>>> -	if (whiteout)
> >>>>> -		iput(whiteout);
> >>>>>  out_dir:
> >>>>>  	if (old_dir_entry)
> >>>>>  		f2fs_put_page(old_dir_page, 0);
> >>>>>  out_old:
> >>>>>  	f2fs_put_page(old_page, 0);
> >>>>>  out:
> >>>>> +	if (whiteout)
> >>>>> +		iput(whiteout);
> >>>>>  	return err;
> >>>>>  }
> >>>>>  
> >>>>>
> >>> .
> >>>
> > .
> > 
