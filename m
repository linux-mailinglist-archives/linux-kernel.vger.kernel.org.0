Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E580FFFB9E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 21:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfKQUng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 15:43:36 -0500
Received: from foss.arm.com ([217.140.110.172]:54056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfKQUnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 15:43:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EE8C31B;
        Sun, 17 Nov 2019 12:43:35 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 152803F6C4;
        Sun, 17 Nov 2019 12:43:33 -0800 (PST)
Subject: Re: [GIT PULL] scheduler fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191116213742.GA7450@gmail.com>
 <ab6f2b5a-57f0-6723-c62f-91a8ce6eddac@arm.com>
 <20191117094549.GB126325@gmail.com>
 <4e4b0828-abba-e27d-53f6-135df06eba1a@arm.com>
 <CAHk-=wiEz7kG8YSbmAAALdP3Vnna_f4+LY4TPM0NQczeh3mviQ@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <dbcc8947-3164-1202-a21e-ebd2a609d997@arm.com>
Date:   Sun, 17 Nov 2019 20:43:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiEz7kG8YSbmAAALdP3Vnna_f4+LY4TPM0NQczeh3mviQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2019 16:29, Linus Torvalds wrote:
> Gcc can - and does - narrow enums to smaller integer types with the
> '-fshort-enums' flag.
> 
> However, in practice nobody uses that, and it can cause interop
> problems. So I think for us, enums are always at least 'int' (they can
> be bigger).
> 
> That said, mixing enums and values that are bigger than the enumerated
> ones is just a bad idea
> 
> It will, for example, cause us to miss compiler warnings (eg switch
> statements with an enum will warn if you don't handle all cases, but
> the 'all cases' is based on the actual enum range, not on the
> _possible_ invalid values).
> 

Oh, yet another gcc flag... 

Thanks for the detailed write-up.

>                      Linus
> 
