Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D42A69FED1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 11:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfH1JpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 05:45:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46126 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1JpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wKuvupVtQ90sap/VGzIsJnfGlysBO3vz+mlOa1XSggE=; b=djuT11ZVNMPm/z1wuYh2fu4t0
        mewwb/uZ1J3TmOa4iINBlplL+FFvVRqrm6wKCtjLYnDVZU6tTZszwiXZjLGU1JIS45Iuf0JKJcGQi
        EwsiztQX3zudU5yIvS4pVJqBZjfiDok7WUbKlSf9ReNmYmgndXm8HlxpNFtld7WmgmB61UT/B/+qn
        7NNALEqS+awe8hOV4/XhsJDGmIXqZDtV9vTsc+lobSNMpFcHOL/bWXTgJ4CWfX1aD6JMJYeGT5ElE
        RuYuzb8Zpiq654EL5pPKaTZNp1Ptvd/eEhlXWL+1vRJfVkyQ/XAlpvHo0Y5SBLitZwN4ggUCflndM
        wL467LEUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2uVh-0008Vq-6p; Wed, 28 Aug 2019 09:45:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B2463074C6;
        Wed, 28 Aug 2019 11:44:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77153201881DF; Wed, 28 Aug 2019 11:44:59 +0200 (CEST)
Date:   Wed, 28 Aug 2019 11:44:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
Message-ID: <20190828094459.GG2369@hirez.programming.kicks-ass.net>
References: <20190828073130.83800-1-namhyung@kernel.org>
 <20190828073130.83800-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828073130.83800-2-namhyung@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 04:31:22PM +0900, Namhyung Kim wrote:
> To support cgroup tracking, add CGROUP event to save a link between
> cgroup path and inode number.  The attr.cgroup bit was also added to
> enable cgroup tracking from userspace.
> 
> This event will be generated when a new cgroup becomes active.
> Userspace might need to synthesize those events for existing cgroups.
> 
> As aux_output change is also going on, I just added the bit here as
> well to remove possible conflicts later.

Why do we want this?

