Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83586EF84A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 10:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbfKEJLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 04:11:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:59368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730528AbfKEJLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:11:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BD81AB2E7;
        Tue,  5 Nov 2019 09:11:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 772601E4407; Tue,  5 Nov 2019 10:11:11 +0100 (CET)
Date:   Tue, 5 Nov 2019 10:11:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org, namhyung@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 02/10] writeback: use ino_t for inodes in tracepoints
Message-ID: <20191105091111.GJ22379@quack2.suse.cz>
References: <20191104235944.3470866-1-tj@kernel.org>
 <20191104235944.3470866-3-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104235944.3470866-3-tj@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04-11-19 15:59:36, Tejun Heo wrote:
> Writeback TPs currently use mix of 32 and 64bits for inos.  This isn't
> currently broken because only cgroup inos are using 32bits and they're
> limited to 32bits.  cgroup inos will make use of 64bits.  Let's
> uniformly use ino_t.
> 
> While at it, switch the default cgroup ino value used when cgroup is
> disabled to 1 instead of -1U as root cgroup always uses ino 1.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Namhyung Kim <namhyung@kernel.org>

Thanks! The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Hello,
> 
> This is to prepare for kernfs 64bit ino support.  It'd be best to
> route this with the rest of kernfs patchset.
> 
> Thanks.
> 
>  include/trace/events/writeback.h | 88 ++++++++++++++++----------------
>  1 file changed, 44 insertions(+), 44 deletions(-)
> 
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index c2ce6480b4b1..95e50677476b 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -61,7 +61,7 @@ DECLARE_EVENT_CLASS(writeback_page_template,
>  
>  	TP_STRUCT__entry (
>  		__array(char, name, 32)
> -		__field(unsigned long, ino)
> +		__field(ino_t, ino)
>  		__field(pgoff_t, index)
>  	),
>  
> @@ -102,7 +102,7 @@ DECLARE_EVENT_CLASS(writeback_dirty_inode_template,
>  
>  	TP_STRUCT__entry (
>  		__array(char, name, 32)
> -		__field(unsigned long, ino)
> +		__field(ino_t, ino)
>  		__field(unsigned long, state)
>  		__field(unsigned long, flags)
>  	),
> @@ -150,28 +150,28 @@ DEFINE_EVENT(writeback_dirty_inode_template, writeback_dirty_inode,
>  #ifdef CREATE_TRACE_POINTS
>  #ifdef CONFIG_CGROUP_WRITEBACK
>  
> -static inline unsigned int __trace_wb_assign_cgroup(struct bdi_writeback *wb)
> +static inline ino_t __trace_wb_assign_cgroup(struct bdi_writeback *wb)
>  {
>  	return wb->memcg_css->cgroup->kn->id.ino;
>  }
>  
> -static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *wbc)
> +static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
>  {
>  	if (wbc->wb)
>  		return __trace_wb_assign_cgroup(wbc->wb);
>  	else
> -		return -1U;
> +		return 1;
>  }
>  #else	/* CONFIG_CGROUP_WRITEBACK */
>  
> -static inline unsigned int __trace_wb_assign_cgroup(struct bdi_writeback *wb)
> +static inline ino_t __trace_wb_assign_cgroup(struct bdi_writeback *wb)
>  {
> -	return -1U;
> +	return 1;
>  }
>  
> -static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *wbc)
> +static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
>  {
> -	return -1U;
> +	return 1;
>  }
>  
>  #endif	/* CONFIG_CGROUP_WRITEBACK */
> @@ -187,8 +187,8 @@ TRACE_EVENT(inode_foreign_history,
>  
>  	TP_STRUCT__entry(
>  		__array(char,		name, 32)
> -		__field(unsigned long,	ino)
> -		__field(unsigned int,	cgroup_ino)
> +		__field(ino_t,		ino)
> +		__field(ino_t,		cgroup_ino)
>  		__field(unsigned int,	history)
>  	),
>  
> @@ -199,7 +199,7 @@ TRACE_EVENT(inode_foreign_history,
>  		__entry->history	= history;
>  	),
>  
> -	TP_printk("bdi %s: ino=%lu cgroup_ino=%u history=0x%x",
> +	TP_printk("bdi %s: ino=%lu cgroup_ino=%lu history=0x%x",
>  		__entry->name,
>  		__entry->ino,
>  		__entry->cgroup_ino,
> @@ -216,9 +216,9 @@ TRACE_EVENT(inode_switch_wbs,
>  
>  	TP_STRUCT__entry(
>  		__array(char,		name, 32)
> -		__field(unsigned long,	ino)
> -		__field(unsigned int,	old_cgroup_ino)
> -		__field(unsigned int,	new_cgroup_ino)
> +		__field(ino_t,		ino)
> +		__field(ino_t,		old_cgroup_ino)
> +		__field(ino_t,		new_cgroup_ino)
>  	),
>  
>  	TP_fast_assign(
> @@ -228,7 +228,7 @@ TRACE_EVENT(inode_switch_wbs,
>  		__entry->new_cgroup_ino	= __trace_wb_assign_cgroup(new_wb);
>  	),
>  
> -	TP_printk("bdi %s: ino=%lu old_cgroup_ino=%u new_cgroup_ino=%u",
> +	TP_printk("bdi %s: ino=%lu old_cgroup_ino=%lu new_cgroup_ino=%lu",
>  		__entry->name,
>  		__entry->ino,
>  		__entry->old_cgroup_ino,
> @@ -245,10 +245,10 @@ TRACE_EVENT(track_foreign_dirty,
>  	TP_STRUCT__entry(
>  		__array(char,		name, 32)
>  		__field(u64,		bdi_id)
> -		__field(unsigned long,	ino)
> +		__field(ino_t,		ino)
>  		__field(unsigned int,	memcg_id)
> -		__field(unsigned int,	cgroup_ino)
> -		__field(unsigned int,	page_cgroup_ino)
> +		__field(ino_t,		cgroup_ino)
> +		__field(ino_t,		page_cgroup_ino)
>  	),
>  
>  	TP_fast_assign(
> @@ -263,7 +263,7 @@ TRACE_EVENT(track_foreign_dirty,
>  		__entry->page_cgroup_ino = page->mem_cgroup->css.cgroup->kn->id.ino;
>  	),
>  
> -	TP_printk("bdi %s[%llu]: ino=%lu memcg_id=%u cgroup_ino=%u page_cgroup_ino=%u",
> +	TP_printk("bdi %s[%llu]: ino=%lu memcg_id=%u cgroup_ino=%lu page_cgroup_ino=%lu",
>  		__entry->name,
>  		__entry->bdi_id,
>  		__entry->ino,
> @@ -282,7 +282,7 @@ TRACE_EVENT(flush_foreign,
>  
>  	TP_STRUCT__entry(
>  		__array(char,		name, 32)
> -		__field(unsigned int,	cgroup_ino)
> +		__field(ino_t,		cgroup_ino)
>  		__field(unsigned int,	frn_bdi_id)
>  		__field(unsigned int,	frn_memcg_id)
>  	),
> @@ -294,7 +294,7 @@ TRACE_EVENT(flush_foreign,
>  		__entry->frn_memcg_id	= frn_memcg_id;
>  	),
>  
> -	TP_printk("bdi %s: cgroup_ino=%u frn_bdi_id=%u frn_memcg_id=%u",
> +	TP_printk("bdi %s: cgroup_ino=%lu frn_bdi_id=%u frn_memcg_id=%u",
>  		__entry->name,
>  		__entry->cgroup_ino,
>  		__entry->frn_bdi_id,
> @@ -311,9 +311,9 @@ DECLARE_EVENT_CLASS(writeback_write_inode_template,
>  
>  	TP_STRUCT__entry (
>  		__array(char, name, 32)
> -		__field(unsigned long, ino)
> +		__field(ino_t, ino)
>  		__field(int, sync_mode)
> -		__field(unsigned int, cgroup_ino)
> +		__field(ino_t, cgroup_ino)
>  	),
>  
>  	TP_fast_assign(
> @@ -324,7 +324,7 @@ DECLARE_EVENT_CLASS(writeback_write_inode_template,
>  		__entry->cgroup_ino	= __trace_wbc_assign_cgroup(wbc);
>  	),
>  
> -	TP_printk("bdi %s: ino=%lu sync_mode=%d cgroup_ino=%u",
> +	TP_printk("bdi %s: ino=%lu sync_mode=%d cgroup_ino=%lu",
>  		__entry->name,
>  		__entry->ino,
>  		__entry->sync_mode,
> @@ -358,7 +358,7 @@ DECLARE_EVENT_CLASS(writeback_work_class,
>  		__field(int, range_cyclic)
>  		__field(int, for_background)
>  		__field(int, reason)
> -		__field(unsigned int, cgroup_ino)
> +		__field(ino_t, cgroup_ino)
>  	),
>  	TP_fast_assign(
>  		strscpy_pad(__entry->name,
> @@ -374,7 +374,7 @@ DECLARE_EVENT_CLASS(writeback_work_class,
>  		__entry->cgroup_ino = __trace_wb_assign_cgroup(wb);
>  	),
>  	TP_printk("bdi %s: sb_dev %d:%d nr_pages=%ld sync_mode=%d "
> -		  "kupdate=%d range_cyclic=%d background=%d reason=%s cgroup_ino=%u",
> +		  "kupdate=%d range_cyclic=%d background=%d reason=%s cgroup_ino=%lu",
>  		  __entry->name,
>  		  MAJOR(__entry->sb_dev), MINOR(__entry->sb_dev),
>  		  __entry->nr_pages,
> @@ -413,13 +413,13 @@ DECLARE_EVENT_CLASS(writeback_class,
>  	TP_ARGS(wb),
>  	TP_STRUCT__entry(
>  		__array(char, name, 32)
> -		__field(unsigned int, cgroup_ino)
> +		__field(ino_t, cgroup_ino)
>  	),
>  	TP_fast_assign(
>  		strscpy_pad(__entry->name, dev_name(wb->bdi->dev), 32);
>  		__entry->cgroup_ino = __trace_wb_assign_cgroup(wb);
>  	),
> -	TP_printk("bdi %s: cgroup_ino=%u",
> +	TP_printk("bdi %s: cgroup_ino=%lu",
>  		  __entry->name,
>  		  __entry->cgroup_ino
>  	)
> @@ -459,7 +459,7 @@ DECLARE_EVENT_CLASS(wbc_class,
>  		__field(int, range_cyclic)
>  		__field(long, range_start)
>  		__field(long, range_end)
> -		__field(unsigned int, cgroup_ino)
> +		__field(ino_t, cgroup_ino)
>  	),
>  
>  	TP_fast_assign(
> @@ -478,7 +478,7 @@ DECLARE_EVENT_CLASS(wbc_class,
>  
>  	TP_printk("bdi %s: towrt=%ld skip=%ld mode=%d kupd=%d "
>  		"bgrd=%d reclm=%d cyclic=%d "
> -		"start=0x%lx end=0x%lx cgroup_ino=%u",
> +		"start=0x%lx end=0x%lx cgroup_ino=%lu",
>  		__entry->name,
>  		__entry->nr_to_write,
>  		__entry->pages_skipped,
> @@ -510,7 +510,7 @@ TRACE_EVENT(writeback_queue_io,
>  		__field(long,		age)
>  		__field(int,		moved)
>  		__field(int,		reason)
> -		__field(unsigned int,	cgroup_ino)
> +		__field(ino_t,		cgroup_ino)
>  	),
>  	TP_fast_assign(
>  		unsigned long *older_than_this = work->older_than_this;
> @@ -522,7 +522,7 @@ TRACE_EVENT(writeback_queue_io,
>  		__entry->reason	= work->reason;
>  		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
>  	),
> -	TP_printk("bdi %s: older=%lu age=%ld enqueue=%d reason=%s cgroup_ino=%u",
> +	TP_printk("bdi %s: older=%lu age=%ld enqueue=%d reason=%s cgroup_ino=%lu",
>  		__entry->name,
>  		__entry->older,	/* older_than_this in jiffies */
>  		__entry->age,	/* older_than_this in relative milliseconds */
> @@ -596,7 +596,7 @@ TRACE_EVENT(bdi_dirty_ratelimit,
>  		__field(unsigned long,	dirty_ratelimit)
>  		__field(unsigned long,	task_ratelimit)
>  		__field(unsigned long,	balanced_dirty_ratelimit)
> -		__field(unsigned int,	cgroup_ino)
> +		__field(ino_t,		cgroup_ino)
>  	),
>  
>  	TP_fast_assign(
> @@ -614,7 +614,7 @@ TRACE_EVENT(bdi_dirty_ratelimit,
>  	TP_printk("bdi %s: "
>  		  "write_bw=%lu awrite_bw=%lu dirty_rate=%lu "
>  		  "dirty_ratelimit=%lu task_ratelimit=%lu "
> -		  "balanced_dirty_ratelimit=%lu cgroup_ino=%u",
> +		  "balanced_dirty_ratelimit=%lu cgroup_ino=%lu",
>  		  __entry->bdi,
>  		  __entry->write_bw,		/* write bandwidth */
>  		  __entry->avg_write_bw,	/* avg write bandwidth */
> @@ -660,7 +660,7 @@ TRACE_EVENT(balance_dirty_pages,
>  		__field(	 long,	pause)
>  		__field(unsigned long,	period)
>  		__field(	 long,	think)
> -		__field(unsigned int,	cgroup_ino)
> +		__field(ino_t,		cgroup_ino)
>  	),
>  
>  	TP_fast_assign(
> @@ -692,7 +692,7 @@ TRACE_EVENT(balance_dirty_pages,
>  		  "bdi_setpoint=%lu bdi_dirty=%lu "
>  		  "dirty_ratelimit=%lu task_ratelimit=%lu "
>  		  "dirtied=%u dirtied_pause=%u "
> -		  "paused=%lu pause=%ld period=%lu think=%ld cgroup_ino=%u",
> +		  "paused=%lu pause=%ld period=%lu think=%ld cgroup_ino=%lu",
>  		  __entry->bdi,
>  		  __entry->limit,
>  		  __entry->setpoint,
> @@ -718,10 +718,10 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
>  
>  	TP_STRUCT__entry(
>  		__array(char, name, 32)
> -		__field(unsigned long, ino)
> +		__field(ino_t, ino)
>  		__field(unsigned long, state)
>  		__field(unsigned long, dirtied_when)
> -		__field(unsigned int, cgroup_ino)
> +		__field(ino_t, cgroup_ino)
>  	),
>  
>  	TP_fast_assign(
> @@ -733,7 +733,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
>  		__entry->cgroup_ino	= __trace_wb_assign_cgroup(inode_to_wb(inode));
>  	),
>  
> -	TP_printk("bdi %s: ino=%lu state=%s dirtied_when=%lu age=%lu cgroup_ino=%u",
> +	TP_printk("bdi %s: ino=%lu state=%s dirtied_when=%lu age=%lu cgroup_ino=%lu",
>  		  __entry->name,
>  		  __entry->ino,
>  		  show_inode_state(__entry->state),
> @@ -789,13 +789,13 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
>  
>  	TP_STRUCT__entry(
>  		__array(char, name, 32)
> -		__field(unsigned long, ino)
> +		__field(ino_t, ino)
>  		__field(unsigned long, state)
>  		__field(unsigned long, dirtied_when)
>  		__field(unsigned long, writeback_index)
>  		__field(long, nr_to_write)
>  		__field(unsigned long, wrote)
> -		__field(unsigned int, cgroup_ino)
> +		__field(ino_t, cgroup_ino)
>  	),
>  
>  	TP_fast_assign(
> @@ -811,7 +811,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
>  	),
>  
>  	TP_printk("bdi %s: ino=%lu state=%s dirtied_when=%lu age=%lu "
> -		  "index=%lu to_write=%ld wrote=%lu cgroup_ino=%u",
> +		  "index=%lu to_write=%ld wrote=%lu cgroup_ino=%lu",
>  		  __entry->name,
>  		  __entry->ino,
>  		  show_inode_state(__entry->state),
> @@ -845,7 +845,7 @@ DECLARE_EVENT_CLASS(writeback_inode_template,
>  
>  	TP_STRUCT__entry(
>  		__field(	dev_t,	dev			)
> -		__field(unsigned long,	ino			)
> +		__field(	ino_t,	ino			)
>  		__field(unsigned long,	state			)
>  		__field(	__u16, mode			)
>  		__field(unsigned long, dirtied_when		)
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
