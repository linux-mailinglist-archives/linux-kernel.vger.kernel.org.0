Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 048A11B305
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 11:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfEMJi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 05:38:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52966 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfEMJi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EOMyEqF1qjAdoE9hGBYANAzZcg8x/ch+Eh4Wo8gnR6M=; b=Y5nDUuc0UV1wdqMibSk6tR0ie
        JV36oM6TdsT/F2560ygrGFlT7VCSaOGPtB6khmRO4Qm58QI1a8t2hyu4+d/D/6Gu8CDAHR035Onlb
        fD7nKeQSYi77TdRowiDhSQbFmge0VXxoz7jHfGCLvUkMrvPwNR7e8yDeEOTjh37ZoNRSk/gYQXmF6
        PbuTwRRvMgSjB9kUDh/l7zHpgp3GaeW8LWFPQbg/4N1ZocDtVUNnKLP7Dp/i778dOobDktPI0lVmq
        FdaQrpEgirDnvseIlEa/8MzRftBtL3cob/NMVxAreIDc2wrFw/8azqEumyIvcrPPDdToUXGTx8p5F
        tgce9UJ8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ7Pb-0005ri-93; Mon, 13 May 2019 09:38:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF24A2029F888; Mon, 13 May 2019 11:38:21 +0200 (CEST)
Date:   Mon, 13 May 2019 11:38:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv2 0/9] perf/x86: Add update attribute groups
Message-ID: <20190513093821.GN2623@hirez.programming.kicks-ass.net>
References: <20190512155518.21468-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512155518.21468-1-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 05:55:09PM +0200, Jiri Olsa wrote:
> following up on [1], this patchset adds update attribute groups
> to pmu and gets rid of the 'creative' attribute handling code.

Thanks! Queued them.
