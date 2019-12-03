Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B750110181
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 16:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfLCPoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 10:44:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50188 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfLCPox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 10:44:53 -0500
Received: from [81.92.17.157] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1icAII-0004gq-Tv; Tue, 03 Dec 2019 15:40:55 +0000
Date:   Tue, 3 Dec 2019 16:40:52 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Adrian Reber <areber@redhat.com>
Subject: Re: [PATCH 18/23] tools headers UAPI: Sync sched.h with the kernel
Message-ID: <20191203154051.2inrcde6frjkm3ph@wittgenstein>
References: <20191203135606.24902-1-acme@kernel.org>
 <20191203135606.24902-19-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191203135606.24902-19-acme@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 10:56:01AM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> To get the changes in:
> 
>   0acefef58451 ("Merge tag 'threads-v5.5' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux")
>   49cb2fc42ce4 ("fork: extend clone3() to support setting a PID")
>   fa729c4df558 ("clone3: validate stack arguments")
>   b612e5df4587 ("clone3: add CLONE_CLEAR_SIGHAND")
> 
> This file gets rebuilt, but no changes ensues:
> 
>    CC       /tmp/build/perf/trace/beauty/clone.o
> 
> This addresses this perf build warning:
> 
>   Warning: Kernel ABI header at 'tools/include/uapi/linux/sched.h' differs from latest version at 'include/uapi/linux/sched.h'
>   diff -u tools/include/uapi/linux/sched.h include/uapi/linux/sched.
> 
> The CLONE_CLEAR_SIGHAND one will be used in tools/perf/trace/beauty/clone.c
> in a followup patch to show that string when this bit is set in the
> syscall arg. Keeping a copy of this file allows us to build this in
> older systems and have the binary support printing that flag whenever
> that system gets its kernel updated to one where this feature is
> present.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Adrian Reber <areber@redhat.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lkml.kernel.org/n/tip-nprqsvvzbhzoy64cbvos6c5b@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
