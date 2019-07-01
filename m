Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E9E2C821
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 15:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfE1NuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 09:50:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50460 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfE1NuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qtQb8M3DecPJ3xcklIW2jU9ZnoT8Z8rF5wOjW6hOtCc=; b=u2HDHExsvE0lZKiXzQ+XlMV7r
        sdvB4EzINb/tqDItvQY4QgTiMJ71AdNBwkTxpNtc/2nEdEzcCPweayRU7AJCnPbYLmSGD4ULus+xk
        IMESyWGZY/CtUl5ZsQ0LhzasfGddh0I127Cyb2+LnkZrCurb1mT8Uq1VC007Id1A0mHGdFcUHfEgP
        /8A6UaMJw2qZLQIHgP86QVnBBzDnaKCGfQY8BR9v2f9pZCkUXal2JEC87WF1wScGBBU/hzG3vDH12
        06niyRRdnDZvi91Hu67JuK+DhjQoQrlWhvp/Z5krAaI6gghzxGvUCBsNA8Rl8srLMxjNJAlOKNyfp
        m/cemSdnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVcUX-0004Lf-HC; Tue, 28 May 2019 13:50:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3452220756A00; Tue, 28 May 2019 15:50:12 +0200 (CEST)
Date:   Tue, 28 May 2019 15:50:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 5/9] perf/x86/intel: Set correct weight for TopDown
 metrics events
Message-ID: <20190528135012.GR2623@hirez.programming.kicks-ass.net>
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-6-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521214055.31060-6-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 02:40:51PM -0700, kan.liang@linux.intel.com wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The topdown metrics and slots events are mapped to a fixed counter,
> but should have the normal weight for the scheduler.

You forgot the 'why/because' part of that sentence.

> So special case this.

