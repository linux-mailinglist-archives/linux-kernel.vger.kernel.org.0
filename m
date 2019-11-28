Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03BAD10CD62
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 18:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfK1RAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 12:00:30 -0500
Received: from foss.arm.com ([217.140.110.172]:38648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbfK1RA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 12:00:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 772F71FB;
        Thu, 28 Nov 2019 09:00:29 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 921EF3F6C4;
        Thu, 28 Nov 2019 09:00:28 -0800 (PST)
Date:   Thu, 28 Nov 2019 17:00:26 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/14] torture: Replace cpu_up/down with
 device_online/offline
Message-ID: <20191128170025.ii3vqbj4jpcyghut@e107158-lin.cambridge.arm.com>
References: <20191125112754.25223-1-qais.yousef@arm.com>
 <20191125112754.25223-13-qais.yousef@arm.com>
 <20191127214725.GG2889@paulmck-ThinkPad-P72>
 <20191128165611.7lmjaszjl4gbo7u2@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191128165611.7lmjaszjl4gbo7u2@e107158-lin.cambridge.arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/19 16:56, Qais Yousef wrote:
> On 11/27/19 13:47, Paul E. McKenney wrote:
> > On Mon, Nov 25, 2019 at 11:27:52AM +0000, Qais Yousef wrote:
> > > The core device API performs extra housekeeping bits that are missing
> > > from directly calling cpu_up/down.
> > > 
> > > See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
> > > serialization during LPM") for an example description of what might go
> > > wrong.
> > > 
> > > This also prepares to make cpu_up/down a private interface for anything
> > > but the cpu subsystem.
> > > 
> > > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > > CC: Davidlohr Bueso <dave@stgolabs.net>
> > > CC: "Paul E. McKenney" <paulmck@kernel.org>
> > > CC: Josh Triplett <josh@joshtriplett.org>
> > > CC: linux-kernel@vger.kernel.org
> > 
> > Looks fine from an rcutorture viewpoint, but why not provide an API
> > that pulled lock_device_hotplug() and unlock_device_hotplug() into the
> > online/offline calls?
> 
> I *think* the right way to do what you say is by doing lock_device_hotplug()
> inside device_{online, offline}() - which affects all drivers not just the CPU.
> 
> And even then, I think we need to refcount it so nested calls won't deadlock.

Forget that. I don't think nesting here makes actually any sense.

Thanks

--
Qais Yousef
