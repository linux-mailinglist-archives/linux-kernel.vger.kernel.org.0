Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1A4A02C2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 15:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfH1NNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 09:13:22 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41454 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfH1NNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:13:21 -0400
Received: by mail-qk1-f193.google.com with SMTP id g17so2298754qkk.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YBqrcxU4Xb5zORXVVA1t4RQ7TSRR+xPq1ZjNisEiAD4=;
        b=egv11MIOLBOnSyI7yp6jNWxNWyhFVfp4I2aQAeA15GJCwUbQW7zUMqOUdXvSySltgP
         0n/cyrmEIrvITun+js2IMxEHwnYpnZxjzUKJbP+hOxuCUKEdlhG0y/4XUSRM1ezVUVX9
         nywkGU6bt53Cs+1Ou3rqKiJFc3aL+MhzewNQQg9KpDXUCRmfjmfI0JoBjxd4SPLHMtCm
         7hn4rOoVrPs/nPMgyMngu8fGkY1DzWFilOu3eJAlp/ODdg3+Z+HxigyFU7x8aswaHBVG
         flHZlVK1zYkyTQm8TmAxSUmilcviZaZK9zgcbhpKIYTdIA/SeLSAbblAnQxqbzMSz1ht
         400Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YBqrcxU4Xb5zORXVVA1t4RQ7TSRR+xPq1ZjNisEiAD4=;
        b=CxoKXqZLB3X2vzZqIrih2bi89+GLftO1DMRvQLLMP2H/SAZNRCUtkzwR75tZzd41k/
         CKDg7iCpD/rhgdxR+R9rpSHYYYVqyFZp0Bb2Iwa8u6rX4gBSX4V/DJ8M88CwqommIaMl
         8QmF9B2hGEpGVPtRpzEHxZmydA10mADaG4N5FrpQzQtGhncHXlc6ReKhv2Ndw+1fsREb
         32KvSPmFyL61z/vTkPL5JSR8GBGHUM32EXrEK3tuQRmLGl0gaAIU0O0xezTcjB6NJrUS
         khP/8zrtUio+7CMw81YQgoe383zCigJ6RBrQ7NupjRQK9IjxLofN0EoVN722sc7TPFIM
         mR1w==
X-Gm-Message-State: APjAAAX42tw3oKfSUM2IlGA/hyano6myntw+lEmeAI3Bu5b4HtFFKjdt
        tU6eoEJ89XgUMx1WHmlc2yk=
X-Google-Smtp-Source: APXvYqwVPG6NaQlkBJFOkZw5IaU7o9usfA4FvRSsKpkotOwmHAnHsmFQqNQKFzD7jR2QbWKnthpdyA==
X-Received: by 2002:a37:4ed3:: with SMTP id c202mr3756103qkb.457.1566998000423;
        Wed, 28 Aug 2019 06:13:20 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id z187sm1248633qke.99.2019.08.28.06.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 06:13:19 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CAA3B40916; Wed, 28 Aug 2019 10:13:17 -0300 (-03)
Date:   Wed, 28 Aug 2019 10:13:17 -0300
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
Message-ID: <20190828131317.GA5632@kernel.org>
References: <20190828073130.83800-1-namhyung@kernel.org>
 <20190828073130.83800-2-namhyung@kernel.org>
 <20190828094459.GG2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828094459.GG2369@hirez.programming.kicks-ass.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 28, 2019 at 11:44:59AM +0200, Peter Zijlstra escreveu:
> On Wed, Aug 28, 2019 at 04:31:22PM +0900, Namhyung Kim wrote:
> > To support cgroup tracking, add CGROUP event to save a link between
> > cgroup path and inode number.  The attr.cgroup bit was also added to
> > enable cgroup tracking from userspace.
> > 
> > This event will be generated when a new cgroup becomes active.
> > Userspace might need to synthesize those events for existing cgroups.
> > 
> > As aux_output change is also going on, I just added the bit here as
> > well to remove possible conflicts later.
> 
> Why do we want this?

Yeah, I'd resolve the conflict later, to avoid mixing things like this.

- Arnaldo
