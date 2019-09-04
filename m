Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C95A7D8B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 10:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfIDIUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 04:20:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60260 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfIDIUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CGQD9aajbZ43wWu0vn4K6MjrdAeqbwd4MhEaYZZjQSk=; b=JGaSLy4WvunqQWZaCJPgcF7RA
        fHOjCZpp5tBgxmE0BkCEYgAjVfmXkbPjqMH271bz04V3lClgnlMG03Jn7MSduvKtVcPXRDFES/GPg
        76p3BD8bcZnXHQDqY3tvxMOVHk1vUzcvCeJkH9R3GNuSJyw11jjzRgccBr9WeQQnUlhVflP0s9xFE
        5oqaA68cIc8YwyF2yzlCkA4Wxnizh+hmNYw5iHY6WoiKJpHYJMly5n3KzdqOmLKXSsO3T+qjXrYNt
        CohF74tq8QkLe8xlLwxDYEW4hwn8nHb+umVDv531FC2M6QonGNXs+Y9h5B6whSIqOafof4YLc9DXK
        IeLePlUIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5QX1-0002Hz-LI; Wed, 04 Sep 2019 08:20:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E56BF3011DF;
        Wed,  4 Sep 2019 10:20:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65EBA20977769; Wed,  4 Sep 2019 10:20:46 +0200 (CEST)
Date:   Wed, 4 Sep 2019 10:20:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viktor Rosendahl <viktor.rosendahl@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v5 1/4] ftrace: Implement fs notification for
 tracing_max_latency
Message-ID: <20190904082046.GB2349@hirez.programming.kicks-ass.net>
References: <20190903132602.3440-1-viktor.rosendahl@gmail.com>
 <20190903132602.3440-2-viktor.rosendahl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903132602.3440-2-viktor.rosendahl@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 03:25:59PM +0200, Viktor Rosendahl wrote:

> It seems like it would be possible to simply replace the calls to
> latency_fsnotify_enable/disable() with calls to
> start/stop_critical_timings(). However, the main problem is that it
> would not work for the wakup tracer. The wakeup tracer needs a
> facility that postpones the notifications, not one that prevents the
> measurements because all its measurements takes place in the middle
> of __schedule(). On the other hand, in some places, like in idle and
> the console we need start stop functions that prevents the
> measurements from being make.

Like Joel already mentioned; you can use irq_work here.
