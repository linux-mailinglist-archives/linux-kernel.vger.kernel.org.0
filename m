Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A728D166716
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 20:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgBTTZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 14:25:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:49967 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbgBTTZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:25:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 11:25:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,465,1574150400"; 
   d="scan'208";a="224963014"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 20 Feb 2020 11:25:06 -0800
Received: from [10.251.25.159] (kliang2-mobl.ccr.corp.intel.com [10.251.25.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 54F0958056A;
        Thu, 20 Feb 2020 11:25:05 -0800 (PST)
Subject: Re: [PATCH 0/5] Support metric group constraint
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, acme@kernel.org, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, namhyung@kernel.org,
        ravi.bangoria@linux.ibm.com, yao.jin@linux.intel.com
References: <1582139320-75181-1-git-send-email-kan.liang@linux.intel.com>
 <20200220113924.GB565976@krava>
 <534b4b99-466a-0a5b-e9f5-b4711abd8a4a@linux.intel.com>
 <20200220164317.GG160988@tassilo.jf.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <616a4f00-dd1f-20b2-a228-3fa9d7391016@linux.intel.com>
Date:   Thu, 20 Feb 2020 14:25:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220164317.GG160988@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/2020 11:43 AM, Andi Kleen wrote:
>> For other metric groups, even they have cycles, the issue should not be
>> triggered.
>> For example, if they have 4 or less events, the cycles can be scheduled to
>> GP counter instead.
>> If they have 6 or more events, the weak group will be reject anyway.
>> Perf tool will open it as non-group (standalone metrics).
> 
> Technically it can also happen for 9 events with Hyper Threading off or
> on Icelake (8 generic counters)
> 
> I didn't think we had any of those, but please double check.
> 

I checked all public metrics groups. Right, we don't have such metrics 
group with 8 GP events + 1 cycles.
We only need to add watchdog constraint for Page_Walks_Utilization for now.

Thanks,
Kan
