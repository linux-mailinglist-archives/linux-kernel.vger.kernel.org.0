Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C745E1EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 17:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406519AbfJWPJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 11:09:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:16216 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406322AbfJWPJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:09:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 08:09:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,221,1569308400"; 
   d="scan'208";a="372903703"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by orsmga005.jf.intel.com with ESMTP; 23 Oct 2019 08:09:39 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v2 4/4] perf/x86/intel/pt: Opportunistically use single range output mode
In-Reply-To: <20191022095812.67071-5-alexander.shishkin@linux.intel.com>
References: <20191022095812.67071-1-alexander.shishkin@linux.intel.com> <20191022095812.67071-5-alexander.shishkin@linux.intel.com>
Date:   Wed, 23 Oct 2019 18:09:38 +0300
Message-ID: <87h83zh51p.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
> index 2f20d5a333c1..6edd7b785861 100644
> --- a/arch/x86/events/intel/pt.c
> +++ b/arch/x86/events/intel/pt.c
> @@ -491,7 +491,9 @@ static void pt_config(struct perf_event *event)
>  	}
>  
>  	reg = pt_config_filters(event);
> -	reg |= RTIT_CTL_TOPA | RTIT_CTL_TRACEEN;
> +	reg |= RTIT_CTL_TRACEEN;
> +	if (!buf->single)
> +		reg |= RTIT_CTL_TOPA;

This one is broken. The below is better.

From a18feffdc15957f6db0a686e51cddf69eef205c3 Mon Sep 17 00:00:00 2001
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Date: Thu, 17 Oct 2019 15:42:15 +0300
Subject: [PATCH] perf/x86/intel/pt: Opportunistically use single range output
 mode

Most of PT implementations support Single Range Output mode, which is
an alternative to ToPA that can be used for a single contiguous buffer
and if we don't require an interrupt, that is, in AUX snapshot mode.

Now that perf core will use high order allocations for the AUX buffer,
in many cases the first condition will also be satisfied.

The two most obvious benefits of the Single Range Output mode over the
ToPA are:
 * not having to allocate the ToPA table(s),
 * not using the ToPA walk hardware.

Make use of this functionality where available and appropriate.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/events/intel/pt.c | 118 ++++++++++++++++++++++++++++---------
 arch/x86/events/intel/pt.h |   2 +
 2 files changed, 92 insertions(+), 28 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 2f20d5a333c1..e6a10a5dba85 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -482,6 +482,8 @@ static u64 pt_config_filters(struct perf_event *event)
 
 static void pt_config(struct perf_event *event)
 {
+	struct pt *pt = this_cpu_ptr(&pt_ctx);
+	struct pt_buffer *buf = perf_get_aux(&pt->handle);
 	u64 reg;
 
 	/* First round: clear STATUS, in particular the PSB byte counter. */
@@ -491,7 +493,9 @@ static void pt_config(struct perf_event *event)
 	}
 
 	reg = pt_config_filters(event);
