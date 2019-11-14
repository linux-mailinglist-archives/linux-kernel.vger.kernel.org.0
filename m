Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD3BFC66A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 13:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfKNMj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 07:39:27 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43870 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfKNMj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:39:26 -0500
Received: from zn.tnic (p200300EC2F15E200B4C5AF24BE56B25A.dip0.t-ipconnect.de [IPv6:2003:ec:2f15:e200:b4c5:af24:be56:b25a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D28681EC0B7A;
        Thu, 14 Nov 2019 13:39:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573735165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j4j6rmVxFfDJZKk6jcTn3vOttBjEGTLRErAikwgc27A=;
        b=IuUuIkAPLkD1yQxAnzZ40CcwE9xTT2Ik6BhArfh7AI8oB7QRillk0U/SIBlFgVJTGAVjT8
        uSnNpqbu9nCsvsdptznJ1Jq4iybiZ2BWi9FpOXvLBDjL9pFTIMyjn1pCZ8xLeD8EYMnYB0
        4if61EIrJZg8NL9r26J1nsq7VBFlh/8=
Date:   Thu, 14 Nov 2019 13:39:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, bhe@redhat.com, dyoung@redhat.com,
        jgross@suse.com, dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, d.hatayama@fujitsu.com,
        horms@verge.net.au, kexec@lists.infradead.org
Subject: Re: [PATCH 3/3 v9] kexec: Fix i386 build warnings that missed
 declaration of struct kimage
Message-ID: <20191114123920.GA7222@zn.tnic>
References: <20191108090027.11082-1-lijiang@redhat.com>
 <20191108090027.11082-4-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191108090027.11082-4-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 05:00:27PM +0800, Lianbo Jiang wrote:
> Kbuild test robot reported some build warnings as follow:
> 
> arch/x86/include/asm/crash.h:5:32: warning: 'struct kimage' declared
> inside parameter list will not be visible outside of this definition
> or declaration
>     int crash_load_segments(struct kimage *image);
>                                    ^~~~~~
>     int crash_copy_backup_region(struct kimage *image);
>                                         ^~~~~~
>     int crash_setup_memmap_entries(struct kimage *image,
>                                           ^~~~~~
> The 'struct kimage' is defined in the header file include/linux/kexec.h,
> before using it, need to include its header file or make a declaration.
> Otherwise the above warnings may be triggered.
> 
> Add a declaration of struct kimage to the file arch/x86/include/asm/
> crash.h, that will solve these compile warnings.
> 
> Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system call")

This is, of course, wrong. Your *first* patch is introducing those
warnings and I'm wondering how did you not see them during building?

In file included from arch/x86/realmode/init.c:11:
./arch/x86/include/asm/crash.h:5:32: warning: ‘struct kimage’ declared inside parameter list will not be visible outside of this definition or declaration
    5 | int crash_load_segments(struct kimage *image);
      |                                ^~~~~~
./arch/x86/include/asm/crash.h:6:37: warning: ‘struct kimage’ declared inside parameter list will not be visible outside of this definition or declaration
    6 | int crash_copy_backup_region(struct kimage *image);
      |                                     ^~~~~~
./arch/x86/include/asm/crash.h:7:39: warning: ‘struct kimage’ declared inside parameter list will not be visible outside of this definition or declaration
    7 | int crash_setup_memmap_entries(struct kimage *image,
      |


And that happens because you've included asm/crash.h in
arch/x86/realmode/init.c and it of course complains because it hasn't
seen that struct yet.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
