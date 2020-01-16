Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7743113D301
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 05:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbgAPEGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 23:06:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38997 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbgAPEGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 23:06:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id q10so9553955pfs.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 20:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R3OaHJ/NoHo97qXRlJsk6XbKoJmXhoMLhGPLnTVZhRI=;
        b=UWtMAmokJ/P3d7sD2bmYBARu+1sTAP0qHRJ+jyvjczeS0igyZpJ7Pt1ZW27HzvPEtC
         Qo4e08NcyYbEKQ1o6NW+RInhKWixcbZ0JWw+ToAOCkjpbsioshu+xNiq3jDCiyc0k+0v
         V68XXLdKiWKW0S+JUsOTO8tFBazj8S9TUPpkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R3OaHJ/NoHo97qXRlJsk6XbKoJmXhoMLhGPLnTVZhRI=;
        b=aiDb8RCO+U94ZX3YzBBDzOq4Ck6c7k5BwhT/dcjxJQ5j/50ahm0eh/rz3TmQyHU9Hy
         E/eggk5rGz9OtTox5bFgqL6q1ZZpuCEEG2xYv1S7y0jWxUo7iWKoVJhSA4yHVtvh91R5
         MT1/u3Hw9lCqMKWhaqKZfN61YCcLDHNXetG+Idzn3ZvhCoIZdRzZeY1qKxKf8YTtcLyy
         x2eFAtwZUozqMrZwrdU5J6t50b0J9ZT6ynwefTrFQhz7blh+p8v3vGpj6KoqY3ujhrHk
         qMuLz59zRaTPpVPf+4XC3s83iLHE9NuS3rcv7QBYIzb1+gUnPKKhO0fS/XzFUzeND5Ba
         WTig==
X-Gm-Message-State: APjAAAW1mIbmHjV8vlWp7lQXzrz3cQY70YVInWnfIJvbOgqfy+la6tcI
        eYilksPYoInA2/RY5glV4Wy1dw==
X-Google-Smtp-Source: APXvYqzbpu+zEroh1lCJNK2RswLPoOkrbl0hdO0L1TFDlTlzeRdWYeqQT/qEldakCQJ9/tQN5n8TmA==
X-Received: by 2002:a63:a555:: with SMTP id r21mr36221700pgu.158.1579147560046;
        Wed, 15 Jan 2020 20:06:00 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e15sm785798pja.13.2020.01.15.20.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 20:05:59 -0800 (PST)
Date:   Wed, 15 Jan 2020 23:05:58 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bristot@redhat.com,
        frextrite@gmail.com, madhuparnabhowmik04@gmail.com,
        urezki@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 rcu-dev] rcuperf: Measure memory footprint during
 kfree_rcu() test
Message-ID: <20200116040558.GD246464@google.com>
References: <20191219211349.235877-1-joel@joelfernandes.org>
 <20191221000729.GH2889@paulmck-ThinkPad-P72>
 <20191221033714.GB156579@google.com>
 <20200106195200.GS13449@paulmck-ThinkPad-P72>
 <20200115220300.GA94036@google.com>
 <20200115224251.GK2935@paulmck-ThinkPad-P72>
 <20200115224542.GB94036@google.com>
 <20200116000104.GO2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116000104.GO2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 04:01:04PM -0800, Paul E. McKenney wrote:
> On Wed, Jan 15, 2020 at 05:45:42PM -0500, Joel Fernandes wrote:
> > On Wed, Jan 15, 2020 at 02:42:51PM -0800, Paul E. McKenney wrote:
> > > > [snip]
> > > > > > We can certainly refine it further but at this time I am thinking of spending
> > > > > > my time reviewing Lai's patches and learning some other RCU things I need to
> > > > > > catch up on. If you hate this patch too much, we can also defer this patch
> > > > > > review for a bit and I can carry it in my tree for now as it is only a patch
> > > > > > to test code. But honestly, in its current form I am sort of happy with it.
> > > > > 
> > > > > OK, I will keep it as is for now and let's look again later on.  It is not
> > > > > in the bucket for the upcoming merge window in any case, so we do have
> > > > > quite a bit of time.
> > > > > 
> > > > > It is not that I hate it, but rather that I want to be able to give
> > > > > good answers to questions that might come up.  And given that I have
> > > > > occasionally given certain people a hard time about their statistics,
> > > > > it is only reasonable to expect them to return the favor.  I wouldn't
> > > > > want you to be caught in the crossfire.  ;-)
> > > > 
> > > > Since the weights were concerning, I was thinking of just using a weight of
> > > > (1 / N) where N is the number of samples. Essentially taking the average.
> > > > That could be simple enough and does not cause your concerns with weight
> > > > tuning. I tested it and looks good, I'll post it shortly.
> > > 
> > > YES!!!  ;-)
> > > 
> > > Snapshot mem_begin before entering the loop.  For the mean value to
> > > be solid, you need at least 20-30 samples, which might mean upping the
> > > default for kfree_loops.  Have an "unsigned long long" to accumulate the
> > > sum, which should avoid any possibility of overflow for current systems
> > > and for all systems for kfree_loops less than PAGE_SIZE.  At which point,
> > > forget the "%" stuff and just sum up the si_mem_available() on each pass
> > > through the loop.
> > > 
> > > Do the division on exit from the loop, preferably checking for divide
> > > by zero.
> > > 
> > > Straightforward, fast, reasonably reliable, and easy to defend.
> > 
> > I mostly did it along these lines. Hopefully the latest posting is reasonable
> > enough ;-) I sent it twice because I messed up the authorship (sorry).
> 
> No problem with the authorship-fix resend!
> 
> But let's get this patch consistent with basic statistics!
> 
> You really do need 20-30 samples for an average to mean much.
> 
> Of course, right now you default kfree_loops to 10.  You are doing
> 8000 kmalloc()/kfree_rcu() loops on each pass.  This is large enough
> that just dropping the "% 4" should be just fine from the viewpoint of
> si_mem_available() overhead.  But 8000 allocations and frees should get
> done in way less than one second, so kicking the default kfree_loops up
> to 30 should be a non-problem.
> 
> Then the patch would be both simpler and statistically valid.
> 
> So could you please stop using me as the middleman in your fight with
> the laws of mathematics and get this patch to a defensible state?  ;-)

The thing is the signal doesn't vary much. I could very well just take one
out of the 4 samples and report that. But I still took the average since
there are 4 samples. I don't see much point in taking more samples here since
I am not concerned that the signal will fluctuate much (and if it really
does, then I can easily catch that kind of variation with multiple rcuperf
runs).

But if you really want though, I can increase the sampling to 20 samples or a
number like that and resend it.

thanks,

 - Joel

