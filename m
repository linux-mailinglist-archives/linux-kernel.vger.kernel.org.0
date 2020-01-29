Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70F9814D252
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 22:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgA2VJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 16:09:08 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43344 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgA2VJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 16:09:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id s1so277527pfh.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 13:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=36D3DxD07HLlQ4b5Xg920trzYAA/7vy/BzURBWhUFgg=;
        b=Rq4yUVm3lH4Kea7XC63SC0hAfC4KN/ukMQIMSIsqcWlzuSD+uk1QEfCwVPBRNohzZU
         ruWbIUCyQlR9Qjwkd7QUCMwJor25JyzrECBr8tSJJNwci0TMotKq7wRRfjf92IYCAsy1
         Bu1FC/lWm1X4mtf/w96iHAujur/gOIQGY13AqGfLfNdZ10vZAArBSoMOEw7PBQLp+esz
         hBBFoKW6kPDaq7sn282Tu8pbKQijPFb3Gztrz5dApC/WUjMhZ7mbtNHafOzolOJjM4jO
         jVFVtGPkFo0806VVOjCwPr23yNMLeAVsg8yWzo0/1Bp7We7b4cmUgaLxWX6dmU0L3Wb3
         NDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=36D3DxD07HLlQ4b5Xg920trzYAA/7vy/BzURBWhUFgg=;
        b=qzeLdNj2CYKUUoe+UOV8FNAxnfmhX5cjAFguHB+v0Y8u+bkn/VCTwo+UvnQnGQ2Q9G
         Hej+ebzo+33+i/s7+PStIX50yl5SKDXdTg2z71THLr4j67xSXRr4ea+NI6Mkdj4eFauD
         FJs+evdQJAg5od7QXVDH/UD4AjshFMH83hkGOckFDrau6u5hyDimIX0iYYY3xLczAj59
         +BAqELybdQ2NplmOyeacqudNVGR0cacHVSip18NitDA1AcUIYBXP1C3sUeaJbWTDJaEd
         yLsGWUlwZeOY5JUfHHG4MCTTQyya1hhYrX1r9YxMNPt1RHeY53XxMioqxgyc3J0bsxwM
         GG6g==
X-Gm-Message-State: APjAAAX84zU/5lzu5w22wRbafZuOlY9oCrQXBBRkTBEnY3jJK2P/wCb7
        XvDTOj7jHk6DntRlC+xxACT0lQ==
X-Google-Smtp-Source: APXvYqxeCY4B2ZQtvcFojY5J9xqyZyLva8x94xZBBFyXH5POFVtEkNZwW1NuTxAwB5B2fY+Dba4I3Q==
X-Received: by 2002:a63:7843:: with SMTP id t64mr1070867pgc.144.1580332144939;
        Wed, 29 Jan 2020 13:09:04 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id o73sm3751226pje.7.2020.01.29.13.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 13:09:04 -0800 (PST)
Date:   Wed, 29 Jan 2020 13:09:03 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mina Almasry <almasrymina@google.com>
cc:     mike.kravetz@oracle.com, shakeelb@google.com, shuah@kernel.org,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v10 1/8] hugetlb_cgroup: Add hugetlb_cgroup reservation
 counter
In-Reply-To: <20200115012651.228058-1-almasrymina@google.com>
Message-ID: <alpine.DEB.2.21.2001291303230.175731@chino.kir.corp.google.com>
References: <20200115012651.228058-1-almasrymina@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020, Mina Almasry wrote:

