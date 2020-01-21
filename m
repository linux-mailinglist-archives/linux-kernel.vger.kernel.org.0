Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6895D143FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 15:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbgAUOk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 09:40:27 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:48290 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729427AbgAUOk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=eanzNlQOXiyQv7SY2HxEu4R1QjiEvG/A8Il3e6bRKMk=; b=ZcgPsiCF79tdrPQ/9tIwj0ppNQ
        WhFSPgtG//uXN5jaJouR/qFhNXHIFbuZUm97Gls0sURalRsyDyDMMxxApWK3hv/2a2Qw+EkQxIxQo
        eUeKPlt9kBn0hAMIzrnfDp+Fx+e+tFhUrSakt0R7dEyQynYb6HMvQ+mMxFJKpHehIgpY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1ituhX-0004hj-5C; Tue, 21 Jan 2020 15:40:19 +0100
Date:   Tue, 21 Jan 2020 15:40:19 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: No master_xfer_atomic for i2c-mv64xxx.c
Message-ID: <20200121144019.GD16902@lunn.ch>
References: <da0061d1-917f-d807-a7ac-05d302d88565@gmail.com>
 <20200121094023.jywheey6sjsgrr44@gilmour.lan>
 <CAGb2v65Kz0ymDapbyJ_WTebEGOs5=wkqMXUZV-mQJhdKr8ZGhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v65Kz0ymDapbyJ_WTebEGOs5=wkqMXUZV-mQJhdKr8ZGhA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > However, I'm not entirely sure how we could implement it without
> > sleeping. The controller is basically a state machine that triggers an
> > interrupt on each state change, so you first set the address, get an
> > interrupt, then set the direction, then you get an interrupt, etc.
> >
> > I guess we could implement it using polling, but I'm not sure if
> > that's wise in an interrupt context either.
> 
> I believe that is actually how some of the other drivers handle it,
> using polling. You can mask or disable the interrupts while in the
> xfer_atomic callback, and the i2c core won't schedule two transfers
> at the same time anyway.

The ocore driver is similar to the Marvell driver, a big state
machine. It implements polling for atomic transfers. It needs polling
support anyway, because some instantiations of the hardware have
broken interrupts :-(

Maybe there is some code which can be copied from the ocore driver?

      Andrew
