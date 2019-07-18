Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2231B6CD70
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 13:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390089AbfGRLgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 07:36:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfGRLgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 07:36:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8FA2A3082E42;
        Thu, 18 Jul 2019 11:36:52 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8485A5D71A;
        Thu, 18 Jul 2019 11:36:52 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 3EF4941F40;
        Thu, 18 Jul 2019 11:36:52 +0000 (UTC)
Date:   Thu, 18 Jul 2019 07:36:52 -0400 (EDT)
From:   Jan Stancek <jstancek@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
        linux-kernel@vger.kernel.org, dbueso@suse.de, mingo@redhat.com,
        jade alglave <jade.alglave@arm.com>, paulmck@linux.vnet.ibm.com
Message-ID: <466627724.868829.1563449812023.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190718110928.GT3463@hirez.programming.kicks-ass.net>
References: <20190716185807.GJ3402@hirez.programming.kicks-ass.net> <20190717131335.b2ry43t2ov7ba4t4@willie-the-truck> <21ff5905-198b-6ea5-6c2a-9fb10cb48ea7@redhat.com> <20190717192200.GA17687@dustball.usersys.redhat.com> <20190718092640.52oliw3sid7gxyh6@willie-the-truck> <79224323.853324.1563447052432.JavaMail.zimbra@redhat.com> <20190718110446.GC3419@hirez.programming.kicks-ass.net> <20190718110928.GT3463@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH v2] locking/rwsem: add acquire barrier to read_slowpath
 exit when queue is empty
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.17.163, 10.4.195.22]
Thread-Topic: locking/rwsem: add acquire barrier to read_slowpath exit when queue is empty
Thread-Index: 2FC8jkf3xWoTPr5a8SlywdIbna06hA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 18 Jul 2019 11:36:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
> 
> It's simpler like so:
> 
> On Thu, Jul 18, 2019 at 01:04:46PM +0200, Peter Zijlstra wrote:
> > X = 0;
> > 
> > 	rwsem_down_read()
> > 	  for (;;) {
> > 	    set_current_state(TASK_UNINTERRUPTIBLE);
> >
> >								X = 1;
> >                                                               rwsem_up_write();
> > 								  rwsem_mark_wake()
> > 								    atomic_long_add(adjustment, &sem->count);
> > 								    smp_store_release(&waiter->task, NULL);
> > 
> > 	    if (!waiter.task)
> > 	      break;
> > 
> > 	    ...
> > 	  }
> > 
> > 	r = X;
> > 

I see - it looks possible. Thank you for this example.