> These counters will track hugetlb reservations rather than hugetlb
> memory faulted in. This patch only adds the counter, following patches
> add the charging and uncharging of the counter.
> 
> This is patch 1 of an 8 patch series.
> 
> Problem:
> Currently tasks attempting to reserve more hugetlb memory than is available get
> a failure at mmap/shmget time. This is thanks to Hugetlbfs Reservations [1].
> However, if a task attempts to reserve hugetlb memory only more than its
> hugetlb_cgroup limit allows, the kernel will allow the mmap/shmget call,
> but will SIGBUS the task when it attempts to fault the memory in.
> 
> We have users hitting their hugetlb_cgroup limits and thus we've been
> looking at this failure mode. We'd like to improve this behavior such that users
> violating the hugetlb_cgroup limits get an error on mmap/shmget time, rather
> than getting SIGBUS'd when they try to fault the excess memory in. This
> gives the user an opportunity to fallback more gracefully to
> non-hugetlbfs memory for example.
> 
> The underlying problem is that today's hugetlb_cgroup accounting happens
> at hugetlb memory *fault* time, rather than at *reservation* time.
> Thus, enforcing the hugetlb_cgroup limit only happens at fault time, and
> the offending task gets SIGBUS'd.
> 
> Proposed Solution:
> A new page counter named
> 'hugetlb.xMB.reservation_[limit|usage|max_usage]_in_bytes'. This counter has
> slightly different semantics than
> 'hugetlb.xMB.[limit|usage|max_usage]_in_bytes':
> 

Changelog looks like it needs to be updated with the new resv naming.

