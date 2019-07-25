Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A75B475AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 00:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfGYWYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 18:24:08 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:40850 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfGYWYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:24:07 -0400
Received: from svr-orw-mbx-01.mgc.mentorg.com ([147.34.90.201])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hqm9c-0007Ly-SM from George_Davis@mentor.com ; Thu, 25 Jul 2019 15:24:04 -0700
Received: from localhost (147.34.91.1) by svr-orw-mbx-01.mgc.mentorg.com
 (147.34.90.201) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 25 Jul
 2019 15:24:02 -0700
Date:   Thu, 25 Jul 2019 18:24:01 -0400
From:   "George G. Davis" <george_davis@mentor.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: Fix null die() string for unhandled data and
 prefetch abort cases
Message-ID: <20190725222401.GB29898@mam-gdavis-lt>
References: <1563589976-19004-1-git-send-email-george_davis@mentor.com>
 <20190720123023.GA1330@shell.armlinux.org.uk>
 <20190725213754.GA29898@mam-gdavis-lt>
 <20190725215540.GM1330@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190725215540.GM1330@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Russell,

On Thu, Jul 25, 2019 at 10:55:40PM +0100, Russell King - ARM Linux admin wrote:
> On Thu, Jul 25, 2019 at 05:37:54PM -0400, George G. Davis wrote:
> > Hello Russell,
> > 
> > Thanks for your prompt reply!
> > 
> > On Sat, Jul 20, 2019 at 01:30:23PM +0100, Russell King - ARM Linux admin wrote:
> > > On Fri, Jul 19, 2019 at 10:32:55PM -0400, George G. Davis wrote:
> > > > When an unhandled data or prefetch abort occurs, the die() string
> > > > is empty resulting in backtrace messages similar to the following:
> > > > 
> > > > 	Internal error: : 1 [#1] PREEMPT SMP ARM
> > > > 
> > > > Replace the null string with the name of the abort handler in order
> > > > to provide more meaningful hints as to the cause of the fault.
> > > 
> > > NAK.
> > > 
> > > We already print the cause of the abort earlier in the dump, and we've
> > > also added a "cut here" marker to help people include all the necessary
> > > information when reporting a problem.
> > 
> > For what it's worth, I often receive crash dumps which lack the pr_alert
> > messages and only include the pr_emerg messages which this change would at
> > least provide extra hints, since the "Internal error" as at EMERG level
> > wereas the initial messages are only at ALERT level. It's subtle but for
> > cases where the end user has set loglevel such that they only see EMERG
> > messages, the change is helpful, to me at least.
> > 
> > > It's unfortunate that we have the additional colon in the oops dump,
> > 
> > Agreed, it's rather unfortunate that the string is NULL in these cases.
> > 
> > > but repeating the information that we've printed on one of the previous
> > > two lines is really not necessary.
> > 
> > It depends on the loglevel the user has set. So perhaps it's not such a
> > bad thing to repeat the information?
> 
> Or maybe we should arrange for consistent usage of the log levels?

Unfortunately, some of the users that I work with have very specific limits
and requirements for kernel error message logging which are driven by
performance and/or storage limitations. So it's not always possible to "arrange
for consistent usage of the log levels" with some users. Meanwhile, these
messages do show up in logs without the pre-able headers, lacking the string
which is already available. It's hardly a big deal to re-use the same string,
especially for the !user_mode(regs) case, where the kernel will oops at
EMERG loglevel, leaving the NULL string as the reason. I can assure you that
I've tried to convince these users to change the loglevel but they have their
reasons for keeping it as they do and I'm unable to convince them otherwise.

Thanks!


-- 
Regards,
George
