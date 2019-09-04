Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27CA8A8432
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 15:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbfIDNNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 09:13:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34080 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbfIDNNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cXCf42xtle0EmjyzUVcJOfRd1eEygzlFDZq5fBPSMT4=; b=q6ZKJdu2E+jbmSZuvhZ/4m01oA
        Bwi+adJx6Hh6y1qymMKDxX3ikmY4A6PtodrMpOh4YbbfuTpclXtFfH76QjeBu3a7D30wSQcDNaYzP
        /fbN+UnW6X5eliJjCNBChmA8k2WlYiphtHp7IicClkEI5IW8HSJxCSXeq56v90yH7bEZkiYppnlAw
        Y93RQbcZAZs3HNbbSmnHJFsryEQ5sBiKE5lI7iktIXQfJ9hoRLWWS8WeL00Q43jGcuS39sp4oM6pI
        weSfRCL2cnG9Ge5yIxrj9HZSpK57Vhol5jQIyMVNMvjqeyDijBS3T8Jz5tcRmbNya5zxMy9EwhbvE
        skEYXgOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5V5z-0005av-EL; Wed, 04 Sep 2019 13:13:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E1615303121;
        Wed,  4 Sep 2019 15:12:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7EA5129D8ACE6; Wed,  4 Sep 2019 15:13:09 +0200 (CEST)
Date:   Wed, 4 Sep 2019 15:13:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jirka =?iso-8859-1?Q?Hladk=FD?= <jhladky@redhat.com>,
        =?utf-8?B?SmnFmcOtIFZvesOhcg==?= <jvozar@redhat.com>,
        x86@kernel.org
Subject: Re: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
Message-ID: <20190904131309.GS2332@hirez.programming.kicks-ass.net>
References: <20190903154340.860299-1-rkrcmar@redhat.com>
 <20190903154340.860299-3-rkrcmar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903154340.860299-3-rkrcmar@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 05:43:40PM +0200, Radim Krčmář wrote:

> Red Hat adapted one of them for the tracepoint framework and created a
> tool to plot a heatmap of nr_running, where the sched_update_nr_running
> tracepoint is being used for fine grained monitoring of scheduling
> imbalance.

You should be able to reconstruct this from wakeup and switch
tracepoints.


