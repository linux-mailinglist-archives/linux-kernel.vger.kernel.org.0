Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B469075ACB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 00:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfGYWiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 18:38:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47877 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfGYWiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:38:10 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqmN6-0006FH-Aa; Fri, 26 Jul 2019 00:38:00 +0200
Date:   Fri, 26 Jul 2019 00:37:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
cc:     John Hubbard <jhubbard@nvidia.com>, john.hubbard@gmail.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] x86/boot: clear some fields explicitly
In-Reply-To: <e080b061-562f-568f-782d-b014556acdba@zytor.com>
Message-ID: <alpine.DEB.2.21.1907260036500.1791@nanos.tec.linutronix.de>
References: <20190724231528.32381-1-jhubbard@nvidia.com> <20190724231528.32381-2-jhubbard@nvidia.com> <B7DC31CA-E378-445A-A937-1B99490C77B4@zytor.com> <alpine.DEB.2.21.1907250848050.1791@nanos.tec.linutronix.de> <345add60-de4a-73b1-0445-127738c268b4@nvidia.com>
 <alpine.DEB.2.21.1907252343180.1791@nanos.tec.linutronix.de> <3DFA2707-89A6-4DD2-8DFB-0C2D1ABA1B3C@zytor.com> <alpine.DEB.2.21.1907252358240.1791@nanos.tec.linutronix.de> <e080b061-562f-568f-782d-b014556acdba@zytor.com>
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

On Thu, 25 Jul 2019, H. Peter Anvin wrote:
> On 7/25/19 3:03 PM, Thomas Gleixner wrote:
> > On Thu, 25 Jul 2019, hpa@zytor.com wrote:
> >> On July 25, 2019 2:48:30 PM PDT, Thomas Gleixner <tglx@linutronix.de> wrote:
> >>>
> >>> But seriously I think it's not completely insane what they are doing
> >>> and the table based approach is definitely more readable and maintainable
> >>> than the existing stuff.
> >>
> >> Doing this table based does seem like a good idea.
> > 
> > The question is whether we use a 'toclear' table or a 'preserve' table. I'd
> > argue that the 'preserve' approach is saner.
> > 
> I agree.

Now we just need to volunteer someone to do that :)

> >> Sent from my Android device with K-9 Mail. Please excuse my brevity.
> > 
> > I surely excuse the brevity, but the formatting mess which that brevity app
> > creates is not excusable.
> > 
> 
> I'll try to improve it...

SCNR ...
