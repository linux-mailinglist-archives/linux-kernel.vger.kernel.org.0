Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54EC3988D8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 03:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbfHVBCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 21:02:54 -0400
Received: from verein.lst.de ([213.95.11.211]:42405 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729135AbfHVBCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 21:02:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9778868BFE; Thu, 22 Aug 2019 03:02:50 +0200 (CEST)
Date:   Thu, 22 Aug 2019 03:02:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch V2 00/38] posix-cpu-timers: Cleanup and consolidation
Message-ID: <20190822010250.GC11104@lst.de>
References: <20190821190847.665673890@linutronix.de> <20190822005434.GA10938@lst.de> <20190822010203.GG22020@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822010203.GG22020@lenoir>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 03:02:04AM +0200, Frederic Weisbecker wrote:
> > which repeats every time I fetch.  I can't of anythign particular on
> > my side that would cause this.
> 
> Yeah I had to run "git remote prune tip" and fetch again.
> 
> Apparently there was an old remote branch tip/WIP.timers and git
> seem to refuse to have a new subpath branch.

Thanks, that seems to have fixed the issue for me.
