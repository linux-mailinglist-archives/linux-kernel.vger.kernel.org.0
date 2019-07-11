Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1C8B64CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 21:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfGJThp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 15:37:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:29980 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727330AbfGJThp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 15:37:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 12:37:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,475,1557212400"; 
   d="scan'208";a="365036280"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jul 2019 12:37:43 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id B9A263019F7; Wed, 10 Jul 2019 12:37:43 -0700 (PDT)
Date:   Wed, 10 Jul 2019 12:37:43 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        kan.liang@linux.intel.com, mingo@redhat.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel: Fix spurious NMI on fixed counter
Message-ID: <20190710193743.GC32439@tassilo.jf.intel.com>
References: <20190625142135.22112-1-kan.liang@linux.intel.com>
 <20190625145834.GA8480@krava>
 <a0722e4d-4cae-7212-c8ec-a8d0c9edc08c@linux.intel.com>
 <20190705114435.GQ3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705114435.GQ3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > oops, I overlooed this, looks good
> > > 
> > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Have it now, thanks!

Can Kan's patch please be merged asap and also put into stable for 5.2?

The regression causes crashes on Icelake when fixed counters
are used in PEBS groups, and presumably also on Goldmont Plus.

I just had to debug this again until I realized it was the 
same problem.

-Andi

