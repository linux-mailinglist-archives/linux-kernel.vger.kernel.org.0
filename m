Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D11DBC26C0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 22:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbfI3Uju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 16:39:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:62104 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730539AbfI3Uju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:39:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 11:18:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,568,1559545200"; 
   d="scan'208";a="197617751"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Sep 2019 11:18:31 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 33B14301B07; Mon, 30 Sep 2019 11:18:31 -0700 (PDT)
Date:   Mon, 30 Sep 2019 11:18:31 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, acme@kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH V4 07/14] perf/x86/intel: Support hardware TopDown metrics
Message-ID: <20190930181831.GC8560@tassilo.jf.intel.com>
References: <20190916134128.18120-1-kan.liang@linux.intel.com>
 <20190916134128.18120-8-kan.liang@linux.intel.com>
 <20190930130615.GN4553@hirez.programming.kicks-ass.net>
 <20190930140755.GE4581@hirez.programming.kicks-ass.net>
 <20190930145321.GF4581@hirez.programming.kicks-ass.net>
 <06e16f73-f6af-5019-3d85-bc33740e0c8f@linux.intel.com>
 <20190930162153.GG4519@hirez.programming.kicks-ass.net>
 <8d255708-6b8d-c18d-1491-cb19e3c6be4d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d255708-6b8d-c18d-1491-cb19e3c6be4d@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Andi, what do you think? Will it be a problem for RDPMC users?

Should be fine.

RDPMC users only need slots anyways, as they managed RDPMC on their own.

We can document it in the documentation. And they will see an 
error if they only enable a metrics event.

-Andi
