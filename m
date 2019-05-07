Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0A9169B5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 19:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfEGR7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 13:59:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:60402 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726545AbfEGR7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:59:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB2C1ABF3;
        Tue,  7 May 2019 17:59:19 +0000 (UTC)
Date:   Tue, 7 May 2019 19:59:13 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rik van Riel <riel@surriel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86 FPU changes for 5.2
Message-ID: <20190507175913.GC26655@zn.tnic>
References: <20190507132632.GB26655@zn.tnic>
 <CAHk-=wh4Cjb1qDj_VRW9W4d4n9WLksgMKF-roG8eCk_O0ZaEEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wh4Cjb1qDj_VRW9W4d4n9WLksgMKF-roG8eCk_O0ZaEEg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 10:35:25AM -0700, Linus Torvalds wrote:
> I love this and we should have done it long ago, but I also worry that
> every time we've messed with the FP state, we've had interesting bugs.

Tell me about it. Our FPU code is one helluva contraption.

> Which is obviously why we didn't do this long ago.
> 
> Has this gone through lots of testing, particularly with things like
> FP signal handling and old machines that don't necessarily have
> anything but the most basic FP state (ie Pentium class etc)?

Right, so I ran it on the bunch of boxes I have here, the oldest is a K8
which has:

[    0.000000] x86/fpu: x87 FPU will use FXSAVE

and it looked ok. Ingo ran it on his fleet too, AFAIR.

Lemme see if I can dig out something older at work.

> I've pulled it, but I'd still like to feel safer about it after-the-fact ;)

Yeah.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Mary Higgins, Sri Rasiah, HRB 21284 (AG Nürnberg)
