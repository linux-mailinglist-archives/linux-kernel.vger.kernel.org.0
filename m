Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3381091B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 17:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfKYQUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 11:20:25 -0500
Received: from foss.arm.com ([217.140.110.172]:52418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728737AbfKYQUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 11:20:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2ABC331B;
        Mon, 25 Nov 2019 08:20:24 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAE243F6C4;
        Mon, 25 Nov 2019 08:20:22 -0800 (PST)
Subject: Re: [GIT PULL] scheduler changes for v5.5
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20191125125944.GA22218@gmail.com>
 <9af8a5eb-5104-ad0b-bf46-dedb65d66a07@arm.com>
 <20191125150811.GA116487@gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <d2312678-f3a1-9e22-0c95-2a161cd67bd7@arm.com>
Date:   Mon, 25 Nov 2019 16:20:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191125150811.GA116487@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2019 15:08, Ingo Molnar wrote:
> We can give testers a linearized tree for testing, should this come up 
> (which I doubt it will ...), ok?
> 

My worry (and I think Mel's) is on performance bisection of the mainline
tree (not specifically on the load balancer rework), by LKP or else. It's
not something I personally do (nor expect to do in the foreseeable future),
so Mel is much better positioned than I to argue for/against this.

Still, I was under the impression that not introducing (scheduler)
regressions in the git history was valuable. If I'm misguided, feel free to
ignore.

> Thanks,
> 
> 	Ingo
> 
