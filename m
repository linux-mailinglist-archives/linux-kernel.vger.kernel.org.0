Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2B84EDE0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 19:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfFURiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 13:38:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfFURiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:38:09 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C0D72083B;
        Fri, 21 Jun 2019 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138688;
        bh=rc7HI8Z+95ky1caBbPwlhknc8sWW1qhad5xQShtABbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wv4DWWJWoNgKmfcNjV6ksfz0FMKBu6EDKX7weOis+MDeDqGlw8czZFRbTXFnfIuLM
         GQjjLTN7QR5zXrUclaLrzRDEG51jotJZM8T2ouJ6oc23ktupZvO/m0QhiMuPYSbqRq
         xiWsWvzhhF+c2lcVhl4+JJNXHSc/eHsterL9mpJw=
Date:   Fri, 21 Jun 2019 10:38:07 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: add a rw_sem to cover quota flag
 changes
Message-ID: <20190621173807.GB79502@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190530033115.16853-1-jaegeuk@kernel.org>
 <20190530175714.GB28719@jaegeuk-macbookpro.roam.corp.google.com>
 <20190604183619.GA8507@jaegeuk-macbookpro.roam.corp.google.com>
 <2afe0416-fe2d-8ba8-7625-0246aca9eba6@huawei.com>
 <20190614024655.GA18113@jaegeuk-macbookpro.roam.corp.google.com>
 <6f70ae56-45eb-666d-ae55-48eb0cc96f32@huawei.com>
 <20190619172651.GB57884@jaegeuk-macbookpro.roam.corp.google.com>
 <ba6555c9-b864-d0cc-1c65-4077e7f15175@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba6555c9-b864-d0cc-1c65-4077e7f15175@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20, Chao Yu wrote:
> On 2019/6/20 1:26, Jaegeuk Kim wrote:
> > On 06/18, Chao Yu wrote:
> >> On 2019/6/14 10:46, Jaegeuk Kim wrote:
> >>> On 06/11, Chao Yu wrote:
> >>>> On 2019/6/5 2:36, Jaegeuk Kim wrote:
> >>>>> Two paths to update quota and f2fs_lock_op:
> >>>>>
> >>>>> 1.
> >>>>>  - lock_op
> >>>>>  |  - quota_update
> >>>>>  `- unlock_op
> >>>>>
> >>>>> 2.
> >>>>>  - quota_update
> >>>>>  - lock_op
> >>>>>  `- unlock_op
> >>>>>
> >>>>> But, we need to make a transaction on quota_update + lock_op in #2 case.
> >>>>> So, this patch introduces:
> >>>>> 1. lock_op
> >>>>> 2. down_write
> >>>>> 3. check __need_flush
> >>>>> 4. up_write
> >>>>> 5. if there is dirty quota entries, flush them
> >>>>> 6. otherwise, good to go
> >>>>>
> >>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>>>> ---
> >>>>>
> >>>>> v3 from v2:
> >>>>>  - refactor to fix quota corruption issue
> >>>>>   : it seems that the previous scenario is not real and no deadlock case was
> >>>>>     encountered.
> >>>>
> >>>> - f2fs_dquot_commit
> >>>>  - down_read(&sbi->quota_sem)
> >>>> 					- block_operation
> >>>> 					 - f2fs_lock_all
> >>>> 					  - need_flush_quota
> >>>> 					   - down_write(&sbi->quota_sem)
> >>>>   - f2fs_quota_write
> >>>>    - f2fs_lock_op
> >>>>
> >>>> Why can't this happen?
> >>>>
> >>>> Once more question, should we hold quota_sem during checkpoint to avoid further
> >>>> quota update? f2fs_lock_op can do this job as well?
> >>>
> >>> I couldn't find write_dquot() call to make this happen, and f2fs_lock_op was not
> >>
> >> - f2fs_dquot_commit
> >>  - dquot_commit
> >>   ->commit_dqblk (v2_write_dquot)
> >>    - qtree_write_dquot
> >>     ->quota_write (f2fs_quota_write)
> >>      - f2fs_lock_op
> >>
> >> Do you mean there is no such way that calling f2fs_lock_op() from
> >> f2fs_quota_write()? So that deadlock condition is not existing?
> > 
> > I mean write_dquot->f2fs_dquot_commit and block_operation seems not racing
> > together.
> 
> quota ioctl has the path calling write_dquot->f2fs_dquot_commit as below, which
> can race with checkpoint().
> 
> - do_quotactl
>  - sb->s_qcop->quota_sync (f2fs_quota_sync)
>   - down_read(&sbi->quota_sem);      ----  First
>    - dquot_writeback_dquots
>     - sb->dq_op->write_dquot (f2fs_dquot_commit)
> 							- block_operation can race here
>      - down_read(&sbi->quota_sem);   ----  Second

Adding f2fs_lock_op() in f2fs_quota_sync() should be fine?

