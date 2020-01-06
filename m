Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC851131242
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 13:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgAFMrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 07:47:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:29680 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgAFMq7 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 07:46:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 04:46:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,402,1571727600"; 
   d="scan'208";a="232817265"
Received: from wuh-mobl.ccr.corp.intel.com (HELO [10.254.208.28]) ([10.254.208.28])
  by orsmga002.jf.intel.com with ESMTP; 06 Jan 2020 04:46:55 -0800
Subject: Re: [PATCH 1/2] perf util: Refactor block info to reduce tight
 coupling with report
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200102221959.20283-1-yao.jin@linux.intel.com>
 <20200106115751.GC207350@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <00218ad8-1343-d319-2375-83accdf153c4@linux.intel.com>
Date:   Mon, 6 Jan 2020 20:46:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200106115751.GC207350@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/6/2020 7:57 PM, Jiri Olsa wrote:
> On Fri, Jan 03, 2020 at 06:19:58AM +0800, Jin Yao wrote:
>> We have already implemented some block-info functions.
>> But these functions are tightly coupled with perf-report, it's
>> not good for reusing by other builtins (i.e. perf-diff).
>>
>> This patch refactors the functions, structures and definitions
>> to make them to be more flexible for other builtins.
> 
> it seems like a good change, but please separate it into
> more separated patches.. renames, args additions, func
> additions etc.. with explanation in changelogs
> 
> thanks,
> jirka
> 

Thanks Jiri! I will separate this one into more patches.

Thanks
Jin Yao

