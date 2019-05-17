Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3271C219C4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 16:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfEQO1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 10:27:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36814 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbfEQO1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 10:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3AhGGBz/ENxpcy9k9rzprnVRAy6YatWW+1KT7EjI1fI=; b=IVPRratiQN7Z5egN8lsC8anA9
        5+2ZEtEgSCQjJFLSkNaS9fe/vaGsZQ1Xixdl1RnmD1wJwJHxP57DA51vJZjH1WbgbRSdby1mC+skW
        5DaeS6bIM/3vFPxUWRdM9Aa5thWG4ILspsohm4DnnznLUykv0nxv9gNDtFAqxy0K3hJ5s8mKWIShZ
        3PUvpM9UPgMmhSgy0/lEjCu2JfC3IU5+0L04BmOiy+oouPhlev1KjxE/cQW5fAYDmcatntKaL0stM
        FsgATQ3XXOfS6cnkKefB7ctXsysaKA2VNKtyNDYrt6VNSIS9R+68G8tKKlZ2k4LNsWxomHhV2kLDk
        GH17J+3uQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRdox-0001zT-15; Fri, 17 May 2019 14:26:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EBF012029B0A3; Fri, 17 May 2019 16:26:48 +0200 (CEST)
Date:   Fri, 17 May 2019 16:26:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     yabinc@google.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 1/4] perf/ring_buffer: Fix exposing a temporarily
 decreased data_head.
Message-ID: <20190517142648.GC2589@hirez.programming.kicks-ass.net>
References: <20190517115230.437269790@infradead.org>
 <20190517115418.224478157@infradead.org>
 <20190517130509.GA90824@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517130509.GA90824@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 03:05:09PM +0200, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > In perf_output_put_handle(), an IRQ/NMI can happen in below location and
> > write records to the same ring buffer:
> > 	...
> > 	local_dec_and_test(&rb->nest)
> > 	...                          <-- an IRQ/NMI can happen here
> > 	rb->user_page->data_head = head;
> > 	...
> > 
> > In this case, a value A is written to data_head in the IRQ, then a value
> > B is written to data_head after the IRQ. And A > B. As a result,
> > data_head is temporarily decreased from A to B. And a reader may see
> > data_head < data_tail if it read the buffer frequently enough, which
> > creates unexpected behaviors.
> > 
> > This can be fixed by moving dec(&rb->nest) to after updating data_head,
> > which prevents the IRQ/NMI above from updating data_head.
> > 
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Fixes: ef60777c9abd ("perf: Optimize the perf_output() path by removing IRQ-disables")
> > Signed-off-by: Yabin Cui <yabinc@google.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Link: https://lkml.kernel.org/r/20190516184010.167903-1-yabinc@google.com
> 
> So these are missing a bunch of:
> 
>   From: Yabin Cui <yabinc@google.com>
> 
> lines, right?
> 

The first. certainly, the rest, while inspired by his patch, is more
complete than what he did.
