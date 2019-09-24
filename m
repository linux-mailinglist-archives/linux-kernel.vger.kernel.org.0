Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 949EEBC739
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 13:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440868AbfIXLwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 07:52:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:12281 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394463AbfIXLwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:52:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 04:52:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,544,1559545200"; 
   d="scan'208";a="179459328"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by orsmga007.jf.intel.com with ESMTP; 24 Sep 2019 04:52:44 -0700
Subject: Re: [PATCH RFC 1/2] perf tools: Support single perf.data file
 directory
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20190916085646.6199-1-adrian.hunter@intel.com>
 <20190916085646.6199-2-adrian.hunter@intel.com>
 <20190923213427.GB12521@krava>
 <766e6c36-c03f-0d9c-2983-565eb6a897bb@intel.com>
 <20190924111232.GA10113@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9b283364-0d58-40c0-80ff-b01c31cafd0f@intel.com>
Date:   Tue, 24 Sep 2019 14:51:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924111232.GA10113@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/19 2:12 PM, Jiri Olsa wrote:
> On Tue, Sep 24, 2019 at 12:12:25PM +0300, Adrian Hunter wrote:
>> On 24/09/19 12:34 AM, Jiri Olsa wrote:
>>> On Mon, Sep 16, 2019 at 11:56:45AM +0300, Adrian Hunter wrote:
>>>> Support directory output that contains a regular perf.data file. This is
>>>> preparation for adding support for putting a copy of /proc/kcore in that
>>>> directory.
>>>>
>>>> Distinguish the multiple file case from the regular (single) perf.data file
>>>> case by adding data->is_multi_file.
>>>
>>> SNIP
>>>
>>>>  static int open_file_read(struct perf_data *data)
>>>>  {
>>>>  	struct stat st;
>>>> @@ -302,12 +312,17 @@ static int open_dir(struct perf_data *data)
>>>>  {
>>>>  	int ret;
>>>>  
>>>> -	/*
>>>> -	 * So far we open only the header, so we can read the data version and
>>>> -	 * layout.
>>>> -	 */
>>>> -	if (asprintf(&data->file.path, "%s/header", data->path) < 0)
>>>> -		return -1;
>>>> +	if (perf_data__is_multi_file(data)) {
>>>> +		/*
>>>> +		 * So far we open only the header, so we can read the data version and
>>>> +		 * layout.
>>>> +		 */
>>>> +		if (asprintf(&data->file.path, "%s/header", data->path) < 0)
>>>> +			return -1;
>>>> +	} else {
>>>> +		if (asprintf(&data->file.path, "%s/perf.data", data->path) < 0)
>>>> +			return -1;
>>>> +	}
>>>
>>
>> Thanks for replying :-)
>>
>>> first, please note that there's support for perf.data directory code,
>>> but it's not been enabled yet, so we can do any changes there without
>>> breaking existing users
>>>
>>> currently the logic is prepared to have perf.data DIR_FORMAT feature
>>> to define the layout of the directory
>>>
>>> it'd be great to have just single point where we get directory layout,
>>> not checking on files names first and checking on DIR_FORMAT later
>>
>> Ok, but what are you suggesting?  Naming the data file "header" seems a bit
>> counter-intuitive in this case.
> 
> don't know ;-)

So what about calling it "data" instead of "header"?

> 
> but I'd like to have one way of finding out the directory layout
> 
> the code for threaded record uses DIR_FORMAT feature value
> to ensure the directory contains the expected files, which
> is data file with 'data.<cpu>' name for every cpu
> 
>>
>>>
>>> also the kcore will be beneficial for other layouts,
>>> so would be great to make it somehow optional/switchable
>>
>> In these patches it is, because it is not related to the DIR_FORMAT.
>>
>>> one of the options could be to have DIR_FORMAT feature as the source
>>> of directory layout and it'd have bitmask of files/dirs (like kcore_dir)
>>> available in the directory
>>
>> Is there an advantage to making optional files/dirs part of the format?
>> i.e. if they are there, use them otherwise don't.
> 
> ok, that might work, but please make that somehow explicit/visible
> what files/directories are possible in the directory, so we could
> easily see them and add new ones

At the moment, what can exist is what can be removed i.e. see
rm_rf_perf_data().  Will that do?

