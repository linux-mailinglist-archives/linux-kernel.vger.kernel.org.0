Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 481C04D0AB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 16:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbfFTOrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 10:47:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:31936 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbfFTOrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:47:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 07:47:35 -0700
X-IronPort-AV: E=Sophos;i="5.63,397,1557212400"; 
   d="scan'208";a="168536316"
Received: from tzanussi-mobl.amr.corp.intel.com (HELO [10.251.131.111]) ([10.251.131.111])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 20 Jun 2019 07:47:35 -0700
Subject: Re: No invalid histogram error
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
References: <20190620211737.993b09619af1fc58222549b4@kernel.org>
From:   "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Message-ID: <27753f6a-9467-4dd0-d1b6-db75e577e693@linux.intel.com>
Date:   Thu, 20 Jun 2019 09:47:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190620211737.993b09619af1fc58222549b4@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On 6/20/2019 7:17 AM, Masami Hiramatsu wrote:
> Hi Tom,
>
> I'm trying to use histogram on a synthetic event, but faced an odd situation.
>
> There is a synthetic event, which has foo and bar.
>
> /sys/kernel/debug/tracing # cat synthetic_events
> testevent	int foo; int bar
>
> And when I tried to add hist on trigger, both foo and bar can be used as below.
>
> /sys/kernel/debug/tracing # echo "hist:keys=bar" > events/synthetic/testevent/trigger
> /sys/kernel/debug/tracing # echo "hist:keys=foo" > events/synthetic/testevent/trigger
>
> And, when I missed to specify the sort key, it failed
>
> /sys/kernel/debug/tracing # echo "hist:keys=foo:sort=bar" > events/synthetic/testevent/trigger
> sh: write error: Invalid argument
>
> But no error on error_log file.
>
> /sys/kernel/debug/tracing # cat error_log
> /sys/kernel/debug/tracing #
>
> Could you add some error message? What about below?
>
> [ 5422.134656] hist:synthetic:testevent: error: Sort key must be one of keys.
>    Command: keys=foo;sort=bar
>                                 ^


Sure, I'll submit a fix for this.  Thanks for pointing it out.


Tom


> Thank you,
>
>
