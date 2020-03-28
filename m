Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA2F7196684
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 15:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgC1OGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 10:06:38 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45981 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1OGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 10:06:37 -0400
Received: by mail-qk1-f194.google.com with SMTP id c145so13990717qke.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 07:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yZlMnYD6JqijSy564Fn87fpjw+Y3itMay1NF67PRDIo=;
        b=kShGLTXZ9/1ypJmti9uE2QCKI+tWlrSzVk6cgWkeYRd4haLeUZDrDHXvwSS7rQX4Ji
         wVTTtAGngCgnEhumeW2mdSnS/tR8Ne2FzLgCTzixXqkN+4ASa3WRGMtz79anz4CpCKt1
         ND7gKDEM+zwAcxtS1D0ASlVU0N9Tei5E1OWTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yZlMnYD6JqijSy564Fn87fpjw+Y3itMay1NF67PRDIo=;
        b=mfpSUErVbakl0kabepGybUimfjsxQU7H4EDOTFj/EDcWmb76A2O41YS9LmpQIXvVOt
         CoUl28hV4CxAGyu8SsC0eKF1cFa/PxQ/4viobtVuu4hFKQ0JP0Si6SuyNoqSTOrNiHOi
         H5vNenMiVq/5YxUGHG7428XIjMVn5oqPdXkjfD5i/mA0ev0ZilNuG1zbl6xWKFo6p6Xq
         PBpuCP0LRg+13CcxCukYE7jRAl6nBj+Cn97/F5C9W7zGKskBFvY+9QlOGVTLPWNB8hrT
         96rZ2fP2MxgE562J2+IHAmNco78FdvN4OucLJ3gXxKTRCe4LkRpsSPpIxB/mVDcaXd9e
         r/Kw==
X-Gm-Message-State: ANhLgQ1Uzfxrejv5yHLmwg9NE04Z7q69B3KljaIxmQyTEpxrY8QwgVoI
        EUim1rckKPQ2c7Wp5bLp1w5t2w==
X-Google-Smtp-Source: ADFU+vvQLa1gK5s2WAC8iuBwK3tSpdtA4/uyjFRuaqfLuLFWmj6ncKwjq5JqYfByyZnjFVPq3a+4Fw==
X-Received: by 2002:a37:9ec8:: with SMTP id h191mr4063670qke.260.1585404396878;
        Sat, 28 Mar 2020 07:06:36 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w9sm5863186qkf.28.2020.03.28.07.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 07:06:35 -0700 (PDT)
Date:   Sat, 28 Mar 2020 10:06:35 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH RFC v2 tip/core/rcu 14/22] rcu-tasks: Add an RCU Tasks
 Trace to simplify protection of tracing hooks
Message-ID: <20200328140635.GA201808@google.com>
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
 <20200319001100.24917-14-paulmck@kernel.org>
 <20200319154239.6d67877d@gandalf.local.home>
 <20200320002813.GL3199@paulmck-ThinkPad-P72>
 <20200319204838.1f78152a@gandalf.local.home>
 <20200320024152.GM3199@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320024152.GM3199@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 07:41:53PM -0700, Paul E. McKenney wrote:
> On Thu, Mar 19, 2020 at 08:48:38PM -0400, Steven Rostedt wrote:
> > On Thu, 19 Mar 2020 17:28:13 -0700
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > Good point.  If interrupts are disabled, it will need to use some
> > > other mechanism.  One approach is irqwork.  Another is a timer.
> > > 
> > > Suggestions?
> > 
> > Ftrace and perf use irq_work, I would think that should work here too.
> 
> Sounds good, will give it a go!  And thank you for catching this!

Since the the Tasks-RCU holdout thread is supposed to wake up periodically to
scan holdout tasks anyway, can it not detect the end of the Trace-RCU grace
period on its next wake up? Sorry if I missed something.

thanks,

 - Joel

