Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28B801929A9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 14:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgCYNaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 09:30:19 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:45114 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgCYNaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:30:19 -0400
Received: by mail-qv1-f66.google.com with SMTP id g4so975072qvo.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 06:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uWPS7PjoiY9R8TaTiA5QpjnYh9arIvd3P3PvhKcV++I=;
        b=HGCmcGSGlRDNCmP0Jhf2uCs5OygM7WjiumSyx+Xl6GteDLbyDJ0zWp6KCvZ6ErjC7A
         UoU+/jERRkcNX+mNfTm4puy4dmMcs84JSqTgMzJJ4vzB3RmDO2LmmRe6fj72GqYW6zmm
         w/Dhb0u4Codfnzfr7HU1qS3GqBQNDTj892Y4MdOzj6pUhxIz3VwlRsFhN9l85OSlDNX3
         MO5mN80hBJzvOUfF3t78W7R6hPXfe6vOA7DX7MKziOQGkCfNjr4vHlOyzmiYvxfIc5kj
         NMwMtdC4z7qIBbGAocB4xJTH61QRgszVD6wNfdKzjjF5bm9NBcweu8OW4juosyUY9KK9
         zh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uWPS7PjoiY9R8TaTiA5QpjnYh9arIvd3P3PvhKcV++I=;
        b=R8KGOTj3E5r8/DCZ3Luw68PMANHcBf9iriMB6Qio9DRQwMeemXcwrEdN3FX73gzmf0
         s1qnLJhBV3srr74HOuK0phe4jKT5P298rV/ObprB8PoB6NZpbpqV7ffC9smnnLjJiS1I
         +VFLS3i3s4Dw9Zh1DeK71zgj1nZHYRSPd8OrLJ9G8WCjbfl+rd0WZiokb3Q7KAwYo87J
         iEgvMks/Nk10tMluntQ40T+W217b4Q9aobDUKRaRskyslMsdEdLWUkBVhEbr8ERbZvkr
         tjCah5RYhHaj2l7Q6sHoTS5g2Ok86QM5NVqEapUHy1hWbvW9QmKWdqool+MXTX13FTj9
         tHdQ==
X-Gm-Message-State: ANhLgQ1PLZpwiMguZYe4oTvzgp5POF2L67XSJ3Gl3qbCZrhJ4nWjQmsh
        EwJgaIrAcGqMECCXMO1jRpw=
X-Google-Smtp-Source: ADFU+vuJMLXE7T6HLEU4+q2yuldglAuXi642aB1S1Kg4oQePb3ikWpuWfow4XE19do+HiYQw6zBxcg==
X-Received: by 2002:a05:6214:1412:: with SMTP id n18mr3167697qvx.219.1585143016012;
        Wed, 25 Mar 2020 06:30:16 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x51sm17665716qtj.82.2020.03.25.06.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 06:30:15 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3BAD340F77; Wed, 25 Mar 2020 10:30:12 -0300 (-03)
Date:   Wed, 25 Mar 2020 10:30:12 -0300
To:     He Zhe <zhe.he@windriver.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, Sam Lunt <samueljlunt@gmail.com>
Subject: Re: [PATCH 1/2] perf: Be compatible with all python versions when
 fetching ldflags
Message-ID: <20200325133012.GC14102@kernel.org>
References: <1581618066-187262-1-git-send-email-zhe.he@windriver.com>
 <20200216222148.GA161771@krava>
 <8cc46abf-208d-4aa4-8d0d-4922106bee6e@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cc46abf-208d-4aa4-8d0d-4922106bee6e@windriver.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 17, 2020 at 10:24:27AM +0800, He Zhe escreveu:
> 
> 
> On 2/17/20 6:22 AM, Jiri Olsa wrote:
> > On Fri, Feb 14, 2020 at 02:21:05AM +0800, zhe.he@windriver.com wrote:
> >> From: He Zhe <zhe.he@windriver.com>
> >>
> >> Since Python v3.8.0, with the following commit
> >> 0a8e57248b91 ("bpo-36721: Add --embed option to python-config (GH-13500)"),
> > we got similar change recently.. might have not been picked up yet
> >
> >   https://lore.kernel.org/lkml/20200131181123.tmamivhq4b7uqasr@gmail.com/
> 
> Thanks for pointing out.

So, just with your patch:

[acme@five perf]$ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf
[acme@five perf]$ make PYTHON=python3 -C tools/perf O=/tmp/build/perf install-bin |& grep python
...                     libpython: [ OFF ]
Makefile.config:750: No 'Python.h' (for Python 2.x support) was found: disables Python support - please install python-devel/python-dev
  CC       /tmp/build/perf/tests/python-use.o
[acme@five perf]$

[acme@five perf]$ rpm -q python2-devel python3-devel python-devel
package python2-devel is not installed
python3-devel-3.7.6-2.fc31.x86_64
package python-devel is not installed
[acme@five perf]$

[acme@five perf]$ cat /tmp/build/perf/feature/test-libpython.make.output
/bin/sh: --configdir: command not found
[acme@five perf]$ cat /tmp/build/perf/feature/test-libpython
test-libpython.make.output          test-libpython-version.make.output
[acme@five perf]$ cat /tmp/build/perf/feature/test-libpython-version.make.output
/bin/sh: --configdir: command not found
[acme@five perf]$


Without your patch:

[acme@five perf]$ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf
[acme@five perf]$ make PYTHON=python3 -C tools/perf O=/tmp/build/perf install-bin |& grep python
...                     libpython: [ on  ]
  GEN      /tmp/build/perf/python/perf.so
  MKDIR    /tmp/build/perf/scripts/python/Perf-Trace-Util/
  CC       /tmp/build/perf/scripts/python/Perf-Trace-Util/Context.o
  LD       /tmp/build/perf/scripts/python/Perf-Trace-Util/perf-in.o
  CC       /tmp/build/perf/tests/python-use.o
  CC       /tmp/build/perf/util/scripting-engines/trace-event-python.o
  INSTALL  python-scripts
[acme@five perf]$

[acme@five perf]$ ldd /tmp/build/perf/perf |& grep python
	libpython3.7m.so.1.0 => /lib64/libpython3.7m.so.1.0 (0x00007f11dd1ee000)
[acme@five perf]$ perf -vv |& grep -i python
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
[acme@five perf]$

What am I missing?


[acme@five perf]$ cat /etc/redhat-release
Fedora release 31 (Thirty One)
[acme@five perf]$

- Arnaldo
