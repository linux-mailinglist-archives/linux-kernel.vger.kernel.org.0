Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64A6F14D005
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 19:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgA2SA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 13:00:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46168 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726171AbgA2SAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 13:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580320824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dou/fbuzKGR7jcBj/3ZEbLPg5ko9v9+/o69GRY+vmSg=;
        b=BjrjbIA05jeGWHDfS6PIb2W0vQHBWVhPfFIhTJkyaWrfw6q8zAxJK+VAmMtIzPq16rv7KP
        Fa03JdwZtlOJ7X4RMyEctxtaruQOZmRydbNZWTgUanu3xlg6xuS8qmb220D21FP3U582CL
        R8mN9swVZEkrFDVy4bsJiQL2A+1LRCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-fHfgGT1jN0y6NT5KeM91QA-1; Wed, 29 Jan 2020 13:00:18 -0500
X-MC-Unique: fHfgGT1jN0y6NT5KeM91QA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9719D477;
        Wed, 29 Jan 2020 18:00:16 +0000 (UTC)
Received: from treble (ovpn-120-83.rdu2.redhat.com [10.10.120.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CBB195DA7B;
        Wed, 29 Jan 2020 18:00:14 +0000 (UTC)
Date:   Wed, 29 Jan 2020 12:00:12 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/asm changes for v5.6
Message-ID: <20200129180012.jmncqyb7x77gkzwq@treble>
References: <20200128165906.GA67781@gmail.com>
 <CAHk-=wgm+2ac4nnprPST6CnehHXScth=A7-ayrNyhydNC+xG-g@mail.gmail.com>
 <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7F5517F9@ORSMSX114.amr.corp.intel.com>
 <CAHk-=wipvtDUE=MZ=y7v1Xm7PE0pAaUwS26X1Zx5iL768yK=oQ@mail.gmail.com>
 <20200128223110.GB6787@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200128223110.GB6787@zn.tnic>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 11:31:10PM +0100, Borislav Petkov wrote:
> On Tue, Jan 28, 2020 at 01:04:19PM -0800, Linus Torvalds wrote:
> > On Tue, Jan 28, 2020 at 12:41 PM Luck, Tony <tony.luck@intel.com> wrote:
> > >
> > > Is there still some easy way to get gdb to disassemble from /dev/kmem
> > > to see what we ended up with after all the patching?
> > 
> > Hmm. No, I think it's all gone.
> > 
> > It _used_ to be easy to just do "objdump --disassemble /proc/kcore" as
> > root, but I think we've broken that long ago.
> 
> Either booting with "debug-alternative" on baremetal or starting a guest
> and stopping it with gdb and examining the patched memory is what I've
> been using to hack on the alternatives in past years. Guest won't help
> you a whole lot with FSRM but you could "force it", for example.

FWIW, I can still do 'objdump -d' and gdb on /proc/kcore just fine
(though you have to give gdb addresses because no symbols).

-- 
Josh

