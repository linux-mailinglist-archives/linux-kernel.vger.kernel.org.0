Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9E9A33474
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 18:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbfFCQDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 12:03:01 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50980 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfFCQDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lLnVi0vjdBv3imxv284zynBchnb9I9Y9jAX/8+xha3s=; b=fuzdJxCv9LO36YHp5x6ASAWoiI
        iNziBbInEc80Fwre75HbrhuS/gu1wtFmLgtvBJv6dPRw1xbOjGQPjNlwnVlJ93IO3ulQZRQ4nYKGa
        AstKb8V/vM+yKwXGbPkLglgbSo1Up5Z8htHHtPV2OcAfO1mwBtfz212uGeFGTFF704fE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hXpQH-0006UX-Ct; Mon, 03 Jun 2019 18:02:57 +0200
Date:   Mon, 3 Jun 2019 18:02:57 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH 41/57] drivers: net: phy: Use
 class_find_device_by_of_node helper
Message-ID: <20190603160257.GL19627@lunn.ch>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-42-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559577023-558-42-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 04:50:07PM +0100, Suzuki K Poulose wrote:
> Use the generic helper to find a device matching the of_node.
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
