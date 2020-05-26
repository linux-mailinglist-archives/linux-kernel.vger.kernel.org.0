Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6A2199E10
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 20:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgCaSaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 14:30:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35261 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCaSaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:30:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id k13so24174083qki.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 11:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vpb/cMyQD5Zo4JQ2UWkdtHGDLvczJA9/XzTeGPZlpgM=;
        b=Qvyi7OOQEkQRWwq5xobI9577YfQouxLrII5rvPzBuzP/TuY+H9ixEtIRjNbQcHSMQf
         8APCGN9bJkv3u7ws6kcuW0Gf5Xx4Qsl4JVhTDC7ey1Pu8IyWaYV8f7JoaqWzP8+QKdfo
         3EHhQ6VHo06IXOBZvhoIh3FD28sa4BnrYJUJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vpb/cMyQD5Zo4JQ2UWkdtHGDLvczJA9/XzTeGPZlpgM=;
        b=V93PqI88ta9TJake/B9X/ViwhF824b4xkfIHDsQh2VL9ObTxsW4Y329HHFOoFzVDI/
         bazJtTW7oeh1eKJiQkk6owfWe9PGDuw6nvbHmXva+8Gop0af7SHAJ2ON75vL50AiHh/J
         WL+bLqVu/5P8/fCEu+S3NVygeCIqcumGP8Iq2C3DrIeP+WQFzhfne5Sp1CvZIL76vS/5
         QqTjH9wRkf+Idna045UDPd5pHIigLHmC5Pokaq8m3cWN/uik3k478yo0s2/yexoXOTBE
         V09cXf863bcHXAm7t56i0Jiww1nWwKl7oC/SV3e533mrhySqNIqIKHL3RVW6j/vlAuPO
         Hqkw==
X-Gm-Message-State: ANhLgQ1RQX0YXWCAYvyk8rh/DqyZ5ZT4UegyiZ/m5HA/gNxGqK9ltJiR
        NuOteXR+mm2UTHC9cjWgeaDutw==
X-Google-Smtp-Source: ADFU+vvL6mZs5FR5oEoFfeBjpSbgijxtjHRLIkFn/n6pC8EdI6o02wIgOx2Jp0J5NDeXKOPEphnoaQ==
X-Received: by 2002:a37:4dc8:: with SMTP id a191mr6528234qkb.450.1585679401510;
        Tue, 31 Mar 2020 11:30:01 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d22sm14457711qte.93.2020.03.31.11.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 11:30:01 -0700 (PDT)
Date:   Tue, 31 Mar 2020 14:30:00 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200331183000.GD236678@google.com>
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331140433.GA26498@pc636>
 <20200331150911.GC236678@google.com>
 <20200331160119.GA27614@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331160119.GA27614@pc636>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 06:01:19PM +0200, Uladzislau Rezki wrote:
> > 
> > Yes, I mean __GFP_MEMALLOC. Sorry, the patch was just to show the idea and
> > marked as RFC.
> > 
> > Good point on the atomic aspect of this path, you are right we cannot sleep.
> > I believe the GFP_NOWAIT I mentioned in my last reply will take care of that?
> > 
> I think there should be GFP_ATOMIC used, because it has more chance to
> return memory then GFP_NOWAIT. I see that Michal has same view on it.

I don't think so because GFP_ATOMIC implies GFP_NOWAIT. I am Ok with keeping
the GFP_ATOMIC as it is btw. Paul mentioned he prefers this. I agree with
that as well.

> > > As for removing __GFP_NOWARN. Actually it is expectable that an
> > > allocation can fail, if so we follow last emergency case. You
> > > can see the trace but what would you do with that information?
> > 
> > Yes, the benefit of the trace/warning is that the user can switch to a
> > non-headless API and avoid the synchronize_rcu(), that would help them get
> > faster kfree_rcu() performance instead of having silent slowdowns.
> > 
> Agree. What about just adding WARN_ON_ONCE()? I am just thinking if it
> could be harmful or not.

You mean WARN_ON_ONCE() before the synchronize_rcu() right? We could do that.
Paul mentioned to me he prefers if this new warning can be turned off with a
boot parameter since some future user may prefer no warning. I also agree.

If we add this then we can keep your __GFP_NOWARN flag with no additional GFP
flag changes.

> > It also tells us whether the headless API is worth it in the long run, I
> > think it is worth it because we will likely never hit the synchronize_rcu()
> > failsafe. But if we hit it a lot, at least it wont happen silently.
> > 
> Agree.
> 
> > Paul was concerned about following scenario with hitting synchronize_rcu():
> > 1. Consider a system under memory pressure.
> > 2. Consider some other subsystem X depending on another system Y which uses
> >    kfree_rcu(). If Y doesn't complete the operation in time, X accumulates
> >    more memory.
> > 3. Since kfree_rcu() on Y hits synchronize_rcu() a lot, it slows it down.
> >    This causes X to further allocate memory, further causing a chain
> >    reaction.
> > Paul, please correct me if I'm wrong.
> > 
> I see your point and agree that in theory it can happen. So, we should
> make it more tight when it comes to rcu_head attachment logic.

Right. Per discussion with Paul, we discussed that it is better if we
pre-allocate N number of array blocks per-CPU and use it for the cache.
Default for N being 1 and tunable with a boot parameter. I agree with this.

In current code, we have 1 cache page per CPU, but this is allocated only on
the first kvfree_rcu() request. So we could change this behavior as well to
make it pre-allocated.

Does this all sound good to you?

thanks,

 - Joel