>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/builtin-diff.c    |  17 -----
>>   tools/perf/builtin-report.c  |  25 +++++--
>>   tools/perf/util/block-info.c | 128 +++++++++++++++++++++++++----------
>>   tools/perf/util/block-info.h |  28 +++++---
>>   4 files changed, 129 insertions(+), 69 deletions(-)
>>
>> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
>> index f8b6ae557d8b..5ff1e21082cb 100644
>> --- a/tools/perf/builtin-diff.c
>> +++ b/tools/perf/builtin-diff.c
>> @@ -572,23 +572,6 @@ static void init_block_hist(struct block_hist *bh)
>>   	bh->valid = true;
>>   }
>>   
>> -static int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)
>> -{
>> -	struct block_info *bi_a = a->block_info;
>> -	struct block_info *bi_b = b->block_info;
>> -	int cmp;
>> -
>> -	if (!bi_a->sym || !bi_b->sym)
>> -		return -1;
>> -
>> -	cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
>> -
>> -	if ((!cmp) && (bi_a->start == bi_b->start) && (bi_a->end == bi_b->end))
>> -		return 0;
>> -
>> -	return -1;
>> -}
>> -
>>   static struct hist_entry *get_block_pair(struct hist_entry *he,
>>   					 struct hists *hists_pair)
>>   {
>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>> index de988589d99b..638229bf7a08 100644
>> --- a/tools/perf/builtin-report.c
>> +++ b/tools/perf/builtin-report.c
>> @@ -104,6 +104,7 @@ struct report {
>>   	bool			symbol_ipc;
>>   	bool			total_cycles_mode;
>>   	struct block_report	*block_reports;
>> +	int			nr_block_reports;
>>   };
>>   
>>   static int report__config(const char *var, const char *value, void *cb)
>> @@ -503,7 +504,7 @@ static int perf_evlist__tui_block_hists_browse(struct evlist *evlist,
>>   		ret = report__browse_block_hists(&rep->block_reports[i++].hist,
>>   						 rep->min_percent, pos,
>>   						 &rep->session->header.env,
>> -						 &rep->annotation_opts);
>> +						 &rep->annotation_opts, true);
>>   		if (ret != 0)
>>   			return ret;
>>   	}
>> @@ -536,7 +537,7 @@ static int perf_evlist__tty_browse_hists(struct evlist *evlist,
>>   		if (rep->total_cycles_mode) {
>>   			report__browse_block_hists(&rep->block_reports[i++].hist,
>>   						   rep->min_percent, pos,
>> -						   NULL, NULL);
>> +						   NULL, NULL, true);
>>   			continue;
>>   		}
>>   
>> @@ -966,8 +967,19 @@ static int __cmd_report(struct report *rep)
>>   	report__output_resort(rep);
>>   
>>   	if (rep->total_cycles_mode) {
>> +		int block_hpps[6] = {
>> +			PERF_HPP__BLOCK_TOTAL_CYCLES_PCT,
>> +			PERF_HPP__BLOCK_LBR_CYCLES,
>> +			PERF_HPP__BLOCK_CYCLES_PCT,
>> +			PERF_HPP__BLOCK_AVG_CYCLES,
>> +			PERF_HPP__BLOCK_RANGE,
>> +			PERF_HPP__BLOCK_DSO,
>> +		};
>> +
>>   		rep->block_reports = block_info__create_report(session->evlist,
>> -							       rep->total_cycles);
>> +							       rep->total_cycles,
>> +							       block_hpps, 6,
>> +							       &rep->nr_block_reports);
>>   		if (!rep->block_reports)
>>   			return -1;
>>   	}
>> @@ -1543,8 +1555,11 @@ int cmd_report(int argc, const char **argv)
>>   		zfree(&report.ptime_range);
>>   	}
>>   
>> -	if (report.block_reports)
>> -		zfree(&report.block_reports);
>> +	if (report.block_reports) {
>> +		block_info__free_report(report.block_reports,
>> +					report.nr_block_reports);
>> +		report.block_reports = NULL;
>> +	}
>>   
>>   	zstd_fini(&(session->zstd_data));
>>   	perf_session__delete(session);
>> diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
>> index c4b030bf6ec2..55ccff2e0d5d 100644
>> --- a/tools/perf/util/block-info.c
>> +++ b/tools/perf/util/block-info.c
>> @@ -12,35 +12,36 @@
>>   #include "evlist.h"
>>   #include "hist.h"
>>   #include "ui/browsers/hists.h"
>> +#include "debug.h"
>>   
>>   static struct block_header_column {
>>   	const char *name;
>>   	int width;
>> -} block_columns[PERF_HPP_REPORT__BLOCK_MAX_INDEX] = {
>> -	[PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT] = {
>> +} block_columns[PERF_HPP__BLOCK_MAX_INDEX] = {
>> +	[PERF_HPP__BLOCK_TOTAL_CYCLES_PCT] = {
>>   		.name = "Sampled Cycles%",
>>   		.width = 15,
>>   	},
>> -	[PERF_HPP_REPORT__BLOCK_LBR_CYCLES] = {
>> +	[PERF_HPP__BLOCK_LBR_CYCLES] = {
>>   		.name = "Sampled Cycles",
>>   		.width = 14,
>>   	},
>> -	[PERF_HPP_REPORT__BLOCK_CYCLES_PCT] = {
>> +	[PERF_HPP__BLOCK_CYCLES_PCT] = {
>>   		.name = "Avg Cycles%",
>>   		.width = 11,
>>   	},
>> -	[PERF_HPP_REPORT__BLOCK_AVG_CYCLES] = {
>> +	[PERF_HPP__BLOCK_AVG_CYCLES] = {
>>   		.name = "Avg Cycles",
>>   		.width = 10,
>>   	},
>> -	[PERF_HPP_REPORT__BLOCK_RANGE] = {
>> +	[PERF_HPP__BLOCK_RANGE] = {
>>   		.name = "[Program Block Range]",
>>   		.width = 70,
>>   	},
>> -	[PERF_HPP_REPORT__BLOCK_DSO] = {
>> +	[PERF_HPP__BLOCK_DSO] = {
>>   		.name = "Shared Object",
>>   		.width = 20,
>> -	}
>> +	},
>>   };
>>   
>>   struct block_info *block_info__get(struct block_info *bi)
>> @@ -328,7 +329,7 @@ static void init_block_header(struct block_fmt *block_fmt)
>>   {
>>   	struct perf_hpp_fmt *fmt = &block_fmt->fmt;
>>   
>> -	BUG_ON(block_fmt->idx >= PERF_HPP_REPORT__BLOCK_MAX_INDEX);
>> +	BUG_ON(block_fmt->idx >= PERF_HPP__BLOCK_MAX_INDEX);
>>   
>>   	block_fmt->header = block_columns[block_fmt->idx].name;
>>   	block_fmt->width = block_columns[block_fmt->idx].width;
>> @@ -347,24 +348,24 @@ static void hpp_register(struct block_fmt *block_fmt, int idx,
>>   	INIT_LIST_HEAD(&fmt->sort_list);
>>   
>>   	switch (idx) {
>> -	case PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT:
>> +	case PERF_HPP__BLOCK_TOTAL_CYCLES_PCT:
>>   		fmt->entry = block_total_cycles_pct_entry;
>>   		fmt->cmp = block_info__cmp;
>>   		fmt->sort = block_total_cycles_pct_sort;
>>   		break;
>> -	case PERF_HPP_REPORT__BLOCK_LBR_CYCLES:
>> +	case PERF_HPP__BLOCK_LBR_CYCLES:
>>   		fmt->entry = block_cycles_lbr_entry;
>>   		break;
>> -	case PERF_HPP_REPORT__BLOCK_CYCLES_PCT:
>> +	case PERF_HPP__BLOCK_CYCLES_PCT:
>>   		fmt->entry = block_cycles_pct_entry;
>>   		break;
>> -	case PERF_HPP_REPORT__BLOCK_AVG_CYCLES:
>> +	case PERF_HPP__BLOCK_AVG_CYCLES:
>>   		fmt->entry = block_avg_cycles_entry;
>>   		break;
>> -	case PERF_HPP_REPORT__BLOCK_RANGE:
>> +	case PERF_HPP__BLOCK_RANGE:
>>   		fmt->entry = block_range_entry;
>>   		break;
>> -	case PERF_HPP_REPORT__BLOCK_DSO:
>> +	case PERF_HPP__BLOCK_DSO:
>>   		fmt->entry = block_dso_entry;
>>   		break;
>>   	default:
>> @@ -376,33 +377,42 @@ static void hpp_register(struct block_fmt *block_fmt, int idx,
>>   }
>>   
>>   static void register_block_columns(struct perf_hpp_list *hpp_list,
>> -				   struct block_fmt *block_fmts)
>> +				   struct block_fmt *block_fmts,
>> +				   int *block_hpps, int nr_hpps)
>>   {
>> -	for (int i = 0; i < PERF_HPP_REPORT__BLOCK_MAX_INDEX; i++)
>> -		hpp_register(&block_fmts[i], i, hpp_list);
>> +	for (int i = 0; i < nr_hpps; i++)
>> +		hpp_register(&block_fmts[i], block_hpps[i], hpp_list);
>>   }
>>   
>> -static void init_block_hist(struct block_hist *bh, struct block_fmt *block_fmts)
>> +static void init_block_hist(struct block_hist *bh, struct block_fmt *block_fmts,
>> +			    int *block_hpps, int nr_hpps)
>>   {
>>   	__hists__init(&bh->block_hists, &bh->block_list);
>>   	perf_hpp_list__init(&bh->block_list);
>>   	bh->block_list.nr_header_lines = 1;
>>   
>> -	register_block_columns(&bh->block_list, block_fmts);
>> +	register_block_columns(&bh->block_list, block_fmts,
>> +			       block_hpps, nr_hpps);
>>   
>> -	perf_hpp_list__register_sort_field(&bh->block_list,
>> -		&block_fmts[PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT].fmt);
>> +	/* Sort by the first fmt */
>> +	perf_hpp_list__register_sort_field(&bh->block_list, &block_fmts[0].fmt);
>>   }
>>   
>> -static void process_block_report(struct hists *hists,
>> -				 struct block_report *block_report,
>> -				 u64 total_cycles)
>> +static int process_block_report(struct hists *hists,
>> +				struct block_report *block_report,
>> +				u64 total_cycles, int *block_hpps,
>> +				int nr_hpps)
>>   {
>>   	struct rb_node *next = rb_first_cached(&hists->entries);
>>   	struct block_hist *bh = &block_report->hist;
>>   	struct hist_entry *he;
>>   
>> -	init_block_hist(bh, block_report->fmts);
>> +	block_report->fmts = calloc(nr_hpps, sizeof(struct block_fmt));
>> +	if (!block_report->fmts)
>> +		return -1;
>> +
>> +	block_report->nr_fmts = nr_hpps;
>> +	init_block_hist(bh, block_report->fmts, block_hpps, nr_hpps);
>>   
>>   	while (next) {
>>   		he = rb_entry(next, struct hist_entry, rb_node);
>> @@ -411,16 +421,19 @@ static void process_block_report(struct hists *hists,
>>   		next = rb_next(&he->rb_node);
>>   	}
>>   
>> -	for (int i = 0; i < PERF_HPP_REPORT__BLOCK_MAX_INDEX; i++) {
>> +	for (int i = 0; i < nr_hpps; i++) {
>>   		block_report->fmts[i].total_cycles = total_cycles;
>>   		block_report->fmts[i].block_cycles = block_report->cycles;
>>   	}
>>   
>>   	hists__output_resort(&bh->block_hists, NULL);
>> +	return 0;
>>   }
>>   
>>   struct block_report *block_info__create_report(struct evlist *evlist,
>> -					       u64 total_cycles)
>> +					       u64 total_cycles,
>> +					       int *block_hpps, int nr_hpps,
>> +					       int *nr_reps)
>>   {
>>   	struct block_report *block_reports;
>>   	int nr_hists = evlist->core.nr_entries, i = 0;
>> @@ -433,16 +446,40 @@ struct block_report *block_info__create_report(struct evlist *evlist,
>>   	evlist__for_each_entry(evlist, pos) {
>>   		struct hists *hists = evsel__hists(pos);
>>   
>> -		process_block_report(hists, &block_reports[i], total_cycles);
>> +		process_block_report(hists, &block_reports[i], total_cycles,
>> +				     block_hpps, nr_hpps);
>>   		i++;
>>   	}
>>   
>> +	*nr_reps = nr_hists;
>>   	return block_reports;
>>   }
>>   
>> +float block_info__total_cycles_percent(struct hist_entry *he)
>> +{
>> +	struct block_info *bi = he->block_info;
>> +
>> +	if (bi->total_cycles)
>> +		return bi->cycles * 100.0 / bi->total_cycles;
>> +
>> +	return 0.0;
>> +}
>> +
>> +void block_info__free_report(struct block_report *reps, int nr_reps)
>> +{
>> +	for (int i = 0; i < nr_reps; i++) {
>> +		hists__delete_entries(&reps[i].hist.block_hists);
>> +		if (reps[i].fmts)
>> +			free(reps[i].fmts);
>> +	}
>> +
>> +	free(reps);
>> +}
>> +
>>   int report__browse_block_hists(struct block_hist *bh, float min_percent,
>>   			       struct evsel *evsel, struct perf_env *env,
>> -			       struct annotation_options *annotation_opts)
>> +			       struct annotation_options *annotation_opts,
>> +			       bool release)
>>   {
>>   	int ret;
>>   
>> @@ -451,13 +488,17 @@ int report__browse_block_hists(struct block_hist *bh, float min_percent,
>>   		symbol_conf.report_individual_block = true;
>>   		hists__fprintf(&bh->block_hists, true, 0, 0, min_percent,
>>   			       stdout, true);
>> -		hists__delete_entries(&bh->block_hists);
>> +		if (release)
>> +			hists__delete_entries(&bh->block_hists);
>> +
>>   		return 0;
>>   	case 1:
>>   		symbol_conf.report_individual_block = true;
>>   		ret = block_hists_tui_browse(bh, evsel, min_percent,
>>   					     env, annotation_opts);
>> -		hists__delete_entries(&bh->block_hists);
>> +		if (release)
>> +			hists__delete_entries(&bh->block_hists);
>> +
>>   		return ret;
>>   	default:
>>   		return -1;
>> @@ -466,12 +507,25 @@ int report__browse_block_hists(struct block_hist *bh, float min_percent,
>>   	return 0;
>>   }
>>   
>> -float block_info__total_cycles_percent(struct hist_entry *he)
>> +int block_pair_cmp(struct hist_entry *pair, struct hist_entry *he)
>>   {
>> -	struct block_info *bi = he->block_info;
>> +	struct block_info *bi_p = pair->block_info;
>> +	struct block_info *bi_h = he->block_info;
>> +	struct map_symbol *ms_p = &pair->ms;
>> +	struct map_symbol *ms_h = &he->ms;
>> +	int cmp;
>>   
>> -	if (bi->total_cycles)
>> -		return bi->cycles * 100.0 / bi->total_cycles;
>> +	if (!ms_p->map || !ms_p->map->dso || !ms_p->sym ||
>> +	    !ms_h->map || !ms_h->map->dso || !ms_h->sym) {
>> +		return -1;
>> +	}
>>   
>> -	return 0.0;
>> +	cmp = strcmp(ms_p->sym->name, ms_h->sym->name);
>> +	if (cmp)
>> +		return -1;
>> +
>> +	if ((bi_p->start == bi_h->start) && (bi_p->end == bi_h->end))
>> +		return 0;
>> +
>> +	return -1;
>>   }
>> diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
>> index bef0d75e9819..b59b778422f3 100644
>> --- a/tools/perf/util/block-info.h
>> +++ b/tools/perf/util/block-info.h
>> @@ -32,19 +32,20 @@ struct block_fmt {
>>   };
>>   
>>   enum {
>> -	PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT,
>> -	PERF_HPP_REPORT__BLOCK_LBR_CYCLES,
>> -	PERF_HPP_REPORT__BLOCK_CYCLES_PCT,
>> -	PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
>> -	PERF_HPP_REPORT__BLOCK_RANGE,
>> -	PERF_HPP_REPORT__BLOCK_DSO,
>> -	PERF_HPP_REPORT__BLOCK_MAX_INDEX
>> +	PERF_HPP__BLOCK_TOTAL_CYCLES_PCT,
>> +	PERF_HPP__BLOCK_LBR_CYCLES,
>> +	PERF_HPP__BLOCK_CYCLES_PCT,
>> +	PERF_HPP__BLOCK_AVG_CYCLES,
>> +	PERF_HPP__BLOCK_RANGE,
>> +	PERF_HPP__BLOCK_DSO,
>> +	PERF_HPP__BLOCK_MAX_INDEX
>>   };
>>   
>>   struct block_report {
>>   	struct block_hist	hist;
>>   	u64			cycles;
>> -	struct block_fmt	fmts[PERF_HPP_REPORT__BLOCK_MAX_INDEX];
>> +	struct block_fmt	*fmts;
>> +	int			nr_fmts;
>>   };
>>   
>>   struct block_hist;
>> @@ -68,12 +69,19 @@ int block_info__process_sym(struct hist_entry *he, struct block_hist *bh,
>>   			    u64 *block_cycles_aggr, u64 total_cycles);
>>   
>>   struct block_report *block_info__create_report(struct evlist *evlist,
>> -					       u64 total_cycles);
>> +					       u64 total_cycles,
>> +					       int *block_hpps, int nr_hpps,
>> +					       int *nr_reps);
>> +
>> +void block_info__free_report(struct block_report *reps, int nr_reps);
>>   
>>   int report__browse_block_hists(struct block_hist *bh, float min_percent,
>>   			       struct evsel *evsel, struct perf_env *env,
>> -			       struct annotation_options *annotation_opts);
>> +			       struct annotation_options *annotation_opts,
>> +			       bool release);
>>   
>>   float block_info__total_cycles_percent(struct hist_entry *he);
>>   
>> +int block_pair_cmp(struct hist_entry *pair, struct hist_entry *he);
>> +
>>   #endif /* __PERF_BLOCK_H */
>> -- 
>> 2.17.1
>>
> 
