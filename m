Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0EE23346B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 18:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfFCQA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 12:00:59 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50956 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfFCQA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ANiDzWxa7buoHaf14CNM2i5UQsrPPsZjRQGtlUEZ4gk=; b=ygyUZCOT6ZIirjIQmrZO2CuBNJ
        MYZOBVL4SC+y7Z7PCMwyeJOO4ZUNwwX4e5SflgqtvrPMTZub36/7rVhORqOA7Urql0b62mZ3Ta4P7
        toxB7poqQX+mIj2Gs1t7bY2HIPEnd7qKcFi8KBlaHi9NW5jsFfOdPT66c18x5HLaKlWE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hXpOK-0006Sg-9f; Mon, 03 Jun 2019 18:00:56 +0200
Date:   Mon, 3 Jun 2019 18:00:56 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RFC PATCH 11/57] of: mdio: Use bus_find_device_by_of_node helper
Message-ID: <20190603160056.GK19627@lunn.ch>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-12-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559577023-558-12-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 04:49:37PM +0100, Suzuki K Poulose wrote:
> Switch to using the bus_find_device_by_of_node helper
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
