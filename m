Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF526EF23C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 01:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbfKEAsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 19:48:55 -0500
Received: from mga12.intel.com ([192.55.52.136]:18172 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729443AbfKEAsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:48:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 16:48:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,268,1569308400"; 
   d="scan'208";a="205349175"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga006.jf.intel.com with ESMTP; 04 Nov 2019 16:48:54 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 75043300884; Mon,  4 Nov 2019 16:48:54 -0800 (PST)
Date:   Mon, 4 Nov 2019 16:48:54 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf tools: Fix time sorting
Message-ID: <20191105004854.GA25308@tassilo.jf.intel.com>
References: <20191104232711.16055-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104232711.16055-1-jolsa@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 12:27:11AM +0100, Jiri Olsa wrote:
> The final sort might get confused when the comparison
> is done over bigger numbers than int like for -s time.
> 
> Check following report for longer workloads:
>   $ perf report -s time -F time,overhead --stdio
> 
> Fixing hist_entry__sort to properly return int64_t and
> not possible cut int.
> 
> Cc: Andi Kleen <ak@linux.intel.com>
> Link: http://lkml.kernel.org/n/tip-uetl5z1eszpubzqykvdftaq6@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Looks good.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi
