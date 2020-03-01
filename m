Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0900174E09
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 16:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgCAPot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Mar 2020 10:44:49 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:40442 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgCAPot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 10:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IlyHdjJVYeiY6SHvj+K0w+uik9xmnYdyhX7pDileyQA=; b=1nqV04eyIoqa16ayNQlmYccMVX
        P53vQGdhvx3HAy8mDTKpKokOwRTeZolJeTKDv4Zry9y/OyydKcnT6u+YvuvVduBiG+GwRlj/FEqlg
        egYaQVIdCQTq1hx9fxVjgoVivm6qy8svOrbKYGFurPXoBcBVvIQV82C5/Rd04OwoOnjo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1j8Qlf-00082z-TY; Sun, 01 Mar 2020 16:44:35 +0100
Date:   Sun, 1 Mar 2020 16:44:35 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: orion: replace setup_irq() by request_irq()
Message-ID: <20200301154435.GJ6305@lunn.ch>
References: <20200301122330.4296-1-afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301122330.4296-1-afzal.mohd.ma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 05:53:30PM +0530, afzal mohammed wrote:
> request_irq() is preferred over setup_irq(). Invocations of setup_irq()
> occur after memory allocators are ready.
> 
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
> 
> Hence replace setup_irq() by request_irq().
> 
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
