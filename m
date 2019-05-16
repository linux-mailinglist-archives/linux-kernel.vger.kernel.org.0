Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A04E1FE29
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 05:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfEPDcD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 May 2019 23:32:03 -0400
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:34336 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726218AbfEPDcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 23:32:03 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 May 2019 23:32:02 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 1F1728124C98
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 03:24:47 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 4500C182CED28;
        Thu, 16 May 2019 03:24:46 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,rostedt@goodmis.org,:::::::,RULES_HIT:41:152:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1513:1515:1516:1518:1521:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2693:2903:3138:3139:3140:3141:3142:3353:3865:3866:3867:3868:3870:3871:3872:3873:3874:4362:5007:7652:7875:7903:9036:10004:10400:10848:11026:11232:11473:11658:11914:12043:12438:12555:12895:13069:13311:13357:14096:14097:14181:14721:14777:21080:21627:21740:30026:30054:30070:30083:30090,0,RBL:50.233.106.81:@goodmis.org:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: bee45_c789c6f4c840
X-Filterd-Recvd-Size: 2640
Received: from [172.30.16.70] (unknown [50.233.106.81])
        (Authenticated sender: rostedt@goodmis.org)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 16 May 2019 03:24:45 +0000 (UTC)
Date:   Wed, 15 May 2019 20:24:43 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190516120529.4c1f6e6ddd516185df149625@kernel.org>
References: <1553106531-3281-1-git-send-email-divya.indi@oracle.com> <1553106531-3281-2-git-send-email-divya.indi@oracle.com> <20190516090942.75f3a957ceed20201edc91a6@kernel.org> <a96e884d-534f-65ef-8f82-85cd52953695@oracle.com> <20190516120529.4c1f6e6ddd516185df149625@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] tracing: Kernel access to Ftrace instances
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Divya Indi <divya.indi@oracle.com>
CC:     linux-kernel@vger.kernel.org, Joe Jin <joe.jin@oracle.com>
From:   Steven Rostedt <rostedt@goodmis.org>
Message-ID: <F331FDC8-9E63-4042-A933-BDC197C9A031@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On May 15, 2019 8:05:29 PM PDT, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
>> >> diff --git a/kernel/trace/trace_events.c
>b/kernel/trace/trace_events.c
>> >> index 5b3b0c3..81c038e 100644
>> >> --- a/kernel/trace/trace_events.c
>> >> +++ b/kernel/trace/trace_events.c
>> >> @@ -832,6 +832,7 @@ static int ftrace_set_clr_event(struct
>trace_array *tr, char *buf, int set)
>> >>   
>> >>   	return ret;
>> >>   }
>> >> +EXPORT_SYMBOL_GPL(ftrace_set_clr_event);
>> > I found this exports a static function to module. Did it work?
>> 
>> I had tested the changes with my module. This change to static was
>added 
>> in the test patch, but somehow missed it in the final patch that was 
>> sent out.
>
>If you can send some example module patch under samples/, that is more
>helpful for us to check it. And it is possible to use in kselftest too.
>
>> 
>> Will send a new patch along with a few additional ones to add some
>NULL 
>> checks to ensure safe usage by modules and add the APIs to a header
>file 
>> that can be used by the modules.
>
>It seems your's already in Steve's ftrace/core branch, so I think you
>can make
>additional patch to fix it. Steve, is that OK?
>

Yes. In fact I already sent a pull request to Linus.  Please send a patch on top of my ftrace/core branch.


Thanks,

-- Steve

>Thank you,
>
>> 
>> Thanks,
>> 
>> Divya
>> 
>> >
>> > Thank you,
>> >

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity and top posting.
