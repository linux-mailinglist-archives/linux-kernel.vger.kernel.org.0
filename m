Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07B76972E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 09:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfHUHAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 03:00:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53960 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfHUHAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:00:36 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i0Kbb-0004yd-2p; Wed, 21 Aug 2019 09:00:27 +0200
Date:   Wed, 21 Aug 2019 09:00:26 +0200
From:   "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     "Li, Philip" <philip.li@intel.com>,
        Juri Lelli <juri.lelli@gmail.com>, lkp <lkp@intel.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "williams@redhat.com" <williams@redhat.com>
Subject: Re: [RT PATCH v2] net/xfrm/xfrm_ipcomp: Protect scratch buffer with
 local_lock
Message-ID: <20190821070026.q24xtcagwwlraany@linutronix.de>
References: <20190819122731.6600-1-juri.lelli@redhat.com>
 <201908201356.Pffozrxv%lkp@intel.com>
 <20190820064203.GB6860@localhost.localdomain>
 <831EE4E5E37DCC428EB295A351E66249520CA35E@shsmsx102.ccr.corp.intel.com>
 <20190821064422.GE6860@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190821064422.GE6860@localhost.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-21 08:44:22 [+0200], Juri Lelli wrote:
> > Hi Juri, currently if the mail subject has RFC, we will test it but send report
> > privately to author only.
> 
> OK. But, my email had "RT" and not "RFC" in the subject (since it is
> meant for one of the PREEMPT_RT stable trees [1]).

Was the RT tag consider at all at some point? I remember I asked for it
and then the bot did not complain again or I don't remember. At the same
point my rt-devel tree was added to the trees-to-be-tested.

> Best,
> 
> Juri
> 
> 1 - git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git v4.19-rt

Sebastian
