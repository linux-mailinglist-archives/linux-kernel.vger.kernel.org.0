Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACB0013A4D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 11:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgANKCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 05:02:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41060 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbgANKCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DyoJ2hA1fU1X63Qmz1hq0mnr1uqWmaszLSaW5lT0+iI=; b=o/xjIevWfUgEeraf8BCj8KgN3
        YkxD+ytudJ1eE7zpSCVU/jnmToR85ngrnVeb87obRoSGaIbr1tb8xIEdBzQuDzzK3iBbIuC09Aj4n
        rNRIFAZx8dEyQ7qa9nq/VKMa57fF/KONbVUbXtdTNQJ2o2XHE9cAmBgzcYLBfCSbD3PbRrk1wbWL/
        7LMHJBTg+6m+86p8GW6cGfNSB5TzX9ekTKQ8gGaAOdyjh0pf1fKJ41zx/wMqtXWUbPEIv914jgJkV
        NSZ9GHlp1SEEbflQFHRzugy8DuajSukBxpb0MgfN5FkFpCNupyrQs7b0GsGDnW7ow/+ntTLEeGz7m
        Cb0NtJJcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irJ1m-0003IE-TS; Tue, 14 Jan 2020 10:02:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E66793058B4;
        Tue, 14 Jan 2020 11:00:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E1A12B6AFB83; Tue, 14 Jan 2020 11:02:24 +0100 (CET)
Date:   Tue, 14 Jan 2020 11:02:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Hewenliang <hewenliang4@huawei.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] idle: fix spelling mistake "iterrupts" -> "interrupts"
Message-ID: <20200114100224.GC2844@hirez.programming.kicks-ass.net>
References: <20200110025604.34373-1-hewenliang4@huawei.com>
 <20200113160413.5afcfbd7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113160413.5afcfbd7@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 04:04:13PM -0500, Steven Rostedt wrote:
> 
> Peter,
> 
> I guess you could just pull this into one of your queues.

Only because you replied, otherwise I tend to ignore such patches.

