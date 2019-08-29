Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAA5A125B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 09:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfH2HLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 03:11:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:33614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727467AbfH2HLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 03:11:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7B2BAF3B;
        Thu, 29 Aug 2019 07:11:06 +0000 (UTC)
Date:   Thu, 29 Aug 2019 09:11:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Edward Chron <echron@arista.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional
 information
Message-ID: <20190829071105.GQ28313@dhcp22.suse.cz>
References: <20190826193638.6638-1-echron@arista.com>
 <20190827071523.GR7538@dhcp22.suse.cz>
 <CAM3twVRZfarAP6k=LLWH0jEJXu8C8WZKgMXCFKBZdRsTVVFrUQ@mail.gmail.com>
 <20190828065955.GB7386@dhcp22.suse.cz>
 <CAM3twVR_OLffQ1U-SgQOdHxuByLNL5sicfnObimpGpPQ1tJ0FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM3twVR_OLffQ1U-SgQOdHxuByLNL5sicfnObimpGpPQ1tJ0FQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-08-19 12:46:20, Edward Chron wrote:
[...]
> Our belief is if you really think eBPF is the preferred mechanism
> then move OOM reporting to an eBPF.

I've said that all this additional information has to be dynamically
extensible rather than a part of the core kernel. Whether eBPF is the
suitable tool, I do not know. I haven't explored that. There are other
ways to inject code to the kernel. systemtap/kprobes, kernel modules and
probably others.

> I mentioned this before but I will reiterate this here.
> 
> So how do we get there? Let's look at the existing report which we know
> has issues.
> 
> Other than a few essential OOM messages the OOM code should produce,
> such as the Killed process message message sequence being included,
> you could have the entire OOM report moved to an eBPF script and
> therefore make it customizable, configurable or if you prefer programmable.

I believe we should keep the current reporting in place and allow
additional information via dynamic mechanism. Be it a registration
mechanism that modules can hook into or other more dynamic way.
The current reporting has proven to be useful in many typical oom
situations in my past years of experience. It gives the rough state of
the failing allocation, MM subsystem, tasks that are eligible and task
that is killed so that you can understand why the event happened.

I would argue that the eligible tasks should be printed on the opt-in
bases because this is more of relict from the past when the victim
selection was less deterministic. But that is another story.

All the rest of dump_header should stay IMHO as a reasonable default and
bare minimum.

> Why? Because as we all agree, you'll never have a perfect OOM Report.
> So if you believe this, than if you will, put your money where your mouth
> is (so to speak) and make the entire OOM Report and eBPF script.
> We'd be willing to help with this.
> 
> I'll give specific reasons why you want to do this.
> 
>    - Don't want to maintain a lot of code in the kernel (eBPF code doesn't
>    count).
>    - Can't produce an ideal OOM report.
>    - Don't like configuring things but favor programmatic solutions.
>    - Agree the existing OOM report doesn't work for all environments.
>    - Want to allow flexibility but can't support everything people might
>    want.
>    - Then installing an eBPF for OOM Reporting isn't an option, it's
>    required.

This is going into an extreme. We cannot serve all cases but that is
true for any other heuristics/reporting in the kernel. We do care about
most.

> The last reason is huge for people who live in a world with large data
> centers. Data center managers are very conservative. They don't want to
> deviate from standard operating procedure unless absolutely necessary.
> If loading an OOM Report eBPF is standard to get OOM Reporting output,
> then they'll accept that.

I have already responded to this kind of argumentation elsewhere. This
is not a relevant argument for any kernel implementation. This is a data
process management process.

-- 
Michal Hocko
SUSE Labs
