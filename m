Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6394515D415
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 09:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgBNIui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 03:50:38 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33626 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728513AbgBNIui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:50:38 -0500
Received: from zn.tnic (p200300EC2F0D5A00F0C2F03C7F1C4548.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:5a00:f0c2:f03c:7f1c:4548])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 681121EC0570;
        Fri, 14 Feb 2020 09:50:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581670236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Cw6+gnPc4moLaGRpH11KP99cIfDT9rQkYxx76BSwdbU=;
        b=eN0hJutAAamaG8xJGUMcjsb67zUbxNKLDuqGTL8kuZkhbaqqYHUTVmYW36R0G3XVmyYK9o
        SmohK73FiIUmZotuCKO/YPmOotxsiYD+LB7pWNZjvZ+Aj86VmhBAP+r5cic/sukGHXg8qG
        1qO2pok7P73seKbvbo2eeLZVd/8D+94=
Date:   Fri, 14 Feb 2020 09:50:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] x86/mce: Add new "handled" field to "struct mce"
Message-ID: <20200214085028.GC13395@zn.tnic>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200212204652.1489-4-tony.luck@intel.com>
 <20200213165617.GL31799@zn.tnic>
 <20200213220953.GA21107@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200213220953.GA21107@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:09:53PM -0800, Luck, Tony wrote:
> 1) It is useful to user mode. The mcelog(8) daemon (or other consumer
>    of "struct mce") gets a record of where to look for logs from this
>    record.  This could reduce the anxiety about logging the same item
>    multiple times.  Its a bit weird though because each entity logging
>    only sees who came before them, not who came after.

Err, doesn't mcelog get the error shoved down through /dev/mcelog? IOW,
why would it even have to look?

Ditto for other consumers which read the tracepoint...

> 2) Not useful
> 	2a) Keep it in the structure, but clear it in copies shown to user

Yah, also ok.

> 	2b) Make a *private to point to such things (but that really
> 	    complicates allocation of struct mce ... right now we just
> 	    have local copies on kernel stack)

Yeah..

> 	2c) Make a wrapper structure:
> 		struct kernel_mce {
> 			struct mce mce;
> 			u32 handled;
> 			... other hidden stuff ...
> 		};

That too.

2a) sounds really simple to me and I like simple. And if we ever end up
needing more fields, we'll just add another one and keep clearing it on
copy to user.

And just to make our lives easier, we can do

	u64 kflags;

and put the handled stuff there but still have a 64-bit value for future
flags.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
