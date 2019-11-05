Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEA0F0022
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 15:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389392AbfKEOoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 09:44:34 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:49874 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388976AbfKEOoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=+c1h6MksoHw7Izy6bCwEqip1xk2piM3NtthsfyLl14g=; b=RmwVhv2z+DuJJiuh5Yn6jqqgW+
        XQbdvE/gYPkYrAxjJHAlErO+w0r1idD1Vx6ovyIE3vcJh9Pmu2uPyN/JWNCVhtpBpFMBnKjoNSEH8
        A08dLlhi7m11Kd1wEasUDEm8jCBUU+SWHv1QNFY1OXhWbT+3vkiB20tj0qVK8AO4+tZQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iS04M-0002OO-Pd; Tue, 05 Nov 2019 15:44:30 +0100
Date:   Tue, 5 Nov 2019 15:44:30 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: Re: [PATCH 00/12] staging: dpaa2-ethsw: add support for control
 interface traffic
Message-ID: <20191105144430.GE7189@lunn.ch>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
 <20191105132435.GA2616182@kroah.com>
 <20191105140256.GB7189@lunn.ch>
 <39cf7504-7599-83bb-4b53-5a25ff9240a8@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39cf7504-7599-83bb-4b53-5a25ff9240a8@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Andrew,
> 
> Just to clarify...if the STP handling is removed, then we'll have a 
> receive code path but no frame will reach it.
> This is because, the only way we could direct traffic to the CPU is by 
> adding an ACL rule.

Ah, that is not good.

As i said in one of my reviews, you need to receive all multicast and
broadcast traffic by default. Without that, ARP will not work.  Does
the switch perform learning on frames sent from the CPU? Does the
switch learn the CPUs MAC address and forward frames to it?  Can i add
an IP address to the interface and use ping?

   Andrew
