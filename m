Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0154C36D3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 16:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388689AbfJAOPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 10:15:31 -0400
Received: from foss.arm.com ([217.140.110.172]:50592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfJAOPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:15:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 305A11000;
        Tue,  1 Oct 2019 07:15:30 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 292883F71A;
        Tue,  1 Oct 2019 07:15:29 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] sched/fair: Active balancer RT/DL preemption fix
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        tglx@linutronix.de, qais.yousef@arm.com,
        Steven Rostedt <rostedt@goodmis.org>
References: <20190815145107.5318-1-valentin.schneider@arm.com>
 <b442e1b5-a800-5dde-2e42-e4981089edf4@arm.com>
 <20191001133115.GC6481@localhost.localdomain>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <c4f7940e-8a8a-378e-ca02-034e3b7348ef@arm.com>
Date:   Tue, 1 Oct 2019 15:15:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001133115.GC6481@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juri,

On 01/10/2019 14:31, Juri Lelli wrote:
> Hi Valentin,
> 
> On 01/10/19 11:29, Valentin Schneider wrote:
>> (expanded the Cc list)
>> RT/DL folks, any thought on the thing?
> 
> Even if I like your idea and it looks theoretically the right thing to
> do, I'm not sure we want it in practice if it adds complexity to CFS.
> 
> I personally never noticed this kind of interference from CFS, but, at
> the same time, for RT we usually like more to be safe than sorry.
> However, since this doesn't seem to be bullet-proof (as you also say), I
> guess it all boils down again to complexity vs. practical benefits.
> 

Thanks for having a look.

IMO worst part is the local detach_one_task() thing, I added that after v1
following Qais' comments but perhaps it doesn't gain us much.

I'll try to cook something up with rt-app and see if I can get sensible
numbers.

> Best,
> 
> Juri
> 
