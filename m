Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C455416620B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 17:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgBTQOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 11:14:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:58024 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgBTQOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:14:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 08:14:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,464,1574150400"; 
   d="scan'208";a="283447982"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Feb 2020 08:14:11 -0800
Received: from [10.251.25.159] (kliang2-mobl.ccr.corp.intel.com [10.251.25.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 2055358056A;
        Thu, 20 Feb 2020 08:14:10 -0800 (PST)
Subject: Re: [PATCH 4/5] perf metricgroup: Support metric constraint
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        namhyung@kernel.org, ravi.bangoria@linux.ibm.com,
        yao.jin@linux.intel.com, ak@linux.intel.com
References: <1582139320-75181-1-git-send-email-kan.liang@linux.intel.com>
 <1582139320-75181-5-git-send-email-kan.liang@linux.intel.com>
 <20200220113530.GA565976@krava>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <fea147db-2af3-e9ec-fb23-f9db8cf1c77a@linux.intel.com>
Date:   Thu, 20 Feb 2020 11:14:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220113530.GA565976@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/2020 6:35 AM, Jiri Olsa wrote:
> On Wed, Feb 19, 2020 at 11:08:39AM -0800, kan.liang@linux.intel.com wrote:
> 
> SNIP
> 
>> +static bool violate_nmi_constraint;
>> +
>> +static bool metricgroup__has_constraint(struct pmu_event *pe)
>> +{
>> +	if (!pe->metric_constraint)
>> +		return false;
>> +
>> +	if (!strcmp(pe->metric_constraint, "NO_NMI_WATCHDOG") &&
>> +	    sysctl__nmi_watchdog_enabled()) {
>> +		pr_warning("Splitting metric group %s into standalone metrics.\n",
>> +			   pe->metric_name);
>> +		violate_nmi_constraint = true;
> 
> no static flags plz.. can't you just print that rest of the warning in here?
>

Because we only want to print the NMI watchdog warning once.
If there are more than one metric groups with constraint, the warning 
may be printed several times. For example,
   $ perf stat -M Page_Walks_Utilization,Page_Walks_Utilization
   Splitting metric group Page_Walks_Utilization into standalone metrics.
   Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric 
constraint:
       echo 0 > /proc/sys/kernel/nmi_watchdog
       perf stat ...
       echo 1 > /proc/sys/kernel/nmi_watchdog
   Splitting metric group Page_Walks_Utilization into standalone metrics.
   Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric 
constraint:
       echo 0 > /proc/sys/kernel/nmi_watchdog
       perf stat ...
       echo 1 > /proc/sys/kernel/nmi_watchdog
Is it OK?

If it's OK, I think we can remove the flag.

Thanks,
Kan

> jirka
> 
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>   static int metricgroup__add_metric(const char *metric, struct strbuf *events,
>>   				   struct list_head *group_list)
>>   {
>> @@ -460,7 +490,10 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
>>   			if (events->len > 0)
>>   				strbuf_addf(events, ",");
>>   
>> -			metricgroup__add_metric_weak_group(events, ids, idnum);
>> +			if (metricgroup__has_constraint(pe))
>> +				metricgroup__add_metric_non_group(events, ids, idnum);
>> +			else
>> +				metricgroup__add_metric_weak_group(events, ids, idnum);
>>   
>>   			eg = malloc(sizeof(struct egroup));
>>   			if (!eg) {
>> @@ -544,6 +577,13 @@ int metricgroup__parse_groups(const struct option *opt,
>>   	strbuf_release(&extra_events);
>>   	ret = metricgroup__setup_events(&group_list, perf_evlist,
>>   					metric_events);
>> +
>> +	if (violate_nmi_constraint) {
>> +		pr_warning("Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric constraint:\n"
>> +			   "    echo 0 > /proc/sys/kernel/nmi_watchdog\n"
>> +			   "    perf stat ...\n"
>> +			   "    echo 1 > /proc/sys/kernel/nmi_watchdog\n");
>> +	}
>>   out:
>>   	metricgroup__free_egroups(&group_list);
>>   	return ret;
>> -- 
>> 2.7.4
>>
> 
