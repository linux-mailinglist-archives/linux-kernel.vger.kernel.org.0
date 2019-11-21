Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36AF8104E20
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 09:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfKUIik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 03:38:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:3026 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfKUIik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:38:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 00:38:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,224,1571727600"; 
   d="scan'208";a="209830619"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by orsmga003.jf.intel.com with ESMTP; 21 Nov 2019 00:38:37 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC 10/10] autonuma, memory tiering: Adjust hot threshold automatically
References: <20191101075727.26683-1-ying.huang@intel.com>
        <20191101075727.26683-11-ying.huang@intel.com>
        <20191101093145.GT4131@hirez.programming.kicks-ass.net>
        <877e4gcgsg.fsf@yhuang-dev.intel.com>
        <20191104084924.GB4131@hirez.programming.kicks-ass.net>
Date:   Thu, 21 Nov 2019 16:38:37 +0800
In-Reply-To: <20191104084924.GB4131@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Mon, 4 Nov 2019 09:49:24 +0100")
Message-ID: <87o8x5mxo2.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,

Peter Zijlstra <peterz@infradead.org> writes:

> I still need to think and review the whole concept in more detail, now
> that I've read the patches. But I need to chase regressions first :/

Have you found some time to review the concept?

Just want to check the status.  Please don't regard this as pushing.

Best Regards,
Huang, Ying

