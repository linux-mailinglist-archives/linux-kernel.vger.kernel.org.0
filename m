Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6CFD10A0C0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 15:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfKZOxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 09:53:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:60015 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfKZOxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:53:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 06:53:30 -0800
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; 
   d="scan'208";a="202740122"
Received: from pmaziarx-mobl.ger.corp.intel.com (HELO [10.237.142.147]) ([10.237.142.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Nov 2019 06:53:28 -0800
Subject: Re: [PATCH v2 2/2] tracing: Use seq_buf_hex_dump() to dump buffers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        andriy.shevchenko@intel.com, cezary.rojewski@intel.com,
        gustaw.lewandowski@intel.com
References: <1573130738-29390-1-git-send-email-piotrx.maziarz@linux.intel.com>
 <1573130738-29390-2-git-send-email-piotrx.maziarz@linux.intel.com>
 <20191113160922.1b1f0fc0@gandalf.local.home>
From:   Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Message-ID: <61e34d88-bbf7-a2ff-e983-64dc9be1a482@linux.intel.com>
Date:   Tue, 26 Nov 2019 15:53:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191113160922.1b1f0fc0@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-13 22:09, Steven Rostedt wrote:
> OK, so the __print_hex_dump() will be exported to the format files.
> 
> Would you be willing to add a function to handle __print_hex_dump() in
> tools/lib/traceevent/event-parse.c, like __print_flags(),
> __print_symbolic(), and other __print_*() functions are handled. This
> will allow trace-cmd and perf to be able to parse the data when you
> used it via the userspace tools.
> 
> This can be a separate patch, but ideally before any trace events start
> using this.
> 
> Thanks,
> 
> -- Steve
> 

Hello Steven,

I'm writing handle in event-parse and I came across some technical 
problems. I have an event which print function looks like that:
TP_printk("%s",
	  __print_hex_dump("", DUMP_PREFIX_OFFSET, 16, 4,
			   __get_dynamic_array(buf),
			   __get_dynamic_array_len(buf), false))
It works properly when printing events to debugfs.
I'm testing my implementation with trace-cmd and it has problem with 
parsing DUMP_PREFIX_OFFSET and false (I'm using 
alloc_and_process_delim()). Instead of having numerical values 
tep_print_args are of type TEP_PRINT_ATOM and have char array 
"DUMP_PREFIX_OFFSET" or "true".
Am I doing something incorrect? Parsing it this way is problematic 
because instead of false someone may use 0 or logic expression. And 
writing it to support all possible scenarios may be tedious and prone to 
errors.

Best regards,
Piotr Maziarz
