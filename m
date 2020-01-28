Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90E9414BD4D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 16:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgA1Pwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 10:52:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgA1Pwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 10:52:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51C9C21739;
        Tue, 28 Jan 2020 15:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580226765;
        bh=RRwCxgpLdHkrA1x1Cq1vksuhcqtVADvwrAno3KEpW8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D4zqX/9twXacyeGJunZmmr41v53JOZvXG0C8CuKm1TOkkPn5q4goYdWIusJrk6JoE
         eVpbyyjBJErpsGSbVYJ1E8dG5A37CLUHF1TGV1mHu9upJjkwLuOVwagOKh+P+SrMwG
         BAudZwrf6V2YFadLZFwf+DD/9NUHpd04cUU+cypI=
Date:   Tue, 28 Jan 2020 16:52:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     broonie@kernel.org, robh@kernel.org, arnd@arndb.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        sudeep.holla@arm.com, lkml@metux.net, loic.pallardy@st.com,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, system-dt@lists.openampproject.org,
        stefano.stabellini@xilinx.com
Subject: Re: [PATCH v2 2/7] bus: Introduce firewall controller framework
Message-ID: <20200128155243.GC3438643@kroah.com>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
 <20200128153806.7780-3-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128153806.7780-3-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 04:38:01PM +0100, Benjamin Gaignard wrote:
> The goal of this framework is to offer an interface for the
> hardware blocks controlling bus accesses rights.
> 
> Bus firewall controllers are typically used to control if a
> hardware block can perform read or write operations on bus.

So put this in the bus-specific code that controls the bus that these
devices live on.  Why put it in the driver core when this is only on one
"bus" (i.e. the catch-all-and-a-bag-of-chips platform bus)?

And really, this should just be a totally new bus type, right?  And any
devices on this bus should be changed to be on this new bus, and the
drivers changed to support them, instead of trying to overload the
platform bus with more stuff.

thanks,

greg k-h
