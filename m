Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E129DED17
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 15:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfJUNGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 09:06:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:36694 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727256AbfJUNGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:06:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6148DB63D;
        Mon, 21 Oct 2019 13:06:05 +0000 (UTC)
Date:   Mon, 21 Oct 2019 15:06:05 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Test softlockup
Message-ID: <20191021130604.yucvx2u5z6db6olm@pathway.suse.cz>
References: <20190819104732.20966-1-pmladek@suse.com>
 <20190819104732.20966-4-pmladek@suse.com>
 <20191021124518.GF1817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021124518.GF1817@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-10-21 14:45:18, Peter Zijlstra wrote:
> On Mon, Aug 19, 2019 at 12:47:32PM +0200, Petr Mladek wrote:
> > Trigger busy loop by:
> > $> cat /proc/version
> > 
> > Stop the busy loop by:
> > $> cat /proc/consoles
> > 
> > The code also shows the first touch*watchdog() function that hides
> > softlockup on a "well known" location.
> 
> This seems like a terrible interface...

Ah, this was just a patch for testing. It was not meant to be applied.
I am sorry for confusion.

Best Regards,
Petr
