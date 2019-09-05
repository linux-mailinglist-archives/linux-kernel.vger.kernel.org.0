Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6357A9B9C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 09:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbfIEHUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 03:20:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34866 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730778AbfIEHUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:20:41 -0400
Received: from zn.tnic (p200300EC2F0A5F0094A48B587AEA6833.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5f00:94a4:8b58:7aea:6833])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 74A871EC094F;
        Thu,  5 Sep 2019 09:20:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567668035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WXSfc1DPCp4yNJhQctq/zR1e9GiDWEuck/Pkpr20QWY=;
        b=WVBg7mI7s85VkAK5H3x3kMth8i5YLOu4mJksNuoKeoakXKUMsK4MrB7Meid66xisy6rUBO
        S7rDafM8ZcXVbxrlWGh+1WRptR0hOfWbh3LBb5zMgQmj6PCWHW7rDkbxSI5g9QyBz1WZBL
        IwRcG1OWyB5L7zcOE0PuwfIHYQNJjlc=
Date:   Thu, 5 Sep 2019 09:20:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even if
 revision is unchanged
Message-ID: <20190905072029.GB19246@zn.tnic>
References: <1567056803-6640-1-git-send-email-ashok.raj@intel.com>
 <20190829060942.GA1312@zn.tnic>
 <20190829130213.GA23510@araj-mobl1.jf.intel.com>
 <20190903164630.GF11641@zn.tnic>
 <41cee473-321c-2758-032a-ccf0f01359dc@oracle.com>
 <D8A3D2BD-1FD4-4183-8663-3EF02A6099F3@alien8.de>
 <20190905002132.GA26568@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190905002132.GA26568@otc-nc-03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 05:21:32PM -0700, Raj, Ashok wrote:
> But echo 2 > reload would allow reading a microcode file from 
> /lib/firmware/intel-ucode/ even if the revision hasn't changed right?
> 
> #echo 1 > reload wouldn't load if the revision on disk is same as what's loaded,
> and we want to permit that with the echo 2 option.

Then before we continue with this, please specify what the exact
requirements are. Talk to your microcoders or whoever is going to use
this and give the exact use cases which should be supported and describe
them in detail.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
