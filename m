Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C578D10EBFF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 16:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfLBPAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 10:00:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:39669 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbfLBPAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 10:00:12 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 06:59:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,268,1571727600"; 
   d="scan'208";a="218382418"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga001.fm.intel.com with ESMTP; 02 Dec 2019 06:59:57 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 543A53004F7; Mon,  2 Dec 2019 06:59:57 -0800 (PST)
Date:   Mon, 2 Dec 2019 06:59:57 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org,
        eranian@google.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com
Subject: Re: [RFC PATCH 3/8] perf: Init/fini PMU specific data
Message-ID: <20191202145957.GM84886@tassilo.jf.intel.com>
References: <1574954071-6321-1-git-send-email-kan.liang@linux.intel.com>
 <1574954071-6321-3-git-send-email-kan.liang@linux.intel.com>
 <20191202124055.GC2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202124055.GC2827@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> This is atricous crap. Also it is completely broken for -RT.

Well can you please suggest how you would implement it instead?

-Andi
