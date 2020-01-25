Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 551D91496D0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jan 2020 18:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgAYRLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jan 2020 12:11:32 -0500
Received: from ms.lwn.net ([45.79.88.28]:53302 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgAYRLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 12:11:32 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CFE552F5;
        Sat, 25 Jan 2020 17:11:31 +0000 (UTC)
Date:   Sat, 25 Jan 2020 10:11:30 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3] dynamic_debug: allow to work if debugfs is disabled
Message-ID: <20200125101130.449a8e4d@lwn.net>
In-Reply-To: <20200125014231.GI147870@mit.edu>
References: <20200122080352.GA15354@willie-the-truck>
        <20200122081205.GA2227985@kroah.com>
        <20200122135352.GA9458@kroah.com>
        <8d68b75c-05b8-b403-0a10-d17b94a73ba7@akamai.com>
        <20200122192940.GA88549@kroah.com>
        <20200122193118.GA88722@kroah.com>
        <20200123155340.GD147870@mit.edu>
        <20200123175536.GA1796501@kroah.com>
        <20200124060200.GG147870@mit.edu>
        <20200124072940.GA2909311@kroah.com>
        <20200125014231.GI147870@mit.edu>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2020 20:42:31 -0500
"Theodore Y. Ts'o" <tytso@mit.edu> wrote:

> On Fri, Jan 24, 2020 at 08:29:40AM +0100, Greg Kroah-Hartman wrote:
> > > It's likely that people who normally use
> > > distribution kernels where debugfs is disabled will have scripts which
> > > are hard-coded to look in /proc, and then when they build a kernel
> > > with debugfs enabled, the /proc entry will go **poof**, and their
> > > script will break.  
> > 
> > **poof** they didn't test it :)
> > 
> > Seriously, I am doing this change to make it _easier_ for those people
> > who want debugfs disabled, yet want this type of debugging.  This is
> > much better than having no debugging at all.
> > 
> > Don't put extra complexity in the kernel for when it can be trivially
> > handled in userspace, you know this :)  
> 
> It's also trivial to handle this in the kernel by potentially having
> the control file appear in two places.  Consider what it would be like
> to explain this in the Linux documentation --- "the control file could
> be here, or it could be there", depending on how the kernel is
> configured.  The complexity of documenting this, and the complexity in
> userspace; and we have to have the code in the source code for the
> file to be in the appear in both places *anyway*.

FWIW, avoiding the need to document something like this has been a
motivating factor behind a number of my patches over the years.

Moving a control knob based on kernel configuration is a user-hostile
feature.  Scripts can be made to cope with this kind of behavior in one
place; if you let such things accumulate in a system, though, it gets to
the point where it's really hard for anybody to keep track of all the
pieces and be sure that their code will work.

If dynamic debug is meant to be a feature supported on all kernels, it
should, IMO, be lifted out of debugfs and made into a proper feature - with
a compatibility link left behind in debugfs for as long as it's needed, of
course.

</sermon> :)

jon
