Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 035F0A43AC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 11:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfHaJ32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Aug 2019 05:29:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41068 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfHaJ32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 05:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KmR/c4ArTiru3qyk+20TYV+nkGr/yqWbxKniMkdJ5RQ=; b=Z5GopLAK//pWlmGZC0W1UOjiM
        Q8o7ry9QSbPDGazdsuNAy0nl7ihSFMqZQcjds4bMS2mdw/meSo+bzAgQxHW7I/sK5VPZIJbbRnps6
        TxvovqVkyTmvE9KEiC/cs0FCXMF4v+9LCYIFZSXuTe9uvS8aCHEzwtBPK8bikCGPN4iZrosrvemKH
        U5TifBQzUyt0LrQc8WdQczV+emqbFC/+3aqPiEz6pA9l7Yg5u60dQTzqtT4rS3jjRMlqQgB0z7vWC
        lACy0RJTvfehGz/91ri+DNlJGg0zwNXP0nPhzLcMska/y18yST1iySUHebhcJvVXBxwfUn7oLTy/s
        AKy0+s8lQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3zhD-0004WD-Mj; Sat, 31 Aug 2019 09:29:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E794300B8D;
        Sat, 31 Aug 2019 11:28:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED7C729B2CD2F; Sat, 31 Aug 2019 11:29:21 +0200 (CEST)
Date:   Sat, 31 Aug 2019 11:29:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [RESEND PATCH V3 3/8] perf/x86/intel: Support hardware TopDown
 metrics
Message-ID: <20190831092921.GK2369@hirez.programming.kicks-ass.net>
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-4-kan.liang@linux.intel.com>
 <CABPqkBTS8bRjSwOBm2HxtuDWhxeZrTGa_E8mqfRfEJPzX1BNhw@mail.gmail.com>
 <20190831003110.GA5447@tassilo.jf.intel.com>
 <CABPqkBSPfZ6iQ_t1ESZf334q+dNVf=RvoNHdmKZSs5GLokbjFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBSPfZ6iQ_t1ESZf334q+dNVf=RvoNHdmKZSs5GLokbjFQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 02:13:05AM -0700, Stephane Eranian wrote:

> With PERF_METRICS, the delta is always since previous read. If you read
> frequently enough you do not lose precision.

You always loose precision, the whole fraction of 255 looses the
fractional part; consider:

255 * 1 / 8
31.87500000000000000000
255 * 7 / 8
223.12500000000000000000

31 * 8 / 255
.97254901960784313725
223 * 8 / 255
6.99607843137254901960

Now, we can make reconstruction use normal 'round-nearest' and then we'd
get 1 and 7 back, but there's always cases where you loose things.

Also, with 255 being an odd number, round-nearest is actually 'hard' :/
