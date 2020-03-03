Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5D4177A6C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 16:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgCCP25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 10:28:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44787 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729819AbgCCP24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:28:56 -0500
Received: from [5.158.153.55] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j99TW-0000TZ-N3; Tue, 03 Mar 2020 16:28:50 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 6FDC3104098; Tue,  3 Mar 2020 16:28:45 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf bench: Share 'start', 'end', 'runtime' global vars
In-Reply-To: <20200302150914.GB28183@kernel.org>
References: <20200302150914.GB28183@kernel.org>
Date:   Tue, 03 Mar 2020 16:28:45 +0100
Message-ID: <87tv35cv9u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> writes:

> Hi,
>
> 	Noticed with gcc 10 (fedora rawhide) that those variables were
> not being declared as static, so end up with:
>
> ld: /tmp/build/perf/bench/epoll-wait.o:/git/perf/tools/perf/bench/epoll-wait.c:93: multiple definition of `end'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
> ld: /tmp/build/perf/bench/epoll-wait.o:/git/perf/tools/perf/bench/epoll-wait.c:93: multiple definition of `start'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
> ld: /tmp/build/perf/bench/epoll-wait.o:/git/perf/tools/perf/bench/epoll-wait.c:93: multiple definition of `runtime'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
> ld: /tmp/build/perf/bench/epoll-ctl.o:/git/perf/tools/perf/bench/epoll-ctl.c:38: multiple definition of `end'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
> ld: /tmp/build/perf/bench/epoll-ctl.o:/git/perf/tools/perf/bench/epoll-ctl.c:38: multiple definition of `start'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
> ld: /tmp/build/perf/bench/epoll-ctl.o:/git/perf/tools/perf/bench/epoll-ctl.c:38: multiple definition of `runtime'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
> make[4]: *** [/git/perf/tools/build/Makefile.build:145: /tmp/build/perf/bench/perf-in.o] Error 1
>
> 	Just prefixing them with 'extern' in all but one (futex-hash.c)
> seems to be enough, ok?

Don't we have header files for that?
