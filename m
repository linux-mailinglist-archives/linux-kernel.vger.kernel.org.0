Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85EA4B5CF1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 08:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfIRGY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 02:24:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:36094 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727790AbfIRGYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:24:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11B00AF8E;
        Wed, 18 Sep 2019 06:24:19 +0000 (UTC)
Date:   Tue, 17 Sep 2019 23:24:04 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking: locktorture: Do not include rwlock.h directly
Message-ID: <20190918062404.hyk5p2gs4mtybl3t@linux-p48b>
References: <20190916145404.bukcmlliequu77wk@linutronix.de>
 <20190917071614.kcmux562y6wbskj5@linux-p48b>
 <20190917170620.GC30224@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190917170620.GC30224@paulmck-ThinkPad-P72>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019, Paul E. McKenney wrote:

>On Tue, Sep 17, 2019 at 12:16:14AM -0700, Davidlohr Bueso wrote:
>> On Mon, 16 Sep 2019, Sebastian Andrzej Siewior wrote:
>>
>> > From: Wolfgang M. Reimer <linuxball@gmail.com>
>> >
>> > Including rwlock.h directly will cause kernel builds to fail
>> > if CONFIG_PREEMPT_RT is defined. The correct header file
>> > (rwlock_rt.h OR rwlock.h) will be included by spinlock.h which
>> > is included by locktorture.c anyway.
>> >
>> > Remove the include of linux/rwlock.h.
>> >
>>
>> Acked-by: Davidlohr Bueso <dbueso@suse.de>
>
>Applied, thank you!
>
>But does anyone actually run locktorture?

I do at least. I also know of cases of other folks making use of the
"framework" to test/pound on custom tailored locks -- ie btrfs tree lock.

I've also seen it in one or two academic papers.

Thanks,
Davidlohr
