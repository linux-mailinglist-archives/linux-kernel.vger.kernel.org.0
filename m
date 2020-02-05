Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD9315272B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 08:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgBEHp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 02:45:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46356 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgBEHpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 02:45:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so1336263wrl.13;
        Tue, 04 Feb 2020 23:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d/f9vNt3yE3WwXMhBz9JCn6XoBXsK1pWvzUbsKnh1qo=;
        b=oMcczZONjJYbincAIZLap5pgCNm9k5L1sJsDTpQdDLXWwTZf+7JviOPUnBfD2QnhfF
         ow/V+42eAJCM/nFGMe21K08kZ/MQeWzTnKUhgwVX8RWnfOVA+nBb8GC/O9jqrVgnjZun
         +CMAImVp1LTbd36vnQJxpmcU5gWXZknthYfPnpxrkuUvAtlysCTSKYKpdxJ+YvWfWs7x
         BR8/d90kxJ6yELN6h/8h5e/ezAONaCXoln2q6BhtG27oKpgcmX5lQbgYPlQcTlPXmnp3
         VOi5IQZAHYqrO01xJ+sL/QI1xxbFaOZ2xYGp6DA6b23wz6gChSiROxY3T/wjl4LNcXFU
         Z+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=d/f9vNt3yE3WwXMhBz9JCn6XoBXsK1pWvzUbsKnh1qo=;
        b=r2JfZAsp0sodNzsY86zHZhFKDfW+363koBIlZ5LyYeQmc74B1NcxYg6dSaHs/NPUTh
         3wPcF1Yjtqo5mZ3U3lL6xc13Yg5OJxGKwl8CQfFO+/UZ2++P+toZIa5YOe2V9tg/PrhB
         JgRSTDNlDUmxf0OGwSTJOijpGrzbj00Woge2+pU8D0cvhx+uXXUXeu4KuZQI+DOCWhI9
         ePvsCEk0VipdD6GCKfUBtfEnT0j3VmkJHYYiFfWHv15N7oYpkE7+KBlBOTAHvLz49RVp
         JIBdvVntDKQlw0WvBId8GNhDJcZ168jGYMWqEbwtLbR4+Eqmxmn5I5GTm9CbexmJ4sq1
         NyYg==
X-Gm-Message-State: APjAAAWbE2zPWu4IZsVcnPLHnt9IhioW//fMNONAY8tpeoOHeVD+vqt/
        droj0yTKkPs1lrCgz9gSdRw=
X-Google-Smtp-Source: APXvYqwsTkJuGDlHORRgOE040BSQL66JOGf674YNBrlakghL5EVaFt8Rs3pAnIgdIR9SLQWreQ6TXg==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr26727390wrn.245.1580888753684;
        Tue, 04 Feb 2020 23:45:53 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c13sm24038918wrn.46.2020.02.04.23.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 23:45:53 -0800 (PST)
Date:   Wed, 5 Feb 2020 08:45:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Cengiz Can <cengiz@kernel.wtf>,
        Changbin Du <changbin.du@gmail.com>,
        Leo Yan <leo.yan@linaro.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes from Budapest
Message-ID: <20200205074550.GA124628@gmail.com>
References: <20200201080330.13211-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201080330.13211-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> The following changes since commit 0cc4bd8f70d1ea2940295f1050508c663fe9eff9:
> 
>   Merge branch 'core/kprobes' into perf/core, to pick up fixes (2020-01-28 07:59:05 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.6-20200201
> 
> for you to fetch changes up to 85fc95d75970ee7dd8e01904e7fb1197c275ba6b:
> 
>   perf maps: Add missing unlock to maps__insert() error case (2020-01-31 09:40:50 +0100)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf maps:
> 
>   Cengiz Can:
> 
>   - Add missing unlock to maps__insert() error case.
> 
> srcline:
> 
>   Changbin Du:
> 
>   - Make perf able to build with latest libbfd.
> 
> perf parse:
> 
>   Leo Yan:
> 
>   - Keep copy of string in perf_evsel_config_term() to fix sink terms
>     processing in ARM CoreSight.
> 
> perf test:
> 
>   Thomas Richter:
> 
>   - Fix test case Merge cpu map, removing extra reference count drop that
>     causes a segfault on s/390.
> 
> perf probe:
> 
>   Thomas Richter:
> 
>   - Add ustring support for perf probe command
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Cengiz Can (1):
>       perf maps: Add missing unlock to maps__insert() error case
> 
> Changbin Du (1):
>       perf: Make perf able to build with latest libbfd
> 
> Leo Yan (2):
>       perf parse: Refactor 'struct perf_evsel_config_term'
>       perf parse: Copy string to perf_evsel_config_term
> 
> Thomas Richter (2):
>       perf test: Fix test case Merge cpu map
>       perf probe: Add ustring support for perf probe command
> 
>  tools/perf/arch/arm/util/cs-etm.c |  2 +-
>  tools/perf/tests/cpumap.c         |  1 -
>  tools/perf/util/evsel.c           |  8 +++--
>  tools/perf/util/evsel_config.h    |  5 ++-
>  tools/perf/util/map.c             |  1 +
>  tools/perf/util/parse-events.c    | 67 ++++++++++++++++++++++++++-------------
>  tools/perf/util/probe-finder.c    |  3 +-
>  tools/perf/util/srcline.c         | 16 +++++++++-
>  8 files changed, 71 insertions(+), 32 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
