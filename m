Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12330E06A4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 16:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfJVOmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 10:42:22 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44408 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfJVOmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ea447GvPkMEJiK8cNRVkTbBPIJxvbAAmR8a4za/AwAc=; b=JXRGHqiqeDJzmaKxjhTB20Txb
        jWigRJBTqQhDbfBYaZBGdjUhN8efePBdsIzkg6TrcjRfE74PF5veCxNs5E4xeu9UXOZbZAMXCZixn
        AMKsWUJKCq6SUUkXVANwgrWOmNqX/1H8Xb5tECSQ1mI7mNhIbSypyT40zA28RTq5izjO/TIMHSvIu
        A8PjopG7oo/FBnWxGPxKf2FmhVGzDi0Nhvk2sns92wGpZw951JX7M76yvu6OaiAE4uTRoPRcM80aC
        uURP3mKkb9BQftP+xgo1zssNKP2fj3J2Xu4fLBLj9yK3xSg6r5nt+DPGj0RoXOj0j/PA/O/K2VSKK
        UAtRcHYrQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:53540)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iMvMS-0007pF-IO; Tue, 22 Oct 2019 15:42:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iMvMN-0004ev-Ad; Tue, 22 Oct 2019 15:42:07 +0100
Date:   Tue, 22 Oct 2019 15:42:07 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Brian Starkey <Brian.Starkey@arm.com>, nd <nd@arm.com>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Sean Paul <sean@poorly.run>
Subject: Re: [RFC,3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Message-ID: <20191022144207.GV25745@shell.armlinux.org.uk>
References: <5390495.Gzyn2rW8Nj@e123338-lin>
 <20191016162206.u2yo37rtqwou4oep@DESKTOP-E1NTVVP.localdomain>
 <20191017030752.GA3109@jamwan02-TSP300>
 <20191017082043.bpiuvfr3r4jngxtu@DESKTOP-E1NTVVP.localdomain>
 <20191017102055.GA8308@jamwan02-TSP300>
 <20191017104812.6qpuzoh5bx5i2y3m@DESKTOP-E1NTVVP.localdomain>
 <20191017114137.GC25745@shell.armlinux.org.uk>
 <20191022084210.GX11828@phenom.ffwll.local>
 <20191022084826.GP25745@shell.armlinux.org.uk>
 <CAKMK7uHZ1Lw03LhZVH=oAa92WxZXucqooH1w6SG8HG20+g0Rbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uHZ1Lw03LhZVH=oAa92WxZXucqooH1w6SG8HG20+g0Rbg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 10:50:42AM +0200, Daniel Vetter wrote:
> On Tue, Oct 22, 2019 at 10:48 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> > I had a patches, which is why I raised the problem with the core:
> >
> > 6961edfee26d bridge hacks using device links
> >
> > but it never went further than an experiment at the time because of the
> > problems in the core.  As it was a hack, it never got posted.  Seems
> > that kernel tree (for the cubox) is still 5.2 based, so has a lot of
> > patches and might need updating to a more recent base before anything
> > can be tested.
> 
> 
> For reference, the panel patch:
> 
> https://patchwork.kernel.org/patch/10364873/
> 
> And the huge discussion around bridges, that resulted in Rafael
> Wyzocki fixing all the core issues:
> 
> https://www.spinics.net/lists/dri-devel/msg201927.html
> 
> James, do you want to look into this for bridges?

I can now confirm that it does work.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
