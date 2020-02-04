Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 675F7151950
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 12:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgBDLLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 06:11:08 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:33984 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726908AbgBDLLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:11:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Tp7qDKM_1580814664;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Tp7qDKM_1580814664)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Feb 2020 19:11:05 +0800
Subject: Re: [PATCH] tracing: remove unused ret
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <1579586083-45359-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200121173549.3de146d5@gandalf.local.home>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <e47edc57-b6a4-1d95-31fe-6d649c7f51f0@linux.alibaba.com>
Date:   Tue, 4 Feb 2020 19:11:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121173549.3de146d5@gandalf.local.home>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/1/22 ÉÏÎç6:35, Steven Rostedt Ð´µÀ:
> On Tue, 21 Jan 2020 13:54:43 +0800
> Alex Shi <alex.shi@linux.alibaba.com> wrote:
> 
>> No body care the variable 'ret' in function unregister_field_var_hists,
>> better to remove it.
>>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org> 
>> Cc: Ingo Molnar <mingo@redhat.com> 
>> Cc: linux-kernel@vger.kernel.org 
>> ---
>>  kernel/trace/trace_events_hist.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
>> index f62de5f43e79..0acfac95ca2a 100644
>> --- a/kernel/trace/trace_events_hist.c
>> +++ b/kernel/trace/trace_events_hist.c
>> @@ -5712,12 +5712,11 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
>>  	struct trace_event_file *file;
>>  	unsigned int i;
>>  	char *cmd;
>> -	int ret;
>>  
>>  	for (i = 0; i < hist_data->n_field_var_hists; i++) {
>>  		file = hist_data->field_var_hists[i]->hist_data->event_file;
>>  		cmd = hist_data->field_var_hists[i]->cmd;
>> -		ret = event_hist_trigger_func(&trigger_hist_cmd, file,
>> +		event_hist_trigger_func(&trigger_hist_cmd, file,
> 
> I pulled in some of your other patches (removing unused macros), but
> these that remove 'ret' I prefer not to take. Yes, we currently do not
> use ret here, but the compiler will easily remove its existence. I'm
> thinking if anything, we should report an error if they do return
> something other than success.
> 
> -- Steve
> 

Pretty make sense. :)

Thanks!
Alex

