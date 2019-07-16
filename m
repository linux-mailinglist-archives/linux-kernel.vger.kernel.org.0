Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C61726A426
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 10:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbfGPIqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 04:46:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfGPIqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 04:46:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3DA1A308FBAF;
        Tue, 16 Jul 2019 08:46:47 +0000 (UTC)
Received: from krava (unknown [10.43.17.77])
        by smtp.corp.redhat.com (Postfix) with SMTP id A007A611DC;
        Tue, 16 Jul 2019 08:46:44 +0000 (UTC)
Date:   Tue, 16 Jul 2019 10:46:43 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Igor Lubashev <ilubashe@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH 1/3] perf: Add capability-related utilities
Message-ID: <20190716084643.GA22317@krava>
References: <1562112605-6235-1-git-send-email-ilubashe@akamai.com>
 <1562112605-6235-2-git-send-email-ilubashe@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562112605-6235-2-git-send-email-ilubashe@akamai.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 16 Jul 2019 08:46:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 08:10:03PM -0400, Igor Lubashev wrote:
> Add utilities to help checking capabilities of the running process.
> Make perf link with libcap.
> 
> Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
> ---
>  tools/perf/Makefile.config         |  2 +-
>  tools/perf/util/Build              |  1 +
>  tools/perf/util/cap.c              | 24 ++++++++++++++++++++++++
>  tools/perf/util/cap.h              | 10 ++++++++++
>  tools/perf/util/event.h            |  1 +
>  tools/perf/util/python-ext-sources |  1 +
>  tools/perf/util/util.c             |  9 +++++++++
>  7 files changed, 47 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/util/cap.c
>  create mode 100644 tools/perf/util/cap.h
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 85fbcd265351..21470a50ed39 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -259,7 +259,7 @@ CXXFLAGS += -Wno-strict-aliasing
>  # adding assembler files missing the .GNU-stack linker note.
>  LDFLAGS += -Wl,-z,noexecstack
>  
> -EXTLIBS = -lpthread -lrt -lm -ldl
> +EXTLIBS = -lpthread -lrt -lm -ldl -lcap

I wonder we should detect libcap or it's everywhere.. Arnaldo's compile test suite might tell

jirka
