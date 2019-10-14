Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04418D594E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 03:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbfJNBdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Oct 2019 21:33:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:47844 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729494AbfJNBdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 21:33:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Oct 2019 18:33:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,294,1566889200"; 
   d="scan'208";a="201343088"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Oct 2019 18:33:22 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 4CDA1301AEA; Sun, 13 Oct 2019 18:33:22 -0700 (PDT)
Date:   Sun, 13 Oct 2019 18:33:22 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 1/3] perf tools: Allow to build with -ltcmalloc
Message-ID: <20191014013322.GI9933@tassilo.jf.intel.com>
References: <20191013151427.11941-1-jolsa@kernel.org>
 <20191013151427.11941-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013151427.11941-2-jolsa@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index a099a8a89447..8f1ba986d3bf 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -114,6 +114,8 @@ include ../scripts/utilities.mak
>  # Define NO_LIBZSTD if you do not want support of Zstandard based runtime
>  # trace compression in record mode.
>  #
> +# Define TCMALLOC to enable tcmalloc heap profiling.

It might be useful for more than just profiling. I found that gcc runs a
few percent faster with tcmalloc for some workloads. Maybe the same is
true for perf too, as sometimes it does a lot of mallocs.

-Andi
