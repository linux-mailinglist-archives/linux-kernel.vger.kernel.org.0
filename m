Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE441170DA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 16:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfLIPuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 10:50:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfLIPut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 10:50:49 -0500
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9788207FF;
        Mon,  9 Dec 2019 15:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575906649;
        bh=z50cp8vM2SpBO12/oa6Uc1IyYJi1iEKeInGOuXNLqJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G113+63wCz0RXQ9kgpAE/x7hV+E2w9Sjx5PKBJmo48dPBblk1XZM9lq+oYewPTmdK
         SCDRMAR4aDcQ0AdnwwADDvKxDP+LRa2XYJP9HLU4kG477ZmOa0Sq5VqbqBRPSvFTwn
         +wl+4x28mBKLHAMAInFH4R+32BkYoqkrObHxkARY=
Date:   Mon, 9 Dec 2019 16:50:46 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Paul Orlyk <pavel.orlik@smartexe.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/6] procfs: Use all-in-one vtime aware kcpustat accessor
Message-ID: <20191209155046.GA32009@lenoir>
References: <20191121024430.19938-1-frederic@kernel.org>
 <20191121024430.19938-4-frederic@kernel.org>
 <14ca94e3-5320-6f95-9d76-101dccb7e1b5@smartexe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ca94e3-5320-6f95-9d76-101dccb7e1b5@smartexe.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2019 at 05:57:47PM +0200, Paul Orlyk wrote:
> Looks like a copy-paste error. I think it should be:
> 
> - guest_nice	+= cpustat[CPUTIME_USER];
> + guest_nice	+= cpustat[CPUTIME_GUEST_NICE];
> 
> and
> 
> - guest_nice	= cpustat[CPUTIME_USER];
> + guest_nice	= cpustat[CPUTIME_GUEST_NICE];
> 
> With best regards,
> Paul Orlyk

Yes the fix should be applied soonish:

https://lore.kernel.org/lkml/20191205020344.14940-1-frederic@kernel.org/

Thanks.

> 
> On 11/21/19 4:44 AM, Frederic Weisbecker wrote:
> > +		guest		+= cpustat[CPUTIME_GUEST];
> > +		guest_nice	+= cpustat[CPUTIME_USER];
> > +		sum		+= kstat_cpu_irqs_sum(i);
> > 
> > +		guest		= cpustat[CPUTIME_GUEST];
> > +		guest_nice	= cpustat[CPUTIME_USER];
> >   		seq_printf(p, "cpu%d", i);
