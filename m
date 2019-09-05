Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41E18AADC2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 23:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389557AbfIEVWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 17:22:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44703 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389217AbfIEVWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 17:22:47 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i5zD6-0002FM-OG; Thu, 05 Sep 2019 23:22:32 +0200
Date:   Thu, 5 Sep 2019 23:22:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Raj, Ashok" <ashok.raj@intel.com>
cc:     Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even
 if revision is unchanged
In-Reply-To: <20190905194044.GA3663@otc-nc-03>
Message-ID: <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de>
References: <1567056803-6640-1-git-send-email-ashok.raj@intel.com> <20190829060942.GA1312@zn.tnic> <20190829130213.GA23510@araj-mobl1.jf.intel.com> <20190903164630.GF11641@zn.tnic> <41cee473-321c-2758-032a-ccf0f01359dc@oracle.com> <D8A3D2BD-1FD4-4183-8663-3EF02A6099F3@alien8.de>
 <20190905002132.GA26568@otc-nc-03> <20190905072029.GB19246@zn.tnic> <20190905194044.GA3663@otc-nc-03>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raj,

On Thu, 5 Sep 2019, Raj, Ashok wrote:
> On Thu, Sep 05, 2019 at 09:20:29AM +0200, Borislav Petkov wrote:
> > On Wed, Sep 04, 2019 at 05:21:32PM -0700, Raj, Ashok wrote:
> > > But echo 2 > reload would allow reading a microcode file from 
> > > /lib/firmware/intel-ucode/ even if the revision hasn't changed right?
> > > 
> > > #echo 1 > reload wouldn't load if the revision on disk is same as what's loaded,
> > > and we want to permit that with the echo 2 option.
> > 
> > Then before we continue with this, please specify what the exact
> > requirements are. Talk to your microcoders or whoever is going to use
> > this and give the exact use cases which should be supported and describe
> > them in detail.
> 
> https://lore.kernel.org/lkml/1567056803-6640-1-git-send-email-ashok.raj@intel.com/
> 
> The original description said to load a new microcode file, the content
> could have changed, but revision in the header hasn't increased. 
> 
> The other rules are same, i.e we can't go backwards. There is another
> SVN (Security version number) embedded in the microcode which won't allow
> going backwards anyway. 
> 
> I'll get back to you if there are additional uses, but allowing the facility to 
> actually read the file achieves the same purpose as using the in-kernel copy.
> 
> I have used it multiple times during development :-)

That's all nice, but what it the general use case for this outside of Intel's
microcode development and testing?

We all know that late microcode loading has severe limitations and we
really don't want to proliferate that further if not absolutely required
for something which needs this in a place which cannot deal with out of
tree patches or have some special kernel package for that purpose
installed. Intel's microcode devel/testing does not qualify obviously.

Thanks,

	tglx
