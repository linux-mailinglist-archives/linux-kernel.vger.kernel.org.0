Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 508B114C2F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 23:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgA1WbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 17:31:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:38314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgA1WbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:31:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 12032ADD7;
        Tue, 28 Jan 2020 22:31:21 +0000 (UTC)
Date:   Tue, 28 Jan 2020 23:31:10 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Luck, Tony" <tony.luck@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/asm changes for v5.6
Message-ID: <20200128223110.GB6787@zn.tnic>
References: <20200128165906.GA67781@gmail.com>
 <CAHk-=wgm+2ac4nnprPST6CnehHXScth=A7-ayrNyhydNC+xG-g@mail.gmail.com>
 <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7F5517F9@ORSMSX114.amr.corp.intel.com>
 <CAHk-=wipvtDUE=MZ=y7v1Xm7PE0pAaUwS26X1Zx5iL768yK=oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wipvtDUE=MZ=y7v1Xm7PE0pAaUwS26X1Zx5iL768yK=oQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 01:04:19PM -0800, Linus Torvalds wrote:
> On Tue, Jan 28, 2020 at 12:41 PM Luck, Tony <tony.luck@intel.com> wrote:
> >
> > Is there still some easy way to get gdb to disassemble from /dev/kmem
> > to see what we ended up with after all the patching?
> 
> Hmm. No, I think it's all gone.
> 
> It _used_ to be easy to just do "objdump --disassemble /proc/kcore" as
> root, but I think we've broken that long ago.

Either booting with "debug-alternative" on baremetal or starting a guest
and stopping it with gdb and examining the patched memory is what I've
been using to hack on the alternatives in past years. Guest won't help
you a whole lot with FSRM but you could "force it", for example.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
