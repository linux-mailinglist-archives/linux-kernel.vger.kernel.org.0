Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 282F71101C4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 17:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfLCQEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 11:04:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfLCQEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:04:30 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF74D2068E;
        Tue,  3 Dec 2019 16:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575389070;
        bh=oDFsbxgD5A95Nwp80yYyEw0eJtZ1q1iqcErmr0CW5MU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HXbIwJZ4oEv1QVPreYfTg5bdyyYy94SFdJXuK7e5llmpYJ7ol0IsP3yeriHTiLXO8
         NXgbFYOFEt8jkly/wdaKIcL8Oj24gLOuzZAyLf8ZK8LXwC5JOuc5AUb5U1Pa1q1O9v
         y/R363m0AqGL+UdeaoJXaNj9RRE2FkLT4RlQ63ZY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9D4A93522780; Tue,  3 Dec 2019 08:04:24 -0800 (PST)
Date:   Tue, 3 Dec 2019 08:04:24 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191203160424.GD2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191125230312.GP2889@paulmck-ThinkPad-P72>
 <20191126183334.GE2867037@devbig004.ftw2.facebook.com>
 <20191126220533.GU2889@paulmck-ThinkPad-P72>
 <20191127155027.GA15170@paulmck-ThinkPad-P72>
 <20191128161823.GA24667@paulmck-ThinkPad-P72>
 <20191129155850.GA17002@paulmck-ThinkPad-P72>
 <20191202015548.GA13391@paulmck-ThinkPad-P72>
 <20191202201338.GH16681@devbig004.ftw2.facebook.com>
 <20191203095521.GH2827@hirez.programming.kicks-ass.net>
 <20191203154251.GC2196666@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203154251.GC2196666@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 07:42:51AM -0800, Tejun Heo wrote:
> Hello,
> 
> On Tue, Dec 03, 2019 at 10:55:21AM +0100, Peter Zijlstra wrote:
> > The below seems to not insta explode...
> 
> Paul, any chance you can run Peter's patch through your test?

I will give it a shot and report results late tomorrow morning,
Pacific Time.  (Yeah, slow, but beats the several-month test duration
that would have been required previously!)

							Thanx, Paul
