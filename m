Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 015578BCD9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 17:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfHMPQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 11:16:24 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:59963 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729580AbfHMPQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:16:20 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C1231382;
        Tue, 13 Aug 2019 11:16:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 13 Aug 2019 11:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=LoPtfOvpID0cBh959hJGYZTagbN
        C7q7HI3D4nCn4Ro8=; b=DTo3Wr/7MFn4YQfsvCVvrMONul5Ctrvh6pDHiiWr1UW
        V1qYogfpfgk3OXesy7G8XeToLcLAaKduPxIHQVfgMToQ/ACy2p5dIOx2TUKcnOdg
        t4quq+JqMRZ6lz6WtHPt3n8aWckoGwY4HA/6wZAm9v9YfAbFWUnCPW6tlwDd2kBF
        Dm2UlANDsZyF/URtAO0t5xJKcoR86s6FA1Ls5rwWoI0e+MUl8ivXBlvpNTqz+ozg
        uvDJyF4gDbBuy+yheFH4dGE8BkVok289UYfIsFqHwp+NzPFiGCaFgua97xpyEpqj
        XrMdObcOdT5dAfFFxA+NI6tlgaNy0bIQxAI+vnASGcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=LoPtfO
        vpID0cBh959hJGYZTagbNC7q7HI3D4nCn4Ro8=; b=ftryb2waOqajbNoCsu+n3L
        RyOCIGlrFelT6yuI9kfhlgCGUQR1yh6RY0G6p09w0SWhrr7ow9SfELfyypBbHeom
        MwHbadK+2fiNtfnVnukmJUX13j2eWdB2A13YBB2ARaGnNpNvqyC7vXyS+c5WWpgC
        s23Rweox42Ni5QkEIqm7MNjrc7HPr7jFOSdaEj0V86Rz5FW/mivJmo3Wn5XFsjW9
        uHgXa9cgekr4h6hFkJzvo//rPXDaM0ROwvwU3BAntnCUWbwDP4ynw76YOYuLEmWE
        sz/3gQesXC1AAO6vEAjAUBjmFIt1H+zB7bE6Lr/R5MqPopQeCfUT6OKtJWOqzeuw
        ==
X-ME-Sender: <xms:QdRSXSFEMxTt4fxUavu-gOsjUV8_na4XWfhd80pCdOjH66PtMYnWZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddviedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlh
    drohhrghenucfkphepkeefrdekiedrkeelrddutdejnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehgrhgvgheskhhrohgrhhdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:QdRSXcixJmUyHALdpS7NOXwMBePZdJNi7bQQ0SVwcnsdKFclNS3iug>
    <xmx:QdRSXWRDQSd_hBbyWbyHJ83C2yL7wkBLDC52Bay6ibHstQBsfYVn7A>
    <xmx:QdRSXc_cqG4tddw3tMtT4HaIBMuKGHUxpjtgWSxUaejRt3dSmPbYYw>
    <xmx:QtRSXQ3F13B5Cy8FEpwRp4oZD92CrKT7IZ9aqdYZAcEVmw_yRj4RVg>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0521980059;
        Tue, 13 Aug 2019 11:16:16 -0400 (EDT)
Date:   Tue, 13 Aug 2019 17:16:15 +0200
From:   Greg KH <greg@kroah.com>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
Message-ID: <20190813151615.GA25094@kroah.com>
References: <CAAeHK+yPJR2kZ5Mkry+bGFVuedF9F76=5GdKkF1eLkr9FWyvqA@mail.gmail.com>
 <Pine.LNX.4.44L0.1908080958380.1652-100000@iolanthe.rowland.org>
 <CAAeHK+xVKZ-pnGcijYJPpWQ_haWbuVSpD81TJhtRosOZsg-Rwg@mail.gmail.com>
 <1565702535.7043.9.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565702535.7043.9.camel@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 03:22:15PM +0200, Oliver Neukum wrote:
> Am Dienstag, den 13.08.2019, 14:42 +0200 schrieb Andrey Konovalov:
> > > 
> 
> 
> [..]
> 
> > On Thu, Aug 8, 2019 at 4:00 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > Ah, that looks right, thank you.  The patch worked correctly -- good
> > > work Oliver!
> > 
> > Great! Just a reminder to submit the fix :)
> 
> I did last week:
> https://patchwork.kernel.org/patch/11084261/

Give me a chance to catch up :)
