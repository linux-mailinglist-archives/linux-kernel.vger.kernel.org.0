Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79577147A5E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 10:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbgAXJZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 04:25:59 -0500
Received: from mga05.intel.com ([192.55.52.43]:14069 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729593AbgAXJZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:25:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2020 01:25:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,357,1574150400"; 
   d="scan'208";a="260181466"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jan 2020 01:25:56 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v3] perf/core: fix mlock accounting in perf_mmap()
In-Reply-To: <20200123181146.2238074-1-songliubraving@fb.com>
References: <20200123181146.2238074-1-songliubraving@fb.com>
Date:   Fri, 24 Jan 2020 11:25:55 +0200
Message-ID: <87zhed9pek.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song Liu <songliubraving@fb.com> writes:

> Eecreasing sysctl_perf_event_mlock between two consecutive perf_mmap()s of

Typo: "Decreasing".

> a perf ring buffer may lead to an integer underflow in locked memory
> accounting. This may lead to the undesired behaviors, such as failures in
> BPF map creation.
>
> Address this by adjusting the accounting logic to take into account the
> possibility that the amount of already locked memory may exceed the
> current limit.
>
> Fixes: c4b75479741c ("perf/core: Make the mlock accounting simple again")
> Signed-off-by: Song Liu <songliubraving@fb.com>
> Suggested-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>

Other than that,

Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Thanks,
--
Alex