-	reg |= RTIT_CTL_TOPA | RTIT_CTL_TRACEEN;
+	reg |= RTIT_CTL_TRACEEN;
+	if (!buf->single)
+		reg |= RTIT_CTL_TOPA;
 
 	/*
 	 * Previously, we had BRANCH_EN on by default, but now that PT has
@@ -543,18 +547,6 @@ static void pt_config_stop(struct perf_event *event)
 	wmb();
 }
 
-static void pt_config_buffer(void *buf, unsigned int topa_idx,
-			     unsigned int output_off)
-{
-	u64 reg;
-
-	wrmsrl(MSR_IA32_RTIT_OUTPUT_BASE, virt_to_phys(buf));
-
-	reg = 0x7f | ((u64)topa_idx << 7) | ((u64)output_off << 32);
-
-	wrmsrl(MSR_IA32_RTIT_OUTPUT_MASK, reg);
-}
-
 /**
  * struct topa - ToPA metadata
  * @list:	linkage to struct pt_buffer's list of tables
@@ -612,6 +604,26 @@ static inline phys_addr_t topa_pfn(struct topa *topa)
 #define TOPA_ENTRY_SIZE(t, i) (sizes(TOPA_ENTRY((t), (i))->size))
 #define TOPA_ENTRY_PAGES(t, i) (1 << TOPA_ENTRY((t), (i))->size)
 
+static void pt_config_buffer(struct pt_buffer *buf)
+{
+	u64 reg, mask;
+	void *base;
+
+	if (buf->single) {
+		base = buf->data_pages[0];
+		mask = (buf->nr_pages * PAGE_SIZE - 1) >> 7;
+	} else {
+		base = topa_to_page(buf->cur)->table;
+		mask = (u64)buf->cur_idx;
+	}
+
+	wrmsrl(MSR_IA32_RTIT_OUTPUT_BASE, virt_to_phys(base));
+
+	reg = 0x7f | (mask << 7) | ((u64)buf->output_off << 32);
+
+	wrmsrl(MSR_IA32_RTIT_OUTPUT_MASK, reg);
+}
+
 /**
  * topa_alloc() - allocate page-sized ToPA table
  * @cpu:	CPU on which to allocate.
@@ -812,6 +824,11 @@ static void pt_update_head(struct pt *pt)
 	struct pt_buffer *buf = perf_get_aux(&pt->handle);
 	u64 topa_idx, base, old;
 
+	if (buf->single) {
+		local_set(&buf->data_size, buf->output_off);
+		return;
+	}
+
 	/* offset of the first region in this table from the beginning of buf */
 	base = buf->cur->offset + buf->output_off;
 
@@ -913,18 +930,21 @@ static void pt_handle_status(struct pt *pt)
  */
 static void pt_read_offset(struct pt_buffer *buf)
 {
-	u64 offset, base_topa;
+	u64 offset, base;
 	struct topa_page *tp;
 
-	rdmsrl(MSR_IA32_RTIT_OUTPUT_BASE, base_topa);
-	tp = phys_to_virt(base_topa);
-	buf->cur = &tp->topa;
+	rdmsrl(MSR_IA32_RTIT_OUTPUT_BASE, base);
+	if (!buf->single) {
+		tp = phys_to_virt(base);
+		buf->cur = &tp->topa;
+	}
 
 	rdmsrl(MSR_IA32_RTIT_OUTPUT_MASK, offset);
 	/* offset within current output region */
 	buf->output_off = offset >> 32;
 	/* index of current output region within this table */
-	buf->cur_idx = (offset & 0xffffff80) >> 7;
+	if (!buf->single)
+		buf->cur_idx = (offset & 0xffffff80) >> 7;
 }
 
 static struct topa_entry *
