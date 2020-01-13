Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4AF9138D63
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 10:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgAMJFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 04:05:19 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53300 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgAMJFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:05:19 -0500
Received: from zn.tnic (p200300EC2F05D300845C97C8540218FC.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:d300:845c:97c8:5402:18fc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB8791EC0CBD;
        Mon, 13 Jan 2020 10:05:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578906317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dKbaCfSlA3zMZXVOUhal7rgsI6faHR3J0+QS6uAvZG8=;
        b=iHyodrnjURcmi71GzArtn72rgcjvUjXpWX9f6ImlJyI/v0HOpoKpyqLGOy2KcFDL71+AxE
        p56+jVTXYz8LjKpndchdbjkyzTJVsrD+cGnh2Eh72F5KcQ3LNyWjSCnrfiWA86qrjV6xKI
        ZUCIY5t4ejxDMe5uPAU/ZY1E0bOdnls=
Date:   Mon, 13 Jan 2020 10:05:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Chuansheng Liu <chuansheng.liu@intel.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com
Subject: Re: [PATCH v2] x86/mce/therm_throt: Fix the access of uninitialized
 therm_work
Message-ID: <20200113090509.GC13310@zn.tnic>
References: <20200107004116.59353-1-chuansheng.liu@intel.com>
 <20200110182929.GA20511@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200110182929.GA20511@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 10:29:29AM -0800, Luck, Tony wrote:
> On Tue, Jan 07, 2020 at 12:41:16AM +0000, Chuansheng Liu wrote:
> > In my ICL platform, it can be reproduced in several times
> > of reboot stress. With this fix, the system keeps alive
> > for more than 200 times of reboot stress.
> > 
> > V2: Boris shares a good suggestion that we can moving the
> > interrupt unmasking at the end of therm_work initialization.
> > 
> > Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> 
> Looks good to me:
> 
> Acked-by: Tony Luck <tony.luck@intel.com>

Thx.

This "ICL platform" - whatever that is - is this shipping already so
that this qualifies for stable@ or can it go the normal path?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
