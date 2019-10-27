Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC170E6442
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 17:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfJ0Qc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 12:32:56 -0400
Received: from one.firstfloor.org ([193.170.194.197]:43404 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfJ0Qc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 12:32:56 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id BCCEF868A0; Sun, 27 Oct 2019 17:32:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1572193970;
        bh=Qy2BzbwNudZ+K/M+aELzPmKqbE47rBv9XJrJ+gnJi3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q3F5MO7Xcn3BCGNZn1vmupgXeQm3s0wHP5aWbVjhFEGf8Qwz3EIhygQL/I0HKVSMt
         WFwEPSut/cpsepflfcWbxLZhiPNgrSeyx1+lsVenV9KGhEyz2ipWSHLCULIuB0nar7
         rCi+uYn1JrgxL+MWHOXFb/tRMlRedywFpulB34g8=
Date:   Sun, 27 Oct 2019 09:32:50 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, andi@firstfloor.org,
        kan.liang@linux.intel.com, lkp@lists.01.org
Subject: Re: [perf]  06e0dbcfd3:  phoronix-test-suite.mbw.0.mib_s 12.6%
 improvement
Message-ID: <20191027163248.nv63uybzjstoigj5@two.firstfloor.org>
References: <20191022092307.425783389@infradead.org>
 <20191027051812.GJ29418@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191027051812.GJ29418@shao2-debian>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2019 at 01:18:12PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a 12.6% improvement of phoronix-test-suite.mbw.0.mib_s due to commit:

Wow! Sadly it's a false positive, from lowering perf overhead, instead
of improving the workload. Still seems like a good thing.

Note that there is a perf user tool change coming soon that will likely
improve it even more (using affiity to optimize all perf IPIs).

-Andi
