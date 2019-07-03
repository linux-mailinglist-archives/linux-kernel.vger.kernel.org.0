Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB7B5C9AF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 09:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfGBHBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 03:01:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37585 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfGBHBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:01:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14so16405634wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j8lK5kIXp0UqDp4JIzbWUup5nSgUhdrymM+k2oGTEDc=;
        b=fbRnBucU6ENh5ePnY/Xja6zenz23moszKZ4AW/14c1aYhjfkZuQ0311SX3Fmh1icC6
         47kuyUOXNHziCYl3dn/FYQB09dmOYUCVhvgQCcUSmzglddyAF/v/GUX+i2tBUslQvIR3
         JqEeN2i5PAFKq1WoeHQ9L6B//vbrdrXK7f1OzuC0W0M9FCLdUYXW7g78Vpf0sDpESOOq
         V5KMBiSO7fsbMTXcxB3rHpHMDIouDfNuZXzqdxo0X3/01zhX3XPtPsYvAx0WeuLDe5QB
         N29jkrMrlWwvFyP3pJb5u0VaDdAX/yr4IXUcisQTb0KWoc32Kr603pxW6EqQ54JGHGq2
         PQFA==
X-Gm-Message-State: APjAAAUWr7HGDsbYX92tyzB+Z/mmgiA2tvUUf0+w7Nn0CDdhKYhpI78U
        Cn21C5C804FmWlycAg82KfsbtA==
X-Google-Smtp-Source: APXvYqxOHUPpYjdAAg6clNrlcbEiwLlc67t9bfS8ALzT5Vbf5YgNxPVDD80/N0s1sHlnf0pD9kkMvQ==
X-Received: by 2002:adf:dd8c:: with SMTP id x12mr22298053wrl.212.1562050874833;
        Tue, 02 Jul 2019 00:01:14 -0700 (PDT)
Received: from localhost.localdomain ([151.15.224.253])
        by smtp.gmail.com with ESMTPSA id r16sm24718434wrr.42.2019.07.02.00.01.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 00:01:13 -0700 (PDT)
Date:   Tue, 2 Jul 2019 09:01:12 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v8 7/8] sched/core: Prevent race condition between cpuset
 and __sched_setscheduler()
Message-ID: <20190702070111.GF26005@localhost.localdomain>
References: <20190628080618.522-1-juri.lelli@redhat.com>
 <20190628080618.522-8-juri.lelli@redhat.com>
 <20190701191141.GD3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701191141.GD3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/19 21:11, Peter Zijlstra wrote:
> On Fri, Jun 28, 2019 at 10:06:17AM +0200, Juri Lelli wrote:
> > No synchronisation mechanism exists between the cpuset subsystem and
> > calls to function __sched_setscheduler(). As such, it is possible that
> > new root domains are created on the cpuset side while a deadline
> > acceptance test is carried out in __sched_setscheduler(), leading to a
> > potential oversell of CPU bandwidth.
> > 
> > Grab cpuset_rwsem read lock from core scheduler, so to prevent
> > situations such as the one described above from happening.
> > 
> 
> ISTR there being a funny vs normalize_rt_tasks(); maybe mention that?

Yep. I'll add a comment about it.
