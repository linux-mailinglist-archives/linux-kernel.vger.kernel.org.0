Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2A52139561
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 16:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgAMP7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 10:59:39 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35298 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbgAMP7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/pevCa93KHqfbMoDCpY5wsv4jaMKrRibMGIqXRPVA6E=; b=iDXLgDDvIoj9wg5DltxvLrdR4
        Eupi3SdBufVUgd1ffaogni2b203DcAZ0wTsFDfrijEf4+59yeq/1yVe9ZKiRNI+WXHeJVbInj4F2I
        lEXcox2nGBWH0gB1PPxmZEVlNDKqmgRk0zNaGRAeD0Fb3N48ZgqfNOye0aRF5AzKzt30b3+s5YTn4
        yGuQ5fbNq9O+WovLYNEWlCOenZcg2baXz+tqI8If/ic07fGuvaoZf1VbSGvBzcdv+hjacruyw4nhh
        0lggbRIeQ/f/b1L0UcbGx/VJJ2W6htYHi34yZS3LlMV9oCJUMKKG6ybaa5gb5Fb9dJp2h7gNpVID1
        hJD/Q/2sQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ir27r-0000E9-So; Mon, 13 Jan 2020 15:59:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E5403042BC;
        Mon, 13 Jan 2020 16:57:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9938920427392; Mon, 13 Jan 2020 16:59:34 +0100 (CET)
Date:   Mon, 13 Jan 2020 16:59:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 4/6] locking/lockdep: Reuse freed chain_hlocks entries
Message-ID: <20200113155934.GZ2844@hirez.programming.kicks-ass.net>
References: <20191216151517.7060-1-longman@redhat.com>
 <20191216151517.7060-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216151517.7060-5-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:15:15AM -0500, Waiman Long wrote:
> An internal nfsd test that ran for more than an hour could cause the
> following message to be displayed.
> 
>   [ 4318.443670] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!

I'm guessing the pertinent detail you forget to mention here is that
that test re-loads the nfs modules lots of times?
