Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1FBD44B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 17:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfJKPrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 11:47:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:60278 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727399AbfJKPri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:47:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9B39B229;
        Fri, 11 Oct 2019 15:47:36 +0000 (UTC)
Date:   Fri, 11 Oct 2019 08:46:23 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        1vier1@web.de, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: wake_q memory ordering
Message-ID: <20191011154623.zawmihahq6dria7u@linux-p48b>
References: <990690aa-8281-41da-4a46-99bb8f9fec31@colorfullife.com>
 <20191010114244.GS2311@hirez.programming.kicks-ass.net>
 <7af22b09-2ab9-78c9-3027-8281f020e2e8@colorfullife.com>
 <20191010123219.GO2328@hirez.programming.kicks-ass.net>
 <20191010192508.3yvpc5r6oqjq5tbr@linux-p48b>
 <0312fc72-74f1-ea3e-8301-f94bba742735@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0312fc72-74f1-ea3e-8301-f94bba742735@colorfullife.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2019, Manfred Spraul wrote:
>I don't know. The new documentation would not have answered my 
>question (is it ok to combine smp_mb__before_atomic() with 
>atomic_relaxed()?). And it copies content already present in 
>atomic_t.txt.

Well, the _relaxed (and release/acquire) extentions refer to a
_successful_ operation (LL/SC), and whether it has barriers on
each of the sides before and after. I thought you were mainly
worried about the failed CAS scenario, not the relaxed itself.

I don't know how this copies content from atomic_t.txt, at no
point does it talk about failed CAS.

>
>Thus: I would prefer if the first sentence of the paragraph is 
>replaced: The list of operations should end with "...", and it should 
>match what is in atomic_t.txt

I'll see about combining some of your changes in patch 5/5 of
your new series, but have to say I still prefer my documentation
change.

Thanks,
Davidlohr
