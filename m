Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A29CE51ED
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 19:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409730AbfJYRGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 13:06:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51516 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfJYRFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 13:05:32 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iO31i-0000jf-BS; Fri, 25 Oct 2019 17:05:26 +0000
Date:   Fri, 25 Oct 2019 19:05:25 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     dvyukov@google.com, ebiederm@xmission.com, elver@google.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH cgroup/for-5.5] cgroup: remove
 cgroup_enable_task_cg_lists() optimization
Message-ID: <20191025170523.u43rkulrui22ynix@wittgenstein>
References: <0000000000003b1e8005956939f1@google.com>
 <20191021142111.GB1339@redhat.com>
 <20191024190351.GD3622521@devbig004.ftw2.facebook.com>
 <20191025125606.GI3622521@devbig004.ftw2.facebook.com>
 <20191025133358.pxpzxkhqc3mboi5x@wittgenstein>
 <20191025141325.GB6020@redhat.com>
 <20191025143224.wtwkkimqq4644iqq@wittgenstein>
 <20191025155224.GC6020@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191025155224.GC6020@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Removing a few people from Cc to avoid spamming the whole world]

On Fri, Oct 25, 2019 at 05:52:25PM +0200, Oleg Nesterov wrote:
> On 10/25, Christian Brauner wrote:
> >
> > On Fri, Oct 25, 2019 at 04:13:25PM +0200, Oleg Nesterov wrote:
> > > Almost every usage of task->flags (load or sore) can be reported as "data race".
> > > 
> > > Say, you do
> > > 
> > > 	if (task->flags & PF_KTHREAD)
> > > 
> > > while this task does
> > > 
> > > 	current->flags |= PF_FREEZER_SKIP;
> > > 	schedule().
> > > 
> > > this is data race.
> > 
> > Right, but I thought we agreed on WONTFIX in those scenarios?
> > The alternative is to READ_ONCE()/WRITE_ONCE() all of these.
> 
> Well, in my opinion this is WONTFIX, but I won't argue if someone
> adds _ONCE to all of these. Same for task->state, exit_state, and
> more.

Well, I honestly think that state and exit_state would make sense.
There already were issues that got fixed for example in 3245d6acab98
("exit: fix race between wait_consider_task() and wait_task_zombie()")
and as far as I understand this would also help kcsan to better detect
races.

Christian
