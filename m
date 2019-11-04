Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB4C6EDFFA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 13:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfKDMaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 07:30:15 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46450 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKDMaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 07:30:14 -0500
Received: by mail-yb1-f196.google.com with SMTP id h202so7710672ybg.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 04:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8qJs5e1udRxFyyAyn6vK1AHMJTKj4fvoQTpDcF29A7o=;
        b=QlUGkW0gSzfkC01SK4NKiq2GJFLi8knToaQAFEiYEl1Sjqu8pVlLh8KB3RgrKqjui2
         EI534EPyKcgTd7XMdY3KJj2Ne5nJsKl59oL9LjgSO6e7IXpzWl5GBXkvskNL+pydWbzI
         ZdF+vKJFrIkKABrXCNn/fUPp2b4uEkbAcT/aweCcur+RWf6dgMmRyX5JbRfzmd7Xh1pY
         EroseKV02SpVi4VRcELHNU8E8aUP8wEEJZPaEzxku8AhEeUi/u1Inz86EKTTiXMetvP0
         3AfXUreiRB7/yCpU9svlr0sz4yaW8gJ3sf7n5dgqTaTbuDbJ9lVX4C9W+ZbapV51pK/z
         HD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8qJs5e1udRxFyyAyn6vK1AHMJTKj4fvoQTpDcF29A7o=;
        b=UMLugQ2SdJlrVT18wsDb1qEj2aZck1ox8a+dwwdMCRV6NBazrK6rb4WbEYPz7Er1q1
         zR7QAn7UrD6D/IusIU8yqyJFYS0C5YBgizEgxWsqZNPycBuPlmEIhHBfp8Zha8IjMMti
         SWQ9mfYGif2GhylR2bG1v8hso6d26EnjyLoPWp4t83GWsJjmZVd0plOfy5NcEFqsRuNj
         DfsE0xlksUn+mEx1UudcCmGEzjkbIMGs1DVpMqNrmSBncilhyVYb9kYvSI+L2DVUkGol
         z/rE+spk0hFJOImER5VPXWS30RuJRCrTyvOQ//QNEqlVLgmLUr35PtsEInA3DtyyJaTH
         X9Kg==
X-Gm-Message-State: APjAAAXNEo40eSAWnOw52jE6cJPTz8kqiOxfoqIcojkG7YSCMRu4sADR
        Fce17M65Rz9Bsn3xGsMfgkRRfw==
X-Google-Smtp-Source: APXvYqx6p1wWUElHKQsVgom474lt/y+fqWYICZeqoCu5IxIuvMIQeeFi5015lBYcdqSnuv+Y/Evp/A==
X-Received: by 2002:a25:ab8d:: with SMTP id v13mr21468118ybi.351.1572870611811;
        Mon, 04 Nov 2019 04:30:11 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1038-30.members.linode.com. [45.33.96.30])
        by smtp.gmail.com with ESMTPSA id 23sm8973646ywf.91.2019.11.04.04.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Nov 2019 04:30:11 -0800 (PST)
Date:   Mon, 4 Nov 2019 20:30:01 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com
Subject: Re: [PATCH v3 1/3] perf: Allow using AUX data in perf samples
Message-ID: <20191104123001.GA31103@leoy-ThinkPad-X240s>
References: <20191025140835.53665-1-alexander.shishkin@linux.intel.com>
 <20191025140835.53665-2-alexander.shishkin@linux.intel.com>
 <20191104101658.GE4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104101658.GE4131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Nov 04, 2019 at 11:16:58AM +0100, Peter Zijlstra wrote:
> 
> Leo Yan,
> 
> Since you were helpful in the other CS thread, could you please have a
> look to see if this interface will work for you guys?

Thanks a lot for reminding.

After a quick look, this patch set would be very useful; especially,
given Arm/Arm64 don't have LBR, this patch will be very helpful for
'virtual' branch recording on Arm/Arm64.

@Mathieu, could you review this patch set if you have bandwidth?
Since you implemented CoreSight snapshot mode so you have much deep
understanding than me :)

I will review and test this patch set in this week.

Thanks,
Leo Yan

P.s. one concern is how to allow this feature works with CS ETF/ETB;
ETF/ETB may be more suitable for 'virtual' branch recording due its
trace data is only several KiB but it's sufficient for 32 or 64
branch entries.

> On Fri, Oct 25, 2019 at 05:08:33PM +0300, Alexander Shishkin wrote:
> > AUX data can be used to annotate perf events such as performance counters
> > or tracepoints/breakpoints by including it in sample records when
> > PERF_SAMPLE_AUX flag is set. Such samples would be instrumental in debugging
> > and profiling by providing, for example, a history of instruction flow
> > leading up to the event's overflow.
> > 
> > The implementation makes use of grouping an AUX event with all the events
> > that wish to take samples of the AUX data, such that the former is the
> > group leader. The samplees should also specify the desired size of the AUX
> > sample via attr.aux_sample_size.
> > 
> > AUX capable PMUs need to explicitly add support for sampling, because it
> > relies on a new callback to take a snapshot of the buffer without touching
> > the event states.
> > 
> > Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > ---
> >  include/linux/perf_event.h      |  19 ++++
> >  include/uapi/linux/perf_event.h |  10 +-
> >  kernel/events/core.c            | 172 +++++++++++++++++++++++++++++++-
> >  kernel/events/internal.h        |   1 +
> >  kernel/events/ring_buffer.c     |  36 +++++++
> >  5 files changed, 233 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 587ae4d002f5..446ce0014e89 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -249,6 +249,8 @@ struct perf_event;
> >  #define PERF_PMU_CAP_NO_EXCLUDE			0x80
> >  #define PERF_PMU_CAP_AUX_OUTPUT			0x100
> >  
> > +struct perf_output_handle;
> > +
> >  /**
> >   * struct pmu - generic performance monitoring unit
> >   */
> > @@ -423,6 +425,19 @@ struct pmu {
> >  	 */
> >  	void (*free_aux)		(void *aux); /* optional */
> >  
> > +	/*
> > +	 * Take a snapshot of the AUX buffer without touching the event
> > +	 * state, so that preempting ->start()/->stop() callbacks does
> > +	 * not interfere with their logic. Called in PMI context.
> > +	 *
> > +	 * Returns the size of AUX data copied to the output handle.
> > +	 *
> > +	 * Optional.
> > +	 */
> > +	long (*snapshot_aux)		(struct perf_event *event,
> > +					 struct perf_output_handle *handle,
> > +					 unsigned long size);
> > +
> >  	/*
> >  	 * Validate address range filters: make sure the HW supports the
> >  	 * requested configuration and number of filters; return 0 if the
> > @@ -964,6 +979,7 @@ struct perf_sample_data {
> >  		u32	reserved;
> >  	}				cpu_entry;
> >  	struct perf_callchain_entry	*callchain;
> > +	u64				aux_size;
> >  
> >  	/*
> >  	 * regs_user may point to task_pt_regs or to regs_user_copy, depending
> > @@ -1353,6 +1369,9 @@ extern unsigned int perf_output_copy(struct perf_output_handle *handle,
> >  			     const void *buf, unsigned int len);
> >  extern unsigned int perf_output_skip(struct perf_output_handle *handle,
> >  				     unsigned int len);
> > +extern long perf_output_copy_aux(struct perf_output_handle *aux_handle,
> > +				 struct perf_output_handle *handle,
> > +				 unsigned long from, unsigned long to);
> >  extern int perf_swevent_get_recursion_context(void);
> >  extern void perf_swevent_put_recursion_context(int rctx);
> >  extern u64 perf_swevent_set_period(struct perf_event *event);
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index bb7b271397a6..377d794d3105 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -141,8 +141,9 @@ enum perf_event_sample_format {
> >  	PERF_SAMPLE_TRANSACTION			= 1U << 17,
> >  	PERF_SAMPLE_REGS_INTR			= 1U << 18,
> >  	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
> > +	PERF_SAMPLE_AUX				= 1U << 20,
> >  
> > -	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
> > +	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
> >  
> >  	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
> >  };
> > @@ -300,6 +301,7 @@ enum perf_event_read_format {
> >  					/* add: sample_stack_user */
> >  #define PERF_ATTR_SIZE_VER4	104	/* add: sample_regs_intr */
> >  #define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
> > +#define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
> >  
> >  /*
> >   * Hardware event_id to monitor via a performance monitoring event:
> > @@ -424,7 +426,9 @@ struct perf_event_attr {
> >  	 */
> >  	__u32	aux_watermark;
> >  	__u16	sample_max_stack;
> > -	__u16	__reserved_2;	/* align to __u64 */
> > +	__u16	__reserved_2;
> > +	__u32	aux_sample_size;
> > +	__u32	__reserved_3;
> >  };
> >  
> >  /*
> > @@ -864,6 +868,8 @@ enum perf_event_type {
> >  	 *	{ u64			abi; # enum perf_sample_regs_abi
> >  	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
> >  	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
> > +	 *	{ u64			size;
> > +	 *	  char			data[size]; } && PERF_SAMPLE_AUX
> >  	 * };
> >  	 */
> >  	PERF_RECORD_SAMPLE			= 9,
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 0940c8810be0..36c612dbfcb0 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -1941,6 +1941,11 @@ static void perf_put_aux_event(struct perf_event *event)
> >  	}
> >  }
> >  
> > +static bool perf_need_aux_event(struct perf_event *event)
> > +{
> > +	return !!event->attr.aux_output || !!event->attr.aux_sample_size;
> > +}
> > +
> >  static int perf_get_aux_event(struct perf_event *event,
> >  			      struct perf_event *group_leader)
> >  {
> > @@ -1953,7 +1958,17 @@ static int perf_get_aux_event(struct perf_event *event,
> >  	if (!group_leader)
> >  		return 0;
> >  
> > -	if (!perf_aux_output_match(event, group_leader))
> > +	/*
> > +	 * aux_output and aux_sample_size are mutually exclusive.
> > +	 */
> > +	if (event->attr.aux_output && event->attr.aux_sample_size)
> > +		return 0;
> > +
> > +	if (event->attr.aux_output &&
> > +	    !perf_aux_output_match(event, group_leader))
> > +		return 0;
> > +
> > +	if (event->attr.aux_sample_size && !group_leader->pmu->snapshot_aux)
> >  		return 0;
> >  
> >  	if (!atomic_long_inc_not_zero(&group_leader->refcount))
> > @@ -6192,6 +6207,121 @@ perf_output_sample_ustack(struct perf_output_handle *handle, u64 dump_size,
> >  	}
> >  }
> >  
> > +static unsigned long perf_aux_sample_size(struct perf_event *event,
> > +					  struct perf_sample_data *data,
> > +					  size_t size)
> > +{
> > +	struct perf_event *sampler = event->aux_event;
> > +	struct ring_buffer *rb;
> > +
> > +	data->aux_size = 0;
> > +
> > +	if (!sampler)
> > +		goto out;
> > +
> > +	if (WARN_ON_ONCE(READ_ONCE(sampler->state) != PERF_EVENT_STATE_ACTIVE))
> > +		goto out;
> > +
> > +	if (WARN_ON_ONCE(READ_ONCE(sampler->oncpu) != smp_processor_id()))
> > +		goto out;
> > +
> > +	rb = ring_buffer_get(sampler->parent ? sampler->parent : sampler);
> > +	if (!rb)
> > +		goto out;
> > +
> > +	/*
> > +	 * If this is an NMI hit inside sampling code, don't take
> > +	 * the sample. See also perf_aux_sample_output().
> > +	 */
> > +	if (READ_ONCE(rb->aux_in_sampling)) {
> > +		data->aux_size = 0;
> > +	} else {
> > +		size = min_t(size_t, size, perf_aux_size(rb));
> > +		data->aux_size = ALIGN(size, sizeof(u64));
> > +	}
> > +	ring_buffer_put(rb);
> > +
> > +out:
> > +	return data->aux_size;
> > +}
> > +
> > +long perf_pmu_aux_sample_output(struct perf_event *event,
> > +				struct perf_output_handle *handle,
> > +				unsigned long size)
> > +{
> > +	unsigned long flags;
> > +	long ret;
> > +
> > +	/*
> > +	 * Normal ->start()/->stop() callbacks run in IRQ mode in scheduler
> > +	 * paths. If we start calling them in NMI context, they may race with
> > +	 * the IRQ ones, that is, for example, re-starting an event that's just
> > +	 * been stopped, which is why we're using a separate callback that
> > +	 * doesn't change the event state.
> > +	 *
> > +	 * IRQs need to be disabled to prevent IPIs from racing with us.
> > +	 */
> > +	local_irq_save(flags);
> > +
> > +	ret = event->pmu->snapshot_aux(event, handle, size);
> > +
> > +	local_irq_restore(flags);
> > +
> > +	return ret;
> > +}
> > +
> > +static void perf_aux_sample_output(struct perf_event *event,
> > +				   struct perf_output_handle *handle,
> > +				   struct perf_sample_data *data)
> > +{
> > +	struct perf_event *sampler = event->aux_event;
> > +	unsigned long pad;
> > +	struct ring_buffer *rb;
> > +	long size;
> > +
> > +	if (WARN_ON_ONCE(!sampler || !data->aux_size))
> > +		return;
> > +
> > +	rb = ring_buffer_get(sampler->parent ? sampler->parent : sampler);
> > +	if (!rb)
> > +		return;
> > +
> > +	/*
> > +	 * Guard against NMI hits inside the critical section;
> > +	 * see also perf_aux_sample_size().
> > +	 */
> > +	WRITE_ONCE(rb->aux_in_sampling, 1);
> > +
> > +	size = perf_pmu_aux_sample_output(sampler, handle, data->aux_size);
> > +
> > +	/*
> > +	 * An error here means that perf_output_copy() failed (returned a
> > +	 * non-zero surplus that it didn't copy), which in its current
> > +	 * enlightened implementation is not possible. If that changes, we'd
> > +	 * like to know.
> > +	 */
> > +	if (WARN_ON_ONCE(size < 0))
> > +		goto out_clear;
> > +
> > +	/*
> > +	 * The pad comes from ALIGN()ing data->aux_size up to u64 in
> > +	 * perf_aux_sample_size(), so should not be more than that.
> > +	 */
> > +	pad = data->aux_size - size;
> > +	if (WARN_ON_ONCE(pad >= sizeof(u64)))
> > +		pad = 8;
> > +
> > +	if (pad) {
> > +		u64 zero = 0;
> > +		perf_output_copy(handle, &zero, pad);
> > +	}
> > +
> > +out_clear:
> > +	WRITE_ONCE(rb->aux_in_sampling, 0);
> > +
> > +	ring_buffer_put(rb);
> > +}
> > +
> >  static void __perf_event_header__init_id(struct perf_event_header *header,
> >  					 struct perf_sample_data *data,
> >  					 struct perf_event *event)
> > @@ -6511,6 +6641,13 @@ void perf_output_sample(struct perf_output_handle *handle,
> >  	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
> >  		perf_output_put(handle, data->phys_addr);
> >  
> > +	if (sample_type & PERF_SAMPLE_AUX) {
> > +		perf_output_put(handle, data->aux_size);
> > +
> > +		if (data->aux_size)
> > +			perf_aux_sample_output(event, handle, data);
> > +	}
> > +
> >  	if (!event->attr.watermark) {
> >  		int wakeup_events = event->attr.wakeup_events;
> >  
> > @@ -6699,6 +6836,35 @@ void perf_prepare_sample(struct perf_event_header *header,
> >  
> >  	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
> >  		data->phys_addr = perf_virt_to_phys(data->addr);
> > +
> > +	if (sample_type & PERF_SAMPLE_AUX) {
> > +		u64 size;
> > +
> > +		header->size += sizeof(u64); /* size */
> > +
> > +		/*
> > +		 * Given the 16bit nature of header::size, an AUX sample can
> > +		 * easily overflow it, what with all the preceding sample bits.
> > +		 * Make sure this doesn't happen by using up to U16_MAX bytes
> > +		 * per sample in total (rounded down to 8 byte boundary).
> > +		 */
> > +		size = min_t(size_t, U16_MAX - header->size,
> > +			     event->attr.aux_sample_size);
> > +		size = rounddown(size, 8);
> > +		size = perf_aux_sample_size(event, data, size);
> > +
> > +		WARN_ON_ONCE(size + header->size > U16_MAX);
> > +		header->size += size;
> > +	}
> > +	/*
> > +	 * If you're adding more sample types here, you likely need to do
> > +	 * something about the overflowing header::size, like repurpose the
> > +	 * lowest 3 bits of size, which should be always zero at the moment.
> > +	 * This raises a more important question, do we really need 512k sized
> > +	 * samples and why, so good argumentation is in order for whatever you
> > +	 * do here next.
> > +	 */
> > +	WARN_ON_ONCE(header->size & 7);
> >  }
> >  
> >  static __always_inline int
> > @@ -10660,7 +10826,7 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
> >  
> >  	attr->size = size;
> >  
> > -	if (attr->__reserved_1 || attr->__reserved_2)
> > +	if (attr->__reserved_1 || attr->__reserved_2 || attr->__reserved_3)
> >  		return -EINVAL;
> >  
> >  	if (attr->sample_type & ~(PERF_SAMPLE_MAX-1))
> > @@ -11210,7 +11376,7 @@ SYSCALL_DEFINE5(perf_event_open,
> >  		}
> >  	}
> >  
> > -	if (event->attr.aux_output && !perf_get_aux_event(event, group_leader))
> > +	if (perf_need_aux_event(event) && !perf_get_aux_event(event, group_leader))
> >  		goto err_locked;
> >  
> >  	/*
> > diff --git a/kernel/events/internal.h b/kernel/events/internal.h
> > index 3aef4191798c..747d67f130cb 100644
> > --- a/kernel/events/internal.h
> > +++ b/kernel/events/internal.h
> > @@ -50,6 +50,7 @@ struct ring_buffer {
> >  	unsigned long			aux_mmap_locked;
> >  	void				(*free_aux)(void *);
> >  	refcount_t			aux_refcount;
> > +	int				aux_in_sampling;
> >  	void				**aux_pages;
> >  	void				*aux_priv;
> >  
> > diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> > index 246c83ac5643..7ffd5c763f93 100644
> > --- a/kernel/events/ring_buffer.c
> > +++ b/kernel/events/ring_buffer.c
> > @@ -562,6 +562,42 @@ void *perf_get_aux(struct perf_output_handle *handle)
> >  }
> >  EXPORT_SYMBOL_GPL(perf_get_aux);
> >  
> > +/*
> > + * Copy out AUX data from an AUX handle.
> > + */
> > +long perf_output_copy_aux(struct perf_output_handle *aux_handle,
> > +			  struct perf_output_handle *handle,
> > +			  unsigned long from, unsigned long to)
> > +{
> > +	unsigned long tocopy, remainder, len = 0;
> > +	struct ring_buffer *rb = aux_handle->rb;
> > +	void *addr;
> > +
> > +	from &= (rb->aux_nr_pages << PAGE_SHIFT) - 1;
> > +	to &= (rb->aux_nr_pages << PAGE_SHIFT) - 1;
> > +
> > +	do {
> > +		tocopy = PAGE_SIZE - offset_in_page(from);
> > +		if (to > from)
> > +			tocopy = min(tocopy, to - from);
> > +		if (!tocopy)
> > +			break;
> > +
> > +		addr = rb->aux_pages[from >> PAGE_SHIFT];
> > +		addr += offset_in_page(from);
> > +
> > +		remainder = perf_output_copy(handle, addr, tocopy);
> > +		if (remainder)
> > +			return -EFAULT;
> > +
> > +		len += tocopy;
> > +		from += tocopy;
> > +		from &= (rb->aux_nr_pages << PAGE_SHIFT) - 1;
> > +	} while (to != from);
> > +
> > +	return len;
> > +}
> > +
> >  #define PERF_AUX_GFP	(GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY)
> >  
> >  static struct page *rb_alloc_aux_page(int node, int order)
> > -- 
> > 2.23.0
> > 
