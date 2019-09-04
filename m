Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C04DA8990
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbfIDPcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 11:32:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729773AbfIDPcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:32:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C799800DD4;
        Wed,  4 Sep 2019 15:32:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2883C5D9C9;
        Wed,  4 Sep 2019 15:32:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  4 Sep 2019 17:32:49 +0200 (CEST)
Date:   Wed, 4 Sep 2019 17:32:46 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 1/3] task: Add a count of task rcu users
Message-ID: <20190904153245.GF24568@redhat.com>
References: <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com>
 <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org>
 <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org>
 <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
 <87ef0yt221.fsf_-_@x220.int.ebiederm.org>
 <20190904144415.GB20391@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904144415.GB20391@lenoir>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Wed, 04 Sep 2019 15:32:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04, Frederic Weisbecker wrote:
>
> So what happens if, say:
>
>
>            CPU 1                         CPU 2
>    --------------------------------------------------------------
>    rcu_read_lock()
>    p = rcu_dereference(rq->task)
>    if (refcount_inc_not_zero(p->rcu_users)) {
>        .....
>                                          release_task() {
>                                              put_task_struct_rcu_user() {
>                                                  call_rcu() {
>                                                      queue rcu_head

in this particular case call_rcu() won't be called, so

>                                                  }
>                                              }
>                                          }
>        put_task_struct_rcu_user(); //here rcu_users has been overwritten

rcu_users won't be overwritten.

But nobody should try to increment ->rcu_users,

	rcu_read_lock();
	p = rcu_dereference(rq->task);
	refcount_inc_not_zero(p->rcu_users);

is already wrong because both release_task/last-schedule can happen in
between, before refcount_inc_not_zero().

Oleg.

