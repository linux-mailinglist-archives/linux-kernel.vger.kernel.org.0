Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5662071FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 20:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391605AbfGWSyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 14:54:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbfGWSyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:54:36 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F5542084D;
        Tue, 23 Jul 2019 18:54:34 +0000 (UTC)
Date:   Tue, 23 Jul 2019 14:54:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Juri Lelli <juri.lelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>, tom.zanussi@linux.intel.com
Subject: Re: [PATCH RT 01/16] kthread: add a global worker thread.
Message-ID: <20190723145432.585bbe36@gandalf.local.home>
In-Reply-To: <20190722083009.GE25636@localhost.localdomain>
References: <20190719214931.700049248@goodmis.org>
        <20190719214956.170195069@goodmis.org>
        <20190722083009.GE25636@localhost.localdomain>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019 10:30:09 +0200
Juri Lelli <juri.lelli@gmail.com> wrote:

> Hi,
> 
> On 19/07/19 17:49, Steven Rostedt wrote:
> > 4.19.59-rt24-rc1 stable review patch.
> > If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > [ Upstream commit 0532e87d9d44795221aa921ba7024bde689cc894 ]
> > 
> > Add kthread_schedule_work() which uses a global kthread for all its
> > jobs.
> > Split the cgroup include to avoid recussive includes from interrupt.h.
> > Fixup everything that fails to build (and did not include all header).
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---  
> 
> I believe this one needs also the following, otherwise the attached
> config won't compile.

Thanks, I folded this in, and will be releasing this version shortly.

-- Steve

> 
> Best,
> 
> Juri
> 
> ---
> diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
> index 6d766a19f2bb..0473efda4c65 100644
> --- a/include/linux/blk-cgroup.h
> +++ b/include/linux/blk-cgroup.h
> @@ -14,7 +14,7 @@
>   *                   Nauman Rafique <nauman@google.com>
>   */
> 
> -#include <linux/cgroup.h>
> +#include <linux/kthread-cgroup.h>
>  #include <linux/percpu_counter.h>
>  #include <linux/seq_file.h>
>  #include <linux/radix-tree.h>

