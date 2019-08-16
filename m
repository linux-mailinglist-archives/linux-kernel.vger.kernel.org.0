Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85EDB90808
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 21:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfHPTCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 15:02:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50884 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfHPTCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 15:02:19 -0400
Received: from zn.tnic (p200300EC2F0A9200200CA3DD4E56A7C9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9200:200c:a3dd:4e56:a7c9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 09BF71EC097D;
        Fri, 16 Aug 2019 21:02:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565982137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Bjb9ujwNm6DqUuFJKsly1caPpod8hyH5EWKGnEND7J4=;
        b=cHrCeXfl89ikeZi2QR12dqZFFuvTsZR++3e7YR+i23vkTaMLRBwsSSB/l9o+/MOPwW5N74
        K4fAEdR5eUnDiE1ceH31CZUxaALoKHuqhjNduMIxehpKdrs1mcMiMB6NPCTAsARPA9rdnz
        S3JnIEcTR00758fdrHzggzRupvzQ5Fc=
Date:   Fri, 16 Aug 2019 21:03:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS, x86/CPU: Tony Luck will maintain
 asm/intel-family.h
Message-ID: <20190816190306.GB21147@zn.tnic>
References: <20190814234030.30817-1-tony.luck@intel.com>
 <20190815075822.GC15313@zn.tnic>
 <20190815172159.GA4935@agluck-desk2.amr.corp.intel.com>
 <20190815175455.GJ15313@zn.tnic>
 <20190815183055.GA6847@agluck-desk2.amr.corp.intel.com>
 <alpine.DEB.2.21.1908152217070.1908@nanos.tec.linutronix.de>
 <20190815224704.GA10025@agluck-desk2.amr.corp.intel.com>
 <20190816064625.GD18980@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F42410E@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F42410E@ORSMSX115.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 04:29:19PM +0000, Luck, Tony wrote:
> >> + * The defined symbol names have the following form:
> >> + *	INTEL_FAM6{OPTFAMILY}_{MICROARCH}{OPTDIFF}
> >
> > I think you want to have the underscores in the template:
> >
> >	INTEL_FAM6_{OPTFAMILY}_{MICROARCH}_{OPTDIFF}
> >
> > but no need to resend if this is the only issue - I'll fix it up when
> > applying.
> 
> I started there, but then had to include a sentence saying to skip the "_"
> if you didn't include either/both of the optional fields.

Ok, I see, that's why you call it "_CORE" - with a prepended underscore
- which should be omitted, for example. Ok, I'll take it and we can
always fix it up if it ain't clear.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
