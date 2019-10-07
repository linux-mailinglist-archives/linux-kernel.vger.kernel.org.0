Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D09D5CEA82
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 19:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfJGRXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 13:23:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:35272 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728028AbfJGRXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:23:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F1B2AE1A;
        Mon,  7 Oct 2019 17:23:00 +0000 (UTC)
Date:   Mon, 7 Oct 2019 19:22:59 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: vmalloc: Use the vmap_area_lock to protect
 ne_fit_preload_node
Message-ID: <20191007172259.7mdthvqua4wwyold@beryllium.lan>
References: <20191003090906.1261-1-dwagner@suse.de>
 <20191004153728.c5xppuqwqcwecbe6@linutronix.de>
 <20191004162041.GA30806@pc636>
 <20191004163042.jpiau6dlxqylbpfh@linutronix.de>
 <20191007083037.zu3n5gindvo7damg@beryllium.lan>
 <20191007105631.iau6zhxqjeuzajnt@linutronix.de>
 <20191007162330.GA26503@pc636>
 <20191007163443.6owts5jp2frum7cy@beryllium.lan>
 <20191007165611.GA26964@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007165611.GA26964@pc636>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 06:56:11PM +0200, Uladzislau Rezki wrote:
> On Mon, Oct 07, 2019 at 06:34:43PM +0200, Daniel Wagner wrote:
> > I supppose, one thing which would help in this discussion, is what do
> > you gain by using preempt_disable() instead of moving the lock up?
> > Do you have performance numbers which could justify the code?
> >
> Actually there is a high lock contention on vmap_area_lock, because it
> is still global. You can have a look at last slide:
> 
> https://linuxplumbersconf.org/event/4/contributions/547/attachments/287/479/Reworking_of_KVA_allocator_in_Linux_kernel.pdf
> 
> so this change will make it a bit higher.

Thanks! I suspected something like this :(

On the todo-list page you stating that vmap_area_lock could be
splitted and therefore reduce the contention. If you could avoid those
preempt_disable() tricks and just use plain spin_locks() to protect it
would be really helpful.

> From the other hand i agree
> that for rt it should be fixed, probably it could be done like:
> 
> ifdef PREEMPT_RT
>     migrate_disable()
> #else
>     preempt_disable()
> ...
> 
> but i am not sure it is good either.

I don't think this way to go. I guess Sebastian and Thomas have a
better idea how to address this for PREEMPT_RT.