> 
> Thanks,
> 
> > 
> >>
> >> Thanks,
> >>
> >>> enough to cover quota updates. Current stress & power-cut tests are running for
> >>> several days without problem with this patch.
> >>>
> >>>>
> >>>> Thanks,
> >>>>
> >>>>>
> >>>>>  fs/f2fs/checkpoint.c | 41 +++++++++++++++++++----------------------
> >>>>>  fs/f2fs/f2fs.h       |  1 +
> >>>>>  fs/f2fs/super.c      | 26 +++++++++++++++++++++-----
> >>>>>  3 files changed, 41 insertions(+), 27 deletions(-)
> >>>>>
> >>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> >>>>> index 89825261d474..43f65f0962e5 100644
> >>>>> --- a/fs/f2fs/checkpoint.c
> >>>>> +++ b/fs/f2fs/checkpoint.c
> >>>>> @@ -1131,17 +1131,24 @@ static void __prepare_cp_block(struct f2fs_sb_info *sbi)
> >>>>>  
> >>>>>  static bool __need_flush_quota(struct f2fs_sb_info *sbi)
> >>>>>  {
> >>>>> +	bool ret = false;
> >>>>> +
> >>>>>  	if (!is_journalled_quota(sbi))
> >>>>>  		return false;
> >>>>> -	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
> >>>>> -		return false;
> >>>>> -	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
> >>>>> -		return false;
> >>>>> -	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_FLUSH))
> >>>>> -		return true;
> >>>>> -	if (get_pages(sbi, F2FS_DIRTY_QDATA))
> >>>>> -		return true;
> >>>>> -	return false;
> >>>>> +
> >>>>> +	down_write(&sbi->quota_sem);
> >>>>> +	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH)) {
> >>>>> +		ret = false;
> >>>>> +	} else if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR)) {
> >>>>> +		ret = false;
> >>>>> +	} else if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_FLUSH)) {
> >>>>> +		clear_sbi_flag(sbi, SBI_QUOTA_NEED_FLUSH);
> >>>>> +		ret = true;
> >>>>> +	} else if (get_pages(sbi, F2FS_DIRTY_QDATA)) {
> >>>>> +		ret = true;
> >>>>> +	}
> >>>>> +	up_write(&sbi->quota_sem);
> >>>>> +	return ret;
> >>>>>  }
> >>>>>  
> >>>>>  /*
> >>>>> @@ -1160,26 +1167,22 @@ static int block_operations(struct f2fs_sb_info *sbi)
> >>>>>  	blk_start_plug(&plug);
> >>>>>  
> >>>>>  retry_flush_quotas:
> >>>>> +	f2fs_lock_all(sbi);
> >>>>>  	if (__need_flush_quota(sbi)) {
> >>>>>  		int locked;
> >>>>>  
> >>>>>  		if (++cnt > DEFAULT_RETRY_QUOTA_FLUSH_COUNT) {
> >>>>>  			set_sbi_flag(sbi, SBI_QUOTA_SKIP_FLUSH);
> >>>>> -			f2fs_lock_all(sbi);
> >>>>> +			set_sbi_flag(sbi, SBI_QUOTA_NEED_FLUSH);
> >>>>>  			goto retry_flush_dents;
> >>>>>  		}
> >>>>> -		clear_sbi_flag(sbi, SBI_QUOTA_NEED_FLUSH);
> >>>>> +		f2fs_unlock_all(sbi);
> >>>>>  
> >>>>>  		/* only failed during mount/umount/freeze/quotactl */
> >>>>>  		locked = down_read_trylock(&sbi->sb->s_umount);
> >>>>>  		f2fs_quota_sync(sbi->sb, -1);
> >>>>>  		if (locked)
> >>>>>  			up_read(&sbi->sb->s_umount);
> >>>>> -	}
> >>>>> -
> >>>>> -	f2fs_lock_all(sbi);
> >>>>> -	if (__need_flush_quota(sbi)) {
> >>>>> -		f2fs_unlock_all(sbi);
> >>>>>  		cond_resched();
> >>>>>  		goto retry_flush_quotas;
> >>>>>  	}
> >>>>> @@ -1201,12 +1204,6 @@ static int block_operations(struct f2fs_sb_info *sbi)
> >>>>>  	 */
> >>>>>  	down_write(&sbi->node_change);
> >>>>>  
> >>>>> -	if (__need_flush_quota(sbi)) {
> >>>>> -		up_write(&sbi->node_change);
> >>>>> -		f2fs_unlock_all(sbi);
> >>>>> -		goto retry_flush_quotas;
> >>>>> -	}
> >>>>> -
> >>>>>  	if (get_pages(sbi, F2FS_DIRTY_IMETA)) {
> >>>>>  		up_write(&sbi->node_change);
> >>>>>  		f2fs_unlock_all(sbi);
> >>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>>>> index 9674a85154b2..9bd2bf0f559b 100644
> >>>>> --- a/fs/f2fs/f2fs.h
> >>>>> +++ b/fs/f2fs/f2fs.h
> >>>>> @@ -1253,6 +1253,7 @@ struct f2fs_sb_info {
> >>>>>  	block_t unusable_block_count;		/* # of blocks saved by last cp */
> >>>>>  
> >>>>>  	unsigned int nquota_files;		/* # of quota sysfile */
> >>>>> +	struct rw_semaphore quota_sem;		/* blocking cp for flags */
> >>>>>  
> >>>>>  	/* # of pages, see count_type */
> >>>>>  	atomic_t nr_pages[NR_COUNT_TYPE];
> >>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >>>>> index 15d7e30bfc72..5a318399a2fa 100644
> >>>>> --- a/fs/f2fs/super.c
> >>>>> +++ b/fs/f2fs/super.c
> >>>>> @@ -1964,6 +1964,7 @@ int f2fs_quota_sync(struct super_block *sb, int type)
> >>>>>  	int cnt;
> >>>>>  	int ret;
> >>>>>  
> >>>>> +	down_read(&sbi->quota_sem);
> >>>>>  	ret = dquot_writeback_dquots(sb, type);
> >>>>>  	if (ret)
> >>>>>  		goto out;
> >>>>> @@ -2001,6 +2002,7 @@ int f2fs_quota_sync(struct super_block *sb, int type)
> >>>>>  out:
> >>>>>  	if (ret)
> >>>>>  		set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
> >>>>> +	up_read(&sbi->quota_sem);
> >>>>>  	return ret;
> >>>>>  }
> >>>>>  
> >>>>> @@ -2094,32 +2096,40 @@ static void f2fs_truncate_quota_inode_pages(struct super_block *sb)
> >>>>>  
> >>>>>  static int f2fs_dquot_commit(struct dquot *dquot)
> >>>>>  {
> >>>>> +	struct f2fs_sb_info *sbi = F2FS_SB(dquot->dq_sb);
> >>>>>  	int ret;
> >>>>>  
> >>>>> +	down_read(&sbi->quota_sem);
> >>>>>  	ret = dquot_commit(dquot);
> >>>>>  	if (ret < 0)
> >>>>> -		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_QUOTA_NEED_REPAIR);
> >>>>> +		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
> >>>>> +	up_read(&sbi->quota_sem);
> >>>>>  	return ret;
> >>>>>  }
> >>>>>  
> >>>>>  static int f2fs_dquot_acquire(struct dquot *dquot)
> >>>>>  {
> >>>>> +	struct f2fs_sb_info *sbi = F2FS_SB(dquot->dq_sb);
> >>>>>  	int ret;
> >>>>>  
> >>>>> +	down_read(&sbi->quota_sem);
> >>>>>  	ret = dquot_acquire(dquot);
> >>>>>  	if (ret < 0)
> >>>>> -		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_QUOTA_NEED_REPAIR);
> >>>>> -
> >>>>> +		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
> >>>>> +	up_read(&sbi->quota_sem);
> >>>>>  	return ret;
> >>>>>  }
> >>>>>  
> >>>>>  static int f2fs_dquot_release(struct dquot *dquot)
> >>>>>  {
> >>>>> +	struct f2fs_sb_info *sbi = F2FS_SB(dquot->dq_sb);
> >>>>>  	int ret;
> >>>>>  
> >>>>> +	down_read(&sbi->quota_sem);
> >>>>>  	ret = dquot_release(dquot);
> >>>>>  	if (ret < 0)
> >>>>> -		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_QUOTA_NEED_REPAIR);
> >>>>> +		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
> >>>>> +	up_read(&sbi->quota_sem);
> >>>>>  	return ret;
> >>>>>  }
> >>>>>  
> >>>>> @@ -2129,22 +2139,27 @@ static int f2fs_dquot_mark_dquot_dirty(struct dquot *dquot)
> >>>>>  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> >>>>>  	int ret;
> >>>>>  
> >>>>> +	down_read(&sbi->quota_sem);
> >>>>>  	ret = dquot_mark_dquot_dirty(dquot);
> >>>>>  
> >>>>>  	/* if we are using journalled quota */
> >>>>>  	if (is_journalled_quota(sbi))
> >>>>>  		set_sbi_flag(sbi, SBI_QUOTA_NEED_FLUSH);
> >>>>>  
> >>>>> +	up_read(&sbi->quota_sem);
> >>>>>  	return ret;
> >>>>>  }
> >>>>>  
> >>>>>  static int f2fs_dquot_commit_info(struct super_block *sb, int type)
> >>>>>  {
> >>>>> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> >>>>>  	int ret;
> >>>>>  
> >>>>> +	down_read(&sbi->quota_sem);
> >>>>>  	ret = dquot_commit_info(sb, type);
> >>>>>  	if (ret < 0)
> >>>>> -		set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
> >>>>> +		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
> >>>>> +	up_read(&sbi->quota_sem);
> >>>>>  	return ret;
> >>>>>  }
> >>>>>  
> >>>>> @@ -3253,6 +3268,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >>>>>  	}
> >>>>>  
> >>>>>  	init_rwsem(&sbi->cp_rwsem);
> >>>>> +	init_rwsem(&sbi->quota_sem);
> >>>>>  	init_waitqueue_head(&sbi->cp_wait);
> >>>>>  	init_sb_info(sbi);
> >>>>>  
> >>>>>
> >>> .
> >>>
> > .
> > 
