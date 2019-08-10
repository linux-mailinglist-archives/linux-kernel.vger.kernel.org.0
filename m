Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 147F3887C6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 05:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfHJDw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 23:52:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44382 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfHJDwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 23:52:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so47012793pfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 20:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=15NUEIPfxy4LwRR5TelorS+dS62B8jUUdc5s/lNpmxI=;
        b=JJQhMIVDZyr61jL4+f0TUFnFam9hy7bgwggkDHwyCmuEcBayW4l6xwLvxsW5Pp1nnp
         IHy9L9krlpmljpez5yhql+96E0ryjyQLsyuSa23kbZed6b81LQwZJnrJpGLywb7tn3j5
         F7dBgJ+jMkstjp2U3vzVqUTJtdETiobaHbQwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=15NUEIPfxy4LwRR5TelorS+dS62B8jUUdc5s/lNpmxI=;
        b=aHub3ZCraYHdICrK9cO4WMH19xx1+EGGzPLW0MQ7H9CxPg7HyOgmOB0NXGd823pHmv
         nje589oK5gWTZJnyfpirN/8U8iBKouW1zK1YWrxy+tIkk/PI/CggGVKeBb9lU9zrpgVl
         HuahMnP3Io2Dwk5oBnwVGdJ3KhaWoLlqC5rykYegusjb2pvL4eczFWKIoF5gObBbBJrV
         GDwy+boIYNACwTaPIC5j3P+qdBSx/7FgeTCfJy0TU8FyxaEMEpCNTvR77eHfrgT0x2RN
         9kRQmVpBwgEk7LdlHLeCHnQLAwLXkxCCzZvPRsa8011dh6QdpbQWg+8+ZB6EHUutqKrC
         FKYw==
X-Gm-Message-State: APjAAAWt5RKMUtLHvMB3FLqAli1I7oYVlhZBqBmQoPEhi5lIwB4iIemw
        0+bwcABs/8vSZZ825OzlnIuXRw==
X-Google-Smtp-Source: APXvYqyeZHnIrdExpIo6tfFmrtMi1e/igw4kzyIXoHWpoWYQKLY3Ibihz9Jnr/P8Sf4cIzUwJDH0TQ==
X-Received: by 2002:a17:90a:ba94:: with SMTP id t20mr13045782pjr.116.1565409144758;
        Fri, 09 Aug 2019 20:52:24 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g4sm115268192pfo.93.2019.08.09.20.52.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 20:52:23 -0700 (PDT)
Date:   Fri, 9 Aug 2019 23:52:22 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, kernel-team@android.com,
        kernel-team@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190810035222.GA157218@google.com>
References: <20190808095232.GA30401@X58A-UD3R>
 <20190808125607.GB261256@google.com>
 <20190808233014.GA184373@google.com>
 <20190809151619.GD28441@linux.ibm.com>
 <20190809153924.GB211412@google.com>
 <20190809163346.GF28441@linux.ibm.com>
 <20190809202226.GC255533@google.com>
 <20190809204217.GN28441@linux.ibm.com>
 <20190809213643.GG255533@google.com>
 <20190810034027.GR28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810034027.GR28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 08:40:27PM -0700, Paul E. McKenney wrote:
[snip]
> > > In contrast, a heavy duty userspace-driven workload would transition to
> > > and from userspace for each kfree_rcu(), and that would increment the
> > > dyntick-idle count on each transition to and from userspace.  Adding the
> > > rcu_momentary_dyntick_idle() emulates a pair of such transitions.
> > 
> > But even if we're in kernel mode and not transitioning, I thought the FQS
> > loop (rcu_implicit_dynticks_qs() function) would set need_heavy_qs to true at
> > 2 * jiffies_to_sched_qs.
> > 
> > Hmm, I forgot that jiffies_to_sched_qs can be quite large I guess. You're
> > right, we could call rcu_momentary_dyntick_idle() in advance before waiting
> > for FQS loop to do the setting of need_heavy_qs.
> > 
> > Or, am I missing something with the rcu_momentary_dyntick_idle() point you
> > made?
> 
> The trick is that rcu_momentary_dyntick_idle() directly increments the
> CPU's dyntick counter, so that the next FQS loop will note that the CPU
> passed through a quiescent state.  No need for need_heavy_qs in this case.

Yes, that's what I also understand. Thanks for confirming,

 - Joel


