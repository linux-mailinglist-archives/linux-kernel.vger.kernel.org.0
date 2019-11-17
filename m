Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8064BFFB59
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 19:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfKQS2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 13:28:37 -0500
Received: from smtprelay0004.hostedemail.com ([216.40.44.4]:40034 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726047AbfKQS2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 13:28:37 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3552418225AE5;
        Sun, 17 Nov 2019 18:28:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1978:1981:2194:2199:2393:2559:2562:2828:2914:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3872:4321:5007:6737:6738:7903:8531:8603:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12297:12438:12533:12740:12760:12895:13161:13229:13439:14096:14097:14181:14659:14721:21080:21627:21740:30030:30054:30055:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: sky31_2d41e53a0222a
X-Filterd-Recvd-Size: 4615
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 17 Nov 2019 18:28:30 +0000 (UTC)
Message-ID: <7d369058842123c3038d10a631f5fa4c3e7472ff.camel@perches.com>
Subject: Re: [PATCH v3 02/10] lib: introduce generic min max heap
From:   Joe Perches <joe@perches.com>
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Qian Cai <cai@lca.pw>, Joe Lawrence <joe.lawrence@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Date:   Sun, 17 Nov 2019 10:28:09 -0800
In-Reply-To: <20191114003042.85252-3-irogers@google.com>
References: <20191114003042.85252-1-irogers@google.com>
         <20191114003042.85252-3-irogers@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-13 at 16:30 -0800, Ian Rogers wrote:
> Based-on-work-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Perhaps some functions are a bit large for inline
and perhaps the function names are too generic?

> diff --git a/include/linux/min_max_heap.h b/include/linux/min_max_heap.h
[]
> +/* Sift the element at pos down the heap. */
> +static inline void heapify(struct min_max_heap *heap, int pos,
> +			const struct min_max_heap_callbacks *func) {
> +	void *left_child, *right_child, *parent, *large_or_smallest;
> +	char *data = (char *)heap->data;

The kernel already depends on void * arithmetic so it
seems char *data could just as well be void *data and
it might be more readable without the temporary at all.

> +
> +	for (;;) {
> +		if (pos * 2 + 1 >= heap->size)
> +			break;
> +
> +		left_child = data + ((pos * 2 + 1) * func->elem_size);
> +		parent = data + (pos * func->elem_size);
> +		large_or_smallest = parent;
> +		if (func->cmp(left_child, large_or_smallest))
> +			large_or_smallest = left_child;
> +
> +		if (pos * 2 + 2 < heap->size) {
> +			right_child = data + ((pos * 2 + 2) * func->elem_size);
> +			if (func->cmp(right_child, large_or_smallest))
> +				large_or_smallest = right_child;
> +		}
> +		if (large_or_smallest == parent)
> +			break;
> +		func->swp(large_or_smallest, parent);
> +		if (large_or_smallest == left_child)
> +			pos = (pos * 2) + 1;
> +		else
> +			pos = (pos * 2) + 2;
> +	}
> +}

[]

> +static void heap_pop_push(struct min_max_heap *heap,
> +			const void *element,
> +			const struct min_max_heap_callbacks *func)
> +{
> +	char *data = (char *)heap->data;
> +
> +	memcpy(data, element, func->elem_size);
> +	heapify(heap, 0, func);
> +}

missing inline.

> +
> +/* Push an element on to the heap, O(log2(size)). */
> +static inline void
> +heap_push(struct min_max_heap *heap, const void *element,
> +	const struct min_max_heap_callbacks *func)
> +{
> +	void *child, *parent;
> +	int pos;
> +	char *data = (char *)heap->data;

Same comment about char * vs void * and unnecessary temporary.

> +
> +	if (WARN_ONCE(heap->size >= heap->cap, "Pushing on a full heap"))
> +		return;
> +
> +	/* Place at the end of data. */
> +	pos = heap->size;
> +	memcpy(data + (pos * func->elem_size), element, func->elem_size);
> +	heap->size++;
> +
> +	/* Sift up. */
> +	for (; pos > 0; pos = (pos - 1) / 2) {
> +		child = data + (pos * func->elem_size);
> +		parent = data + ((pos - 1) / 2) * func->elem_size;
> +		if (func->cmp(parent, child))
> +			break;
> +		func->swp(parent, child);
> +	}
> +}
> +
> +#endif /* _LINUX_MIN_MAX_HEAP_H */


