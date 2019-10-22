Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2F2E0C16
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 20:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732817AbfJVS7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 14:59:13 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:34805 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731740AbfJVS7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 14:59:13 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 325EB3C057C;
        Tue, 22 Oct 2019 20:59:11 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PeenTeeOB236; Tue, 22 Oct 2019 20:59:05 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id EF1133C009D;
        Tue, 22 Oct 2019 20:59:05 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 22 Oct
 2019 20:59:05 +0200
Date:   Tue, 22 Oct 2019 20:59:02 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        <kuninori.morimoto.gx@renesas.com>, <patch@alsa-project.org>,
        <twischer@de.adit-jv.com>, <perex@perex.cz>, <tiwai@suse.com>,
        Jiada Wang <jiada_wang@mentor.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rsnd: dma: fix SSI9 4/5/6/7 busif dma
 address
Message-ID: <20191022185902.GA12906@vmlxhi-102.adit-jv.com>
References: <1550823803-32446-1-git-send-email-twischer@de.adit-jv.com>
 <20191022154904.GA17721@vmlxhi-102.adit-jv.com>
 <20191022163501.GK5554@sirena.co.uk>
 <20191022164607.GA20665@vmlxhi-102.adit-jv.com>
 <20191022165337.GX5554@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191022165337.GX5554@sirena.co.uk>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 05:53:37PM +0100, Mark Brown wrote:
> On Tue, Oct 22, 2019 at 06:46:07PM +0200, Eugeniu Rosca wrote:
> > On Tue, Oct 22, 2019 at 05:35:01PM +0100, Mark Brown wrote:
> > > On Tue, Oct 22, 2019 at 05:49:04PM +0200, Eugeniu Rosca wrote:
> 
> > > > It still applies cleanly to v5.4-rc4-18-g3b7c59a1950c.
> > > > Any chance to see it in vanilla?
> 
> > > Someone would need to resend it.  No idea what the issues are but I
> > > don't have it any more.
> 
> > How about downloading it from [1] by pressing on the "mbox" button and
> > applying it with "git am"? This will also include any
> > "*-by: Name <E-mail>" signatures found in the thread.
> 
> > If this doesn't match your workflow, I can resend it.
> 
> This doesn't match either my workflow or the kernel's workflow in
> general, please resend - that means that not only I but also other
> people on the list have the chance to see the patch and review it.

Resent as https://patchwork.kernel.org/patch/11205195/
("[RESEND] ASoC: rsnd: dma: fix SSI9 4/5/6/7 busif dma address")

-- 
Best Regards,
Eugeniu
