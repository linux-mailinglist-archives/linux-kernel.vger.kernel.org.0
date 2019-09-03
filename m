Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6511EA6962
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 15:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbfICNJe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Sep 2019 09:09:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60192 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbfICNJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:09:33 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i58Ys-0000gh-Mb; Tue, 03 Sep 2019 15:09:30 +0200
Date:   Tue, 3 Sep 2019 15:09:30 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Clark Williams <clark.williams@gmail.com>
Cc:     bigeasy@linutronix.com, tglx@linutronix.com,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PREEMPT_RT PATCH 2/3] i915: convert all irq_locks spinlocks to
 raw spinlocks
Message-ID: <20190903130930.isctetjvzckgubuh@linutronix.de>
References: <20190820003319.24135-1-clark.williams@gmail.com>
 <20190820003319.24135-3-clark.williams@gmail.com>
 <20190903080335.pe45dmgmjvdvbyd4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190903080335.pe45dmgmjvdvbyd4@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-03 10:03:35 [+0200], To Clark Williams wrote:
> anything in a brief test. What I saw however is that switching to
> fullscreen while playing a video gives me ~0.5 to ~2ms latency. This is
> has nothing to do with this change, I have to dig deeper… It might be
> one of the preempt_disable() section I just noticed.
> I would prefer to keep the lock non-raw unless there is actual need for
> it.

That latency spike is caused by the iommu, qi_submit_sync() to be exact.
Without the iomm I don't see much difference between the two patches…
 
Sebastian
