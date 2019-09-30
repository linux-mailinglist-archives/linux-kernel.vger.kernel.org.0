Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50FFAC21A5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 15:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbfI3NRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 09:17:08 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46250 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726314AbfI3NRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:17:08 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8UDGd9A010000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Sep 2019 09:16:39 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1C89142014C; Mon, 30 Sep 2019 09:16:39 -0400 (EDT)
Date:   Mon, 30 Sep 2019 09:16:39 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: x86/random: Speculation to the rescue
Message-ID: <20190930131639.GF4994@mit.edu>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <CAHk-=wi0vxLmwEBn2Xgu7hZ0U8z2kN4sgCax+57ZJMVo3huDaQ@mail.gmail.com>
 <20190930033706.GD4994@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930033706.GD4994@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 11:37:06PM -0400, Theodore Y. Ts'o wrote:
> I'm OK with this as a starting point.  If a jitter entropy system
> allow us to get pass this logjam, let's do it.  At least for the x86
> architecture, it will be security through obscurity.  And if the
> alternative is potentially failing where the adversary can attack the
> CRNG, it's my preference.  It's certainly better than nothing.

Upon rereading this, this came out wrong.  What I was trying to say is
in the very worst case, it will be security through obscurity, and if
the alternative "don't block, because blocking is always worse than an
guessable value being returned through getrandom(0)", it's better than
nothing.

Which is to say, I'm still worried that people with deep access to the
implementation details of a CPU might be able to reverse engineer what
a jitter entropy scheme produces.  This is why I'd be curious to see
the results when someone tries to attack a jitter scheme on a fully
open, simple architecture such as RISC-V.

						- Ted
