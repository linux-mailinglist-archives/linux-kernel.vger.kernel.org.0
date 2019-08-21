Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0814397F44
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 17:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfHUPpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 11:45:01 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49132 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbfHUPpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=d2ipJgskj1KEFwtR3VC5y7DGS2nKxHaE3OCt1pU7bQs=; b=rDR4iBM6F7m5OGmABrNkpFJyBo
        ItjdBWifYVfJw+pPyL5pd+WkwAK2B9yDLmVb5JNyapKyvXN/KCc9Tr+LcZq3k0rk/L0Va8hx+xKlz
        4HG7FjZDKOVGNRriFTRPpZEgxmcT/UYFiwUx/PrhxKPsTyBPHQU+zty8TUmiu1DHuAmw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1i0Sn9-00060h-P0; Wed, 21 Aug 2019 17:44:55 +0200
Date:   Wed, 21 Aug 2019 17:44:55 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH v2] ARM: dts: vf610-zii-cfu1: Slow I2C0 down to 100 kHz
Message-ID: <20190821154455.GD22091@lunn.ch>
References: <20190821013936.12223-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821013936.12223-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 06:39:36PM -0700, Andrey Smirnov wrote:
> Fiber-optic modules attached to the bus are only rated to work at
> 100 kHz, so decrease the bus frequency to accommodate that.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

I took a quick look at some of the SFP standards. 100KHz is part of
the standard. So we should try to remember to keep an eye of this as
other boards are merged.

    Andrew
