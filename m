Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13270D4DD6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 09:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfJLHGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 03:06:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfJLHGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 03:06:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F20EF3086262;
        Sat, 12 Oct 2019 07:06:19 +0000 (UTC)
Received: from ovpn-117-172.phx2.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 499055DA60;
        Sat, 12 Oct 2019 07:06:16 +0000 (UTC)
Message-ID: <0979a9a345e47be69783a2183dd31911e9fc755e.camel@redhat.com>
Subject: Re: [PATCH RT] kernel/sched: Don't recompute cpumask weight in
 migrate_enable_update_cpus_allowed()
From:   Scott Wood <swood@redhat.com>
To:     Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <jlelli@redhat.com>
Date:   Sat, 12 Oct 2019 02:06:16 -0500
In-Reply-To: <20191011140908.5161-1-longman@redhat.com>
References: <20191011140908.5161-1-longman@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sat, 12 Oct 2019 07:06:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-11 at 10:09 -0400, Waiman Long wrote:
> At each invocation of rt_spin_unlock(), cpumask_weight() is called
> via migrate_enable_update_cpus_allowed() to recompute the weight of
> cpus_mask which doesn't change that often.
> 
> The following is a sample output of perf-record running the testpmd
> microbenchmark on an RT kernel:
> 
>   34.77%   1.65%  testpmd  [kernel.kallsyms]  [k] rt_spin_unlock
>   34.32%   2.52%  testpmd  [kernel.kallsyms]  [k] migrate_enable
>   21.76%  21.76%  testpmd  [kernel.kallsyms]  [k] __bitmap_weight
> 
> By adding an extra variable to keep track of the weight of cpus_mask,
> we could eliminate the frequent call to cpumask_weight() and replace
> it with simple assignment.

Can you try this with my migrate disable patchset (which makes
amigrate_enable_update_cpus_allowed() be called much less often) and see if
caching nr_cpus_allowed still makes a difference?

-Scott


