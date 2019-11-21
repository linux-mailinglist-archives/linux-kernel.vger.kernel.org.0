Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9BF1050F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 12:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKULBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 06:01:19 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44042 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfKULBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:01:19 -0500
Received: from zn.tnic (p200300EC2F0F07006553A4184595DC73.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:700:6553:a418:4595:dc73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 047551EC0CE5;
        Thu, 21 Nov 2019 12:01:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574334078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=v4quCIZoYAeH9AtgG7hkOkf1XV0d+q0HOg7J8dsmhTs=;
        b=IJGLDRtNKeHjKRK9sDn1zK2Twyin9UrOzeX6HsVWdHm0pI0z6ZqVg/uOQB0LAhrFj8aIpn
        WoazlgciwPpvb7ff48IHuegvdtjS+4VEcNWqg/hD9zEC9JpxDAD9Z1bfubc8I+EVBRgQi/
        D/DRWu/dIG31quJbMwfg7CFNCx1/cnw=
Date:   Thu, 21 Nov 2019 12:01:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     syzbot <syzbot+81e6ff9d4cdb05fd4f5e@syzkaller.appspotmail.com>
Cc:     adobriyan@gmail.com, ak@linux.intel.com, bigeasy@linutronix.de,
        fenghua.yu@intel.com, frederic@kernel.org, hpa@zytor.com,
        keescook@chromium.org, kernelfans@gmail.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, longman@redhat.com, luto@kernel.org,
        mingo@redhat.com, peterz@infradead.org, rafael.j.wysocki@intel.com,
        riel@surriel.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, tim.c.chen@linux.intel.com,
        tonywwang-oc@zhaoxin.com, wang.yi59@zte.com.cn, x86@kernel.org
Subject: Re: general protection fault in tss_update_io_bitmap
Message-ID: <20191121110115.GC6540@zn.tnic>
References: <0000000000004dccce0597d1967b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000004dccce0597d1967b@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 05:55:09PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    5d1131b4 Add linux-next specific files for 20191119
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=177979d2e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b60c562d89e5a8df
> dashboard link: https://syzkaller.appspot.com/bug?extid=81e6ff9d4cdb05fd4f5e
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1549ed8ce00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f91012e00000
> 
> The bug was bisected to:
> 
> commit 111e7b15cf10f6e973ccf537c70c66a5de539060
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Tue Nov 12 20:40:33 2019 +0000
> 
>     x86/ioperm: Extend IOPL config to control ioperm() as well
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10490e86e00000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=12490e86e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=14490e86e00000

Try this:

https://git.kernel.org/tip/e3cb0c7102f04c83bf1a7cb1d052e92749310b46

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
