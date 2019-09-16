Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 784EEB3703
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 11:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731896AbfIPJVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 05:21:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38593 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbfIPJVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 05:21:54 -0400
Received: from pd9ef19d4.dip0.t-ipconnect.de ([217.239.25.212] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i9nCh-0004HW-4J; Mon, 16 Sep 2019 11:21:51 +0200
Date:   Mon, 16 Sep 2019 11:21:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, dave.hansen@intel.com,
        tony.luck@intel.com, ak@linux.intel.com, ravi.v.shankar@intel.com
Subject: Re: [PATCH v8 00/17] Enable FSGSBASE instructions
In-Reply-To: <034aaf3a-a93d-ec03-0bbd-068e1905b774@kernel.org>
Message-ID: <alpine.DEB.2.21.1909161119340.10731@nanos.tec.linutronix.de>
References: <1568318818-4091-1-git-send-email-chang.seok.bae@intel.com> <034aaf3a-a93d-ec03-0bbd-068e1905b774@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2019, Andy Lutomirski wrote:

Thanks, for adding me and the others on Cc. I had to dig out the cover
letter from my LKML archive ....

> On 9/12/19 1:06 PM, Chang S. Bae wrote:
> 
> > Updates from v7 [7]:
> > (1) Consider FSGSBASE when determining which Spectre SWAPGS mitigations are
> >      required.
> > (2) Fixed save_fsgs() to be aware of interrupt conditions
> > (3) Made selftest changes based on Andy's previous fixes and cleanups
> > (4) Included Andy's paranoid exit cleanup
> > (5) Included documentation rewritten by Thomas
> > (6) Carried on Thomas' edits on multiple changelogs and comments
> > (7) Used '[FS|GS] base' consistently, except for selftest where GSBASE has
> >      been already used in its test messages
> > (8) Dropped the READ_MSR_GSBASE macro
> > 
> 
> This looks unpleasant to review.  I wonder if it would be better to unrevert
> the reversion, merge up to Linus' tree or -tip, and then base the changes on
> top of that.

I don't think that's a good idea. The old code is broken in several ways
and not bisectable. So we really better start from scratch.

Thanks,

	tglx
