Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3C2D0707
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 08:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbfJIGFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 02:05:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:48616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726651AbfJIGFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:05:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED5F9AC19;
        Wed,  9 Oct 2019 06:05:39 +0000 (UTC)
Date:   Wed, 9 Oct 2019 08:05:39 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: vmalloc: Use the vmap_area_lock to protect
 ne_fit_preload_node
Message-ID: <20191009060539.fmpqesc4wfisulrl@beryllium.lan>
References: <20191004162041.GA30806@pc636>
 <20191004163042.jpiau6dlxqylbpfh@linutronix.de>
 <20191007083037.zu3n5gindvo7damg@beryllium.lan>
 <20191007105631.iau6zhxqjeuzajnt@linutronix.de>
 <20191007162330.GA26503@pc636>
 <20191007163443.6owts5jp2frum7cy@beryllium.lan>
 <20191007165611.GA26964@pc636>
 <20191007173644.hiiukrl2xryziro3@linutronix.de>
 <20191007214420.GA3212@pc636>
 <20191008160459.GA5487@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008160459.GA5487@pc636>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 06:04:59PM +0200, Uladzislau Rezki wrote:
> > so, we do not guarantee, instead we minimize number of allocations
> > with GFP_NOWAIT flag. For example on my 4xCPUs i am not able to
> > even trigger the case when CPU is not preloaded.
> > 
> > I can test it tomorrow on my 12xCPUs to see its behavior there.
> > 
> Tested it on different systems. For example on my 8xCPUs system that
> runs PREEMPT kernel i see only few GFP_NOWAIT allocations, i.e. it
> happens when we land to another CPU that was not preloaded.
> 
> I run the special test case that follows the preload pattern and path.
> So 20 "unbind" threads run it and each does 1000000 allocations. As a
> result only 3.5 times among 1000000, during splitting, CPU was not
> preloaded thus, GFP_NOWAIT was used to obtain an extra object.
> 
> It is obvious that slightly modified approach still minimizes allocations
> in atomic context, so it can happen but the number is negligible and can
> be ignored, i think.

Thanks for doing the tests. In this case I would suggest to get rid of
the preempt_disable() micro optimization, since there is almost no
gain in doing so. Do you send a patch? :)

Thanks,
Daniel
