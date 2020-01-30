Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8904214DA5E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 13:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgA3MG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 07:06:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:60580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgA3MG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 07:06:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B3383B053;
        Thu, 30 Jan 2020 12:06:24 +0000 (UTC)
Date:   Thu, 30 Jan 2020 13:06:17 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Damian Tometzki <damian.tometzki@familie-tometzki.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/asm changes for v5.6
Message-ID: <20200130120617.GH6684@zn.tnic>
References: <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
 <20200129132618.GA30979@zn.tnic>
 <20200129170725.GA21265@agluck-desk2.amr.corp.intel.com>
 <CAHk-=wgns2Tvph77XZWN=r_qAtUwxrTzDXNffi8nGKz1mLZNHw@mail.gmail.com>
 <20200129183404.GB30979@zn.tnic>
 <c08616b8-d209-ff08-1b74-645a49a486d2@familie-tometzki.de>
 <20200130075549.GA6684@zn.tnic>
 <20200130111057.GA21459@linux.ibm.com>
 <20200130115326.GG6684@zn.tnic>
 <20200130115959.GA24611@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200130115959.GA24611@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 01:59:59PM +0200, Mike Rapoport wrote:
> I've seen similar crash with my qemu/kvm and bisected it to that commit.
> 
> The hpet allocation is off-by-one and as a result hpet corrupts the memory
> somewhere in the slab

Oh wow, wonderful. Good that we have bisection in such cases - there's
no way in hell I'll debug it to that. ;-\

Thanks for saving me a bunch of time.

Damian, can you test the patch at the bottom of that mail:

https://lore.kernel.org/lkml/202001300450.00U4ocvS083098@www262.sakura.ne.jp/

?

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
