Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 412ECA8468
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 15:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbfIDNVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 09:21:52 -0400
Received: from foss.arm.com ([217.140.110.172]:54856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729020AbfIDNVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:21:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3497528;
        Wed,  4 Sep 2019 06:21:51 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 935123F59C;
        Wed,  4 Sep 2019 06:21:49 -0700 (PDT)
Subject: Re: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
To:     Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Jirka_Hladk=c3=bd?= <jhladky@redhat.com>,
        =?UTF-8?B?SmnFmcOtIFZvesOhcg==?= <jvozar@redhat.com>,
        x86@kernel.org
References: <20190903154340.860299-1-rkrcmar@redhat.com>
 <20190903154340.860299-3-rkrcmar@redhat.com>
 <20190904131309.GS2332@hirez.programming.kicks-ass.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <07518d3f-cfa8-d6a5-2a13-4d8a7457ee15@arm.com>
Date:   Wed, 4 Sep 2019 14:21:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904131309.GS2332@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2019 14:13, Peter Zijlstra wrote:
> On Tue, Sep 03, 2019 at 05:43:40PM +0200, Radim Krčmář wrote:
> 
>> Red Hat adapted one of them for the tracepoint framework and created a
>> tool to plot a heatmap of nr_running, where the sched_update_nr_running
>> tracepoint is being used for fine grained monitoring of scheduling
>> imbalance.
> 
> You should be able to reconstruct this from wakeup and switch
> tracepoints.
> 
> 

I never tried to do it myself but know some folks around me gave it a go
(Morten, Qais and maybe even Chris). I can't remember the exact details but
there was something about not getting the right input - duplicated wakeups,
or no migration information (I think sched_migrate doesn't cover all of the
cases) so the information you're building diverges as time progresses.
