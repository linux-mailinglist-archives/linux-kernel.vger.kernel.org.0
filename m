Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3870964F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 02:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfGKAEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 20:04:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbfGKAEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 20:04:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E096C04AC69;
        Thu, 11 Jul 2019 00:04:50 +0000 (UTC)
Received: from treble (ovpn-122-237.rdu2.redhat.com [10.10.122.237])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 59E228844B;
        Thu, 11 Jul 2019 00:04:49 +0000 (UTC)
Date:   Wed, 10 Jul 2019 19:04:47 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Craig Topper <craig.topper@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Bill Wendling <morbo@google.com>,
        Stephen Hines <srhines@google.com>
Subject: Re: objtool warnings in prerelease clang-9
Message-ID: <20190711000447.5btnvuzc45zjrcb4@treble>
References: <CAKwvOdnGL_9cJ+ETNce89+z7CTDctjACS8DFsLu=ev4+vkVkUw@mail.gmail.com>
 <alpine.DEB.2.21.1907022332000.1802@nanos.tec.linutronix.de>
 <20190706155001.yrfxqj7c2bmqtbid@treble>
 <20190710232244.to73phlufdetf5os@treble>
 <CAKwvOdmSQUjDUeL-rG5q=EyfhWstHeCVDn+=9spEQmw5BJGaaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmSQUjDUeL-rG5q=EyfhWstHeCVDn+=9spEQmw5BJGaaA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 11 Jul 2019 00:04:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 04:42:43PM -0700, Nick Desaulniers wrote:
>       7e: 0f 85 00 00 00 00            jne 0
> <x86_early_init_platform_quirks+0x84>
> 0000000000000080:  R_X86_64_PC32 __x86_indirect_thunk_r11-4
>       84: c3                            retq
> 
> I've sent you the .o file off thread as well.  Thanks for taking a
> look into this. :D

Ah, right.  I forgot it was a retpoline jump.  I had a patch for that as
well, will test with the .o and post tomorrow-ish.

-- 
Josh
