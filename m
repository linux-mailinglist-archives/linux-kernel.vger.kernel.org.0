Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12EE3154AAE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 18:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgBFR7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 12:59:05 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34022 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbgBFR7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 12:59:05 -0500
Received: from zn.tnic (p200300EC2F0B4B00B811E77661B3406F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:4b00:b811:e776:61b3:406f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9659F1EC0C9F;
        Thu,  6 Feb 2020 18:59:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581011943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nViz79a1n7w/lfoDbFkBaxX8o7iOq4KdQvCEJpyKvWU=;
        b=cta3RKduY4mqDM4xFMRY7YhuV0YG4axx8+hLVlbJi6LtMYyneK2V721qTKkl20/ayEE+j5
        pCRvu2mhiCySmw2mFkaUn9Izu5IAMqJe5nIbkzi7C+b9fFPhPWV620fAcBIe5kzUEcXV/r
        Ys/rWCgMY6oQGzXCxJib30vypOsvHyw=
Date:   Thu, 6 Feb 2020 18:58:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config support
Message-ID: <20200206175858.GG9741@zn.tnic>
References: <20200114210316.450821675@goodmis.org>
 <20200114210336.259202220@goodmis.org>
 <20200206115405.GA22608@zn.tnic>
 <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 11:41:00PM +0900, Masami Hiramatsu wrote:
> Oh, you are not the first person asked that :)
> 
> https://lkml.org/lkml/2019/12/9/563
> 
> And yes, I think this is important that will useful for most developers
> and admins. Since the bootconfig already covers kernel and init options,
> this can be a new standard way to pass args to kernel boot.

Aha, so Steve and you believe this will become the next great thing
after sliced bread. Sorry but I remain sceptical. :)

I would've done it differently: have it default 'n' and once it turns
out that the major distros have enabled it and *actually* use it, *then*
simply remove the config option. Like we usually do with functionality.
Not the other way around.

In any case, I've disabled it on my machines and will wait for it
missing to come back and bite me. :-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
