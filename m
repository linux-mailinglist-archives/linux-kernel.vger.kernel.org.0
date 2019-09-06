Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D78B4AB477
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 10:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392717AbfIFI6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 04:58:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:51431 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730412AbfIFI6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 04:58:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 01:58:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,472,1559545200"; 
   d="scan'208";a="199478645"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by fmsmga001.fm.intel.com with ESMTP; 06 Sep 2019 01:58:36 -0700
Subject: Re: [PATCH 0/6] perf scripts python: exported-sql-viewer.py: Add Time
 chart by CPU
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20190821083216.1340-1-adrian.hunter@intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6f55cdb7-a431-bd1b-8e7f-f8caf92399af@intel.com>
Date:   Fri, 6 Sep 2019 11:57:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821083216.1340-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/19 11:32 AM, Adrian Hunter wrote:
> Hi
> 
> These patches to exported-sql-viewer.py, add a time chart based on context
> switch information.  Context switch information was added to the database
> export fairly recently, so the chart menu option will only appear if
> context switch information is in the database.  Refer to the Exported SQL
> Viewer Help option for more information about the chart.
> 
> 
> Adrian Hunter (6):
>       perf scripts python: exported-sql-viewer.py: Add LookupModel()
>       perf scripts python: exported-sql-viewer.py: Add HBoxLayout and VBoxLayout
>       perf scripts python: exported-sql-viewer.py: Add global time range calculations
>       perf scripts python: exported-sql-viewer.py: Tidy up Call tree call_time
>       perf scripts python: exported-sql-viewer.py: Add ability for Call tree to open at a specified task and time
>       perf scripts python: exported-sql-viewer.py: Add Time chart by CPU
> 
>  tools/perf/scripts/python/exported-sql-viewer.py | 1555 +++++++++++++++++++++-
>  1 file changed, 1531 insertions(+), 24 deletions(-)

Any comments?