> - While usage_in_bytes tracks all *faulted* hugetlb memory,
> reservation_usage_in_bytes tracks all *reserved* hugetlb memory and
> hugetlb memory faulted in without a prior reservation.
> 
> - If a task attempts to reserve more memory than limit_in_bytes allows,
> the kernel will allow it to do so. But if a task attempts to reserve
> more memory than reservation_limit_in_bytes, the kernel will fail this
> reservation.
> 
> This proposal is implemented in this patch series, with tests to verify
> functionality and show the usage.
> 
> Alternatives considered:
> 1. A new cgroup, instead of only a new page_counter attached to
>    the existing hugetlb_cgroup. Adding a new cgroup seemed like a lot of code
>    duplication with hugetlb_cgroup. Keeping hugetlb related page counters under
>    hugetlb_cgroup seemed cleaner as well.
> 
> 2. Instead of adding a new counter, we considered adding a sysctl that modifies
>    the behavior of hugetlb.xMB.[limit|usage]_in_bytes, to do accounting at
>    reservation time rather than fault time. Adding a new page_counter seems
>    better as userspace could, if it wants, choose to enforce different cgroups
>    differently: one via limit_in_bytes, and another via
>    reservation_limit_in_bytes. This could be very useful if you're
>    transitioning how hugetlb memory is partitioned on your system one
>    cgroup at a time, for example. Also, someone may find usage for both
>    limit_in_bytes and reservation_limit_in_bytes concurrently, and this
>    approach gives them the option to do so.
> 
> Testing:
> - Added tests passing.
> - Used libhugetlbfs for regression testing.
> 
> [1]: https://www.kernel.org/doc/html/latest/vm/hugetlbfs_reserv.html
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> Changes in v10:
> - Renamed reservation_* to resv.*
> 
> ---
>  include/linux/hugetlb.h |   4 +-
>  mm/hugetlb_cgroup.c     | 115 +++++++++++++++++++++++++++++++++++-----
>  2 files changed, 104 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 1e897e4168ac1..dea6143aa0685 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -432,8 +432,8 @@ struct hstate {
>  	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
>  #ifdef CONFIG_CGROUP_HUGETLB
>  	/* cgroup control files */
> -	struct cftype cgroup_files_dfl[5];
> -	struct cftype cgroup_files_legacy[5];
> +	struct cftype cgroup_files_dfl[7];
> +	struct cftype cgroup_files_legacy[9];
>  #endif
>  	char name[HSTATE_NAME_LEN];
>  };
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index e434b05416c68..209f9b9604d34 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -36,6 +36,11 @@ struct hugetlb_cgroup {
>  	 */
>  	struct page_counter hugepage[HUGE_MAX_HSTATE];
> 
> +	/*
> +	 * the counter to account for hugepage reservations from hugetlb.
> +	 */
> +	struct page_counter reserved_hugepage[HUGE_MAX_HSTATE];
> +
>  	atomic_long_t events[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
>  	atomic_long_t events_local[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
> 
> @@ -55,6 +60,14 @@ struct hugetlb_cgroup {
> 
>  static struct hugetlb_cgroup *root_h_cgroup __read_mostly;
> 
> +static inline struct page_counter *
> +hugetlb_cgroup_get_counter(struct hugetlb_cgroup *h_cg, int idx, bool reserved)
> +{
> +	if (reserved)
> +		return &h_cg->reserved_hugepage[idx];
> +	return &h_cg->hugepage[idx];
> +}
> +
>  static inline
>  struct hugetlb_cgroup *hugetlb_cgroup_from_css(struct cgroup_subsys_state *s)
>  {

Small nit: hugetlb_cgroup_get_counter(), to me, implies incrementing a 
reference count, perhaps a better name would be in order.  No strong 
preference.

> @@ -295,28 +308,42 @@ void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
> 
>  enum {
>  	RES_USAGE,
> +	RES_RESERVATION_USAGE,
>  	RES_LIMIT,
> +	RES_RESERVATION_LIMIT,
>  	RES_MAX_USAGE,
> +	RES_RESERVATION_MAX_USAGE,
>  	RES_FAILCNT,
> +	RES_RESERVATION_FAILCNT,
>  };
> 
>  static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
>  				   struct cftype *cft)
>  {
>  	struct page_counter *counter;
> +	struct page_counter *reserved_counter;
>  	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(css);
> 
>  	counter = &h_cg->hugepage[MEMFILE_IDX(cft->private)];
> +	reserved_counter = &h_cg->reserved_hugepage[MEMFILE_IDX(cft->private)];
> 
>  	switch (MEMFILE_ATTR(cft->private)) {
>  	case RES_USAGE:
>  		return (u64)page_counter_read(counter) * PAGE_SIZE;
> +	case RES_RESERVATION_USAGE:
> +		return (u64)page_counter_read(reserved_counter) * PAGE_SIZE;
>  	case RES_LIMIT:
>  		return (u64)counter->max * PAGE_SIZE;
> +	case RES_RESERVATION_LIMIT:
> +		return (u64)reserved_counter->max * PAGE_SIZE;
>  	case RES_MAX_USAGE:
>  		return (u64)counter->watermark * PAGE_SIZE;
> +	case RES_RESERVATION_MAX_USAGE:
> +		return (u64)reserved_counter->watermark * PAGE_SIZE;
>  	case RES_FAILCNT:
>  		return counter->failcnt;
> +	case RES_RESERVATION_FAILCNT:
> +		return reserved_counter->failcnt;
>  	default:
>  		BUG();
>  	}
> @@ -338,10 +365,16 @@ static int hugetlb_cgroup_read_u64_max(struct seq_file *seq, void *v)
>  			   1 << huge_page_order(&hstates[idx]));
> 
>  	switch (MEMFILE_ATTR(cft->private)) {
> +	case RES_RESERVATION_USAGE:
> +		counter = &h_cg->reserved_hugepage[idx];
> +		/* Fall through. */
>  	case RES_USAGE:
>  		val = (u64)page_counter_read(counter);
>  		seq_printf(seq, "%llu\n", val * PAGE_SIZE);
>  		break;
> +	case RES_RESERVATION_LIMIT:
> +		counter = &h_cg->reserved_hugepage[idx];
> +		/* Fall through. */
>  	case RES_LIMIT:
>  		val = (u64)counter->max;
>  		if (val == limit)
> @@ -365,6 +398,7 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
>  	int ret, idx;
>  	unsigned long nr_pages;
>  	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(of_css(of));
> +	bool reserved = false;
> 
>  	if (hugetlb_cgroup_is_root(h_cg)) /* Can't set limit on root */
>  		return -EINVAL;
> @@ -378,9 +412,14 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
>  	nr_pages = round_down(nr_pages, 1 << huge_page_order(&hstates[idx]));
> 
>  	switch (MEMFILE_ATTR(of_cft(of)->private)) {
> +	case RES_RESERVATION_LIMIT:
> +		reserved = true;
> +		/* Fall through. */
>  	case RES_LIMIT:
>  		mutex_lock(&hugetlb_limit_mutex);
> -		ret = page_counter_set_max(&h_cg->hugepage[idx], nr_pages);
> +		ret = page_counter_set_max(hugetlb_cgroup_get_counter(h_cg, idx,
> +								      reserved),
> +					   nr_pages);
>  		mutex_unlock(&hugetlb_limit_mutex);
>  		break;
>  	default:
> @@ -406,18 +445,26 @@ static ssize_t hugetlb_cgroup_reset(struct kernfs_open_file *of,
>  				    char *buf, size_t nbytes, loff_t off)
>  {
>  	int ret = 0;
> -	struct page_counter *counter;
> +	struct page_counter *counter, *reserved_counter;
>  	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(of_css(of));
> 
>  	counter = &h_cg->hugepage[MEMFILE_IDX(of_cft(of)->private)];
> +	reserved_counter =
> +		&h_cg->reserved_hugepage[MEMFILE_IDX(of_cft(of)->private)];
> 
>  	switch (MEMFILE_ATTR(of_cft(of)->private)) {
>  	case RES_MAX_USAGE:
>  		page_counter_reset_watermark(counter);
>  		break;
> +	case RES_RESERVATION_MAX_USAGE:
> +		page_counter_reset_watermark(reserved_counter);
> +		break;
>  	case RES_FAILCNT:
>  		counter->failcnt = 0;
>  		break;
> +	case RES_RESERVATION_FAILCNT:
> +		reserved_counter->failcnt = 0;
> +		break;
>  	default:
>  		ret = -EINVAL;
>  		break;
> @@ -472,7 +519,7 @@ static void __init __hugetlb_cgroup_file_dfl_init(int idx)
>  	struct hstate *h = &hstates[idx];
> 
>  	/* format the size */
> -	mem_fmt(buf, 32, huge_page_size(h));
> +	mem_fmt(buf, sizeof(buf), huge_page_size(h));
> 
>  	/* Add the limit file */
>  	cft = &h->cgroup_files_dfl[0];
> @@ -482,15 +529,30 @@ static void __init __hugetlb_cgroup_file_dfl_init(int idx)
>  	cft->write = hugetlb_cgroup_write_dfl;
>  	cft->flags = CFTYPE_NOT_ON_ROOT;
> 
> -	/* Add the current usage file */
> +	/* Add the reservation limit file */
>  	cft = &h->cgroup_files_dfl[1];
> +	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.resv.max", buf);
> +	cft->private = MEMFILE_PRIVATE(idx, RES_RESERVATION_LIMIT);
> +	cft->seq_show = hugetlb_cgroup_read_u64_max;
> +	cft->write = hugetlb_cgroup_write_dfl;
> +	cft->flags = CFTYPE_NOT_ON_ROOT;
> +
> +	/* Add the current usage file */
> +	cft = &h->cgroup_files_dfl[2];
>  	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.current", buf);
>  	cft->private = MEMFILE_PRIVATE(idx, RES_USAGE);
>  	cft->seq_show = hugetlb_cgroup_read_u64_max;
>  	cft->flags = CFTYPE_NOT_ON_ROOT;
> 
> +	/* Add the current reservation usage file */
> +	cft = &h->cgroup_files_dfl[3];
> +	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.resv.current", buf);
> +	cft->private = MEMFILE_PRIVATE(idx, RES_RESERVATION_USAGE);
> +	cft->seq_show = hugetlb_cgroup_read_u64_max;
> +	cft->flags = CFTYPE_NOT_ON_ROOT;
> +
>  	/* Add the events file */
> -	cft = &h->cgroup_files_dfl[2];
> +	cft = &h->cgroup_files_dfl[4];
>  	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events", buf);
>  	cft->private = MEMFILE_PRIVATE(idx, 0);
>  	cft->seq_show = hugetlb_events_show;

Any cleanup to __hugetlb_cgroup_file_dfl_init() and 
__hugetlb_cgroup_file_legacy_init() that is possible would be great in a 
follow-up patch :)

Other than that, this looks very straight forward.

Acked-by: David Rientjes <rientjes@google.com>
