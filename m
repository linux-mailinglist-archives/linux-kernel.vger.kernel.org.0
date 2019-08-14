Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E628D786
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 17:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfHNP61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 11:58:27 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:47256 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfHNP60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 11:58:26 -0400
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1hxvfK-0005VF-00; Wed, 14 Aug 2019 15:58:22 +0000
Date:   Wed, 14 Aug 2019 11:58:22 -0400
From:   Rich Felker <dalias@libc.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
        oleg@redhat.com, alistair23@gmail.com, ebiederm@xmission.com,
        arnd@arndb.de, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, fweimer@redhat.com,
        palmer@sifive.com, macro@wdc.com, zongbox@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk, hpa@zytor.com
Subject: Re: [PATCH v3 0/1] waitid: process group enhancement
Message-ID: <20190814155822.GI9017@brightrain.aerifal.cx>
References: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
 <20190814154400.6371-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814154400.6371-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 05:43:59PM +0200, Christian Brauner wrote:
> Hey everyone,
> 
> This patch adds support for waiting on the current process group by
> specifying waitid(P_PGID, 0, ...) as discussed in [1]. The details why
> we need to do this are in the commit message of [PATCH 1/1] so I won't
> repeat them here.
> 
> I've picked this up since the thread has gone stale and parts of
> userspace are actually blocked by this.
> 
> Note that the patch has been changed to be more closely aligned with the
> P_PIDFD changes to waitid() I have sitting in my for-next branch (cf. [2]).
> This makes the merge conflict a little simpler and picks up on the
> coding style discussions that guided the P_PIDFD patchset.
> 
> There was some desire to get this feature in with 5.3 (cf. [3]).
> But given that this is a new feature for waitid() and for the sake of
> avoiding any merge conflicts I would prefer to land this in the 5.4
> merge window together with the P_PIDFD changes.

That makes 5.4 (or later, depending on other stuff) the hard minimum
for RV32 ABI. Is that acceptable? I was under the impression (perhaps
mistaken) that 5.3 was going to be next LTS series which is why I'd
like to have the necessary syscalls for a complete working RV32
userspace in it. If I'm wrong about that please ignore me. :-)

Rich
