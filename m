Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86C2215FBCF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgBOA5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:57:25 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38664 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725924AbgBOA5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:57:25 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-101.corp.google.com [104.133.0.101] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01F0raQM013843
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Feb 2020 19:53:37 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1C4F942032C; Fri, 14 Feb 2020 19:53:36 -0500 (EST)
Date:   Fri, 14 Feb 2020 19:53:36 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     Rob Herring <robh@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 2/3] random: rng-seed source is utf-8
Message-ID: <20200215005336.GD439135@mit.edu>
References: <158166060044.9887.549561499483343724.stgit@devnote2>
 <158166062748.9887.15284887096084339722.stgit@devnote2>
 <CAL_Jsq+BDfWgGTVtppD-JEFHZRqpc00WaV2N7c6qsPBSaxOEPw@mail.gmail.com>
 <20200214224744.GC439135@mit.edu>
 <f15511bf-b840-0633-3354-506b7b0607fe@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f15511bf-b840-0633-3354-506b7b0607fe@android.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 02:55:36PM -0800, Mark Salyzyn wrote:
> > This is why I really think what gets specified via the boot command
> > line, or bootconfig, should specify the bits of entropy and the
> > entropy seed *separately*, so it can be specified explicitly, instead
> > of assuming that *everyone knows* that rng-seed is either (a) a binary
> > string, or (b) utf-8, or (c) a hex string.  The fact is, everyone does
> > *not* know, or everyone will have a different implementation, which
> > everyone will say is *obviously* the only way to go....
> > 
> Given that the valid option are between 4 (hex), 6 (utf-8) or 8 (binary), we
> can either split the difference and accept 6; or take a pass at the values
> and determine which of the set they belong to [0-9a-fA-F], [!-~] or
> [\000-\377]  nor need to separately specify.

So let's split this up into separate issues.  First of all, from an
architectural issue, I really think we need to change
add_bootloader_randomness() in drivers/char/random.c so it looks like this:

void add_bootloader_randomness(const void *buf, unsigned int size, unsigned int entropy_bits)

That's because this is a general function that could be used by any
number of bootloaders.  For example, for the UEFI bootloader, it can
use the UEFI call that will return binary bits.  Some other bootloader
might use utf-8, etc.  So it would be an abstraction violation to have
code in drivers/char/random.c make assumption about how a particular
bootloader might be behaving.

The second question is we are going to be parsing an rng_seed
parameter it shows up in bootconfig or in the boot command line, how
do we decide how many bits of entropy it actually has.  The advantage
of using the boot command line is we don't need to change the rest of
the bootloader ecosystem.  But that's also a massive weakness, since
apparently some people are already using it, and perhaps not in the
same way.

So what I'd really prefer is if we use something new, and we define it
in a way that makes as close as possible to "impossible to misuse".
(See Rusty Russell's API design manifesto[1]).  So I'm going to
propose something different.  Let's use something new, say
entropy_seed_hex, and let's say that it *must* be a hex string:

    entropy_seed_hex=7337db91a4824e3480ba6d2dfaa60bec

If it is not a valid hex string, it gets zero entropy credit.

I don't think we really need to worry about efficient encoding of the
seed, since 256 bits is only 64 characters using a hex string.  And
whether it's 32 characters or 64 characters, the max command line
string is 32k, so it's probably not worth it to try to do something
more complex.  (And only 128 bits is needed to declare the CRNG to be
fully initialized, in which case we're talking about 16 characters
versus 32 charaters.)

[1] http://sweng.the-davies.net/Home/rustys-api-design-manifesto

						- Ted

