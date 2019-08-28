Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B786EA0B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 22:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfH1UWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 16:22:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfH1UWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:22:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2398A308FC20;
        Wed, 28 Aug 2019 20:22:12 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-34.phx2.redhat.com [10.3.112.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B04319D70;
        Wed, 28 Aug 2019 20:22:11 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id E5D50119; Wed, 28 Aug 2019 17:22:05 -0300 (BRT)
Date:   Wed, 28 Aug 2019 17:22:05 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Igor Lubashev <ilubashe@akamai.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] perf: Treat perf_event_paranoid and kptr_restrict
 like the kernel does it
Message-ID: <20190828202205.GG2053@redhat.com>
References: <1566869956-7154-1-git-send-email-ilubashe@akamai.com>
 <CANLsYkwZm9ehopjDMXNw-3JOj8MPeT_shPPJBOeLNe7BUtibmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkwZm9ehopjDMXNw-3JOj8MPeT_shPPJBOeLNe7BUtibmA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 28 Aug 2019 20:22:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 28, 2019 at 01:31:21PM -0600, Mathieu Poirier escreveu:
> On Mon, 26 Aug 2019 at 19:40, Igor Lubashev <ilubashe@akamai.com> wrote:
> > Igor Lubashev (5):
> >   perf event: Check ref_reloc_sym before using it
> >   perf tools: Use CAP_SYS_ADMIN with perf_event_paranoid checks
> >   perf util: kernel profiling is disallowed only when perf_event_paranoid > 1
> >   perf symbols: Use CAP_SYSLOG with kptr_restrict checks
> >   perf: warn that perf_event_paranoid can restrict kernel symbols

> >  tools/perf/arch/arm/util/cs-etm.c    |  3 ++-
 
> For the coresight part:
 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
 
> >  tools/perf/arch/arm64/util/arm-spe.c |  3 ++-
> >  tools/perf/arch/x86/util/intel-bts.c |  3 ++-
> >  tools/perf/arch/x86/util/intel-pt.c  |  2 +-
> >  tools/perf/builtin-record.c          |  2 +-
> >  tools/perf/builtin-top.c             |  2 +-
> >  tools/perf/builtin-trace.c           |  2 +-
> >  tools/perf/util/event.c              |  7 ++++---
> >  tools/perf/util/evsel.c              |  2 +-
> >  tools/perf/util/symbol.c             | 15 ++++++++++++---
> >  10 files changed, 27 insertions(+), 14 deletions(-)
> 
> For the set:
> 
> Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks, updated the patches with your tags,

- Arnaldo
