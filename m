Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9625397DCE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 16:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfHUO6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 10:58:41 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:35211 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfHUO6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:58:40 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id EB227200005;
        Wed, 21 Aug 2019 14:58:37 +0000 (UTC)
Date:   Wed, 21 Aug 2019 16:58:37 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Alexander Dahl <ada@thorsis.com>, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.2.9-rt3
Message-ID: <20190821145837.GD27031@piout.net>
References: <20190816153616.fbridfzjkmfg4dnr@linutronix.de>
 <2182739.9IRgZpf3R8@ada>
 <20190820154418.GM3545@piout.net>
 <20190821132553.gjvya5lu6j2dfyo5@linutronix.de>
 <20190821142110.GC27031@piout.net>
 <20190821144230.knlyrnxz62d75hcb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821144230.knlyrnxz62d75hcb@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2019 16:42:30+0200, Sebastian Andrzej Siewior wrote:
> On 2019-08-21 16:21:10 [+0200], Alexandre Belloni wrote:
> > I'm not sure it is worth it as the issue is introduced by
> > clocksource-tclib-allow-higher-clockrates.patch. Shouldn't we fix it
> > directly?
> 
> you want to get rid of CONFIG_ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK and use
> the highest possible frequency by default? 
> 

No, I meant the issue fixed by clocksource-tclib-add-proper-depend.patch
is introduced by clocksource-tclib-allow-higher-clockrates.patch so I
would think fixing clocksource-tclib-allow-higher-clockrates.patch is
preferable than having a separate patch.

But maybe you meant you wanted a patch to fix
clocksource-tclib-allow-higher-clockrates.patch

Hopefully, one day we will have a solution for that upstream (i.e. being
able to configure the clocksource and clockevent resolutions).

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
