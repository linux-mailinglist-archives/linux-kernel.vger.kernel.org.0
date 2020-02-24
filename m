Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D59416A492
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 12:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgBXLFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 06:05:15 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38876 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBXLFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:05:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sHN98KwOYJN+qlU1gS3IfqAfcMQjoxoEW1b1XK4/Ab4=; b=pFXROtpW4Kw2pEqeoBtfAsJFb
        +so3asbo5T812Z5px71FZ2Wwa9TAXgPUhXtGMu8BPzVOKTBMxLS3ewPh/pfTXsPYAHuydcIZxwOdC
        ieQGxSzCm/7G81F0aTMU49A7vEXs3JUvKSM7ZlHakqQDjErOOWbSgp1e7iUgYTo65WbJfpRVpKb50
        BOeypRUBduVR9I3CvI3VV9Bzzd8ROMT/5OVNBQQW6oLseDtoFUNQNBrMhJCX1sht5dKc73u78B2Lo
        qhhhm2OXeHyB0xn/KfI4ZdpPFWdMYV49wQLgQvmkXyQoJwOib5ZRLOTwcEm+SU6ii+MmixJRsxpi0
        XGa8QihZA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56244)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1j6BXx-0002I2-VT; Mon, 24 Feb 2020 11:05:10 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1j6BXw-0006Ms-Ve; Mon, 24 Feb 2020 11:05:09 +0000
Date:   Mon, 24 Feb 2020 11:05:08 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     yifeng wu <y1feng.wu1234@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Subject: [PATCH] arm/kernel/head.S: optimize
 __create_page_tables function
Message-ID: <20200224110508.GP25745@shell.armlinux.org.uk>
References: <CAKy1Xqcnkfm7Dn9UvJ7Ufio-szQ75kbGS+GurBjuUFBydi21GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKy1Xqcnkfm7Dn9UvJ7Ufio-szQ75kbGS+GurBjuUFBydi21GA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 06:38:22PM +0800, yifeng wu wrote:
> I'm sorry that my computer can't configure git send-email, so I'll send you
> the patch as an attachment, and I'll show my changes in the email text,
> expecting a reply -------an engineer who submitted the patch for the first
> time。

Please explain why you wish to optimise this, and how much effect it
has.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
