Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4311BCC10
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 18:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438720AbfIXQFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 12:05:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:16778 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391013AbfIXQFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:05:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 09:05:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,544,1559545200"; 
   d="scan'208";a="340126790"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga004.jf.intel.com with ESMTP; 24 Sep 2019 09:05:45 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 07164301AF5; Tue, 24 Sep 2019 09:05:45 -0700 (PDT)
Date:   Tue, 24 Sep 2019 09:05:44 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] perf, evlist: Fix access of freed id arrays
Message-ID: <20190924160544.GR8537@tassilo.jf.intel.com>
References: <20190923233339.25326-1-andi@firstfloor.org>
 <20190924074401.GA26797@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924074401.GA26797@krava>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> id/sample_id arrays are not created when evsel is open but
> we free it at close
> 
> for now this fix seems correct to me.. we are moving id/sample_id
> arrays under libperf, I'll make a note to check on close and reopen
> of evsel and add some tests for that
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

It looks like there are still some bogus closes in such a case, at least valgrind
complains about some close(-1). But these should be harmless, so I guess
we can leave them for now.

-Andi
