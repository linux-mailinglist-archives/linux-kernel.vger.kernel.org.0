Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB65352390
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 08:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbfFYGbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 02:31:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40671 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbfFYGbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:31:20 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfeyz-0005m1-Oq; Tue, 25 Jun 2019 08:31:09 +0200
Date:   Tue, 25 Jun 2019 08:31:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
cc:     Joe Perches <joe@perches.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        David Wang <DavidWang@zhaoxin.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>
Subject: =?GB2312?Q?Re=3A_=B4=F0=B8=B4=3A_=5Btip=3Ax86=2Fcpu=5D_x86=2Fcpu=3A?=
 =?GB2312?Q?_Create_Zhaoxin_processors_architecture_support_fi?=
 =?GB2312?Q?le?=
In-Reply-To: <505e342c814e4b29ae2a23a6eaf63ea7@zhaoxin.com>
Message-ID: <alpine.DEB.2.21.1906250826550.32342@nanos.tec.linutronix.de>
References: <01042674b2f741b2aed1f797359bdffb@zhaoxin.com>  <tip-761fdd5e3327db6c646a09bab5ad48cd42680cd2@git.kernel.org> <7ec724a310a710e6415320ff530daba0e1d30505.camel@perches.com> <505e342c814e4b29ae2a23a6eaf63ea7@zhaoxin.com>
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

Tony,

On Tue, 25 Jun 2019, Tony W Wang-oc wrote:
> On Sun, Jun 23, 2019, Joe Perches wrote:
> > > x86/cpu: Create Zhaoxin processors architecture support file
> > >
> > []
> > > diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
> > []
> > > +static void init_zhaoxin_cap(struct cpuinfo_x86 *c)
> > > +{
> > > +	u32  lo, hi;
> > > +
> > > +	/* Test for Extended Feature Flags presence */
> > > +	if (cpuid_eax(0xC0000000) >= 0xC0000001) {
> > > +		u32 tmp = cpuid_edx(0xC0000001);
> > > +
> > > +		/* Enable ACE unit, if present and disabled */
> > > +		if ((tmp & (ACE_PRESENT | ACE_ENABLED)) == ACE_PRESENT) {
> > 
> > trivia:
> > 
> > Perhaps this is more intelligible for humans to read
> > and it deduplicates the comment as:
> > 
> > 		if ((tmp & ACE_PRESENT) && !(tmp & ACE_ENABLED))
> > 
> > The compiler produces the same object code.
> > 
> 
> Thanks for the trivia, I will change this in the next version patch set.

as you might have noticed from the tip bot commit notification mail, your
patch set has been merged into the tip tree and is queued for the 5.3 merge
window. So a new patch set is pointless. If at all then you can send a
delta patch.

Though I have to say, that I prefer the existing check:

> > > +		if ((tmp & (ACE_PRESENT | ACE_ENABLED)) == ACE_PRESENT) {

It's pretty clear, but that's really a matter of personal preference. So
from my side there is nothing to do at all.

Thanks,

	tglx