@@ -1040,6 +1060,9 @@ static int pt_buffer_reset_markers(struct pt_buffer *buf,
 	unsigned long head = local64_read(&buf->head);
 	unsigned long idx, npages, wakeup;
 
+	if (buf->single)
+		return 0;
+
 	/* can't stop in the middle of an output region */
 	if (buf->output_off + handle->size + 1 < pt_buffer_region_size(buf)) {
 		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
@@ -1121,13 +1144,17 @@ static void pt_buffer_reset_offsets(struct pt_buffer *buf, unsigned long head)
 	if (buf->snapshot)
 		head &= (buf->nr_pages << PAGE_SHIFT) - 1;
 
-	pg = (head >> PAGE_SHIFT) & (buf->nr_pages - 1);
-	te = pt_topa_entry_for_page(buf, pg);
+	if (!buf->single) {
+		pg = (head >> PAGE_SHIFT) & (buf->nr_pages - 1);
+		te = pt_topa_entry_for_page(buf, pg);
 
-	cur_tp = topa_entry_to_page(te);
-	buf->cur = &cur_tp->topa;
-	buf->cur_idx = te - TOPA_ENTRY(buf->cur, 0);
-	buf->output_off = head & (pt_buffer_region_size(buf) - 1);
+		cur_tp = topa_entry_to_page(te);
+		buf->cur = &cur_tp->topa;
+		buf->cur_idx = te - TOPA_ENTRY(buf->cur, 0);
+		buf->output_off = head & (pt_buffer_region_size(buf) - 1);
+	} else {
+		buf->output_off = head;
+	}
 
 	local64_set(&buf->head, head);
 	local_set(&buf->data_size, 0);
@@ -1141,6 +1168,9 @@ static void pt_buffer_fini_topa(struct pt_buffer *buf)
 {
 	struct topa *topa, *iter;
 
+	if (buf->single)
+		return;
+
 	list_for_each_entry_safe(topa, iter, &buf->tables, list) {
 		/*
 		 * right now, this is in free_aux() path only, so
@@ -1186,6 +1216,36 @@ static int pt_buffer_init_topa(struct pt_buffer *buf, int cpu,
 	return 0;
 }
 
+static int pt_buffer_try_single(struct pt_buffer *buf, int nr_pages)
+{
+	struct page *p = virt_to_page(buf->data_pages[0]);
+	int ret = -ENOTSUPP, order = 0;
+
+	/*
+	 * We can use single range output mode
+	 * + in snapshot mode, where we don't need interrupts;
+	 * + if the hardware supports it;
+	 * + if the entire buffer is one contiguous allocation.
+	 */
+	if (!buf->snapshot)
+		goto out;
+
+	if (!intel_pt_validate_hw_cap(PT_CAP_single_range_output))
+		goto out;
+
+	if (PagePrivate(p))
+		order = page_private(p);
+
+	if (1 << order != nr_pages)
+		goto out;
+
+	buf->single = true;
+	buf->nr_pages = nr_pages;
+	ret = 0;
+out:
+	return ret;
+}
+
 /**
  * pt_buffer_setup_aux() - set up topa tables for a PT buffer
  * @cpu:	Cpu on which to allocate, -1 means current.
@@ -1230,6 +1290,10 @@ pt_buffer_setup_aux(struct perf_event *event, void **pages,
 
 	INIT_LIST_HEAD(&buf->tables);
 
+	ret = pt_buffer_try_single(buf, nr_pages);
+	if (!ret)
+		return buf;
+
 	ret = pt_buffer_init_topa(buf, cpu, nr_pages, GFP_KERNEL);
 	if (ret) {
 		kfree(buf);
@@ -1396,8 +1460,7 @@ void intel_pt_interrupt(void)
 			return;
 		}
 
-		pt_config_buffer(topa_to_page(buf->cur)->table, buf->cur_idx,
-				 buf->output_off);
+		pt_config_buffer(buf);
 		pt_config_start(event);
 	}
 }
@@ -1461,8 +1524,7 @@ static void pt_event_start(struct perf_event *event, int mode)
 	WRITE_ONCE(pt->handle_nmi, 1);
 	hwc->state = 0;
 
-	pt_config_buffer(topa_to_page(buf->cur)->table, buf->cur_idx,
-			 buf->output_off);
+	pt_config_buffer(buf);
 	pt_config(event);
 
 	return;
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 1d2bb7572374..3f7818221b95 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -64,6 +64,7 @@ struct pt_pmu {
  * @lost:	if data was lost/truncated
  * @head:	logical write offset inside the buffer
  * @snapshot:	if this is for a snapshot/overwrite counter
+ * @single:	use Single Range Output instead of ToPA
  * @stop_pos:	STOP topa entry index
  * @intr_pos:	INT topa entry index
  * @stop_te:	STOP topa entry pointer
@@ -80,6 +81,7 @@ struct pt_buffer {
 	local_t			data_size;
 	local64_t		head;
 	bool			snapshot;
+	bool			single;
 	long			stop_pos, intr_pos;
 	struct topa_entry	*stop_te, *intr_te;
 	void			**data_pages;
-- 
2.23.0

