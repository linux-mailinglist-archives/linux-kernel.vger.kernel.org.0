Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5994310512A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 12:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfKULLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 06:11:35 -0500
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:59779 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726165AbfKULLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:11:35 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id B400F18224D7B;
        Thu, 21 Nov 2019 11:11:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:1978:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3868:4321:5007:6737:6738:10004:10400:10848:11026:11232:11658:11914:12043:12048:12297:12438:12533:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21433:21627:21740:30054:30055:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: team37_64653de87240c
X-Filterd-Recvd-Size: 2559
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu, 21 Nov 2019 11:11:29 +0000 (UTC)
Message-ID: <6f444819493c5d55fee3871fcb7c067085726c2d.camel@perches.com>
Subject: Re: [PATCH v4 02/10] lib: introduce generic min max heap
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
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Date:   Thu, 21 Nov 2019 03:11:06 -0800
In-Reply-To: <20191116011845.177150-3-irogers@google.com>
References: <20191114003042.85252-1-irogers@google.com>
         <20191116011845.177150-1-irogers@google.com>
         <20191116011845.177150-3-irogers@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-15 at 17:18 -0800, Ian Rogers wrote:
> Supports push, pop and converting an array into a heap.
> Based-on-work-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[]
> diff --git a/include/linux/min_max_heap.h b/include/linux/min_max_heap.h
[]
> +/* Sift the element at pos down the heap. */
> +static inline void min_max_heapify(struct min_max_heap *heap, int pos,
> +				const struct min_max_heap_callbacks *func)

s/inline/__always_inline/g

> +static void min_max_heap_pop_push(struct min_max_heap *heap,
> +				const void *element,
> +				const struct min_max_heap_callbacks *func)

And this still misses the inline attribute


