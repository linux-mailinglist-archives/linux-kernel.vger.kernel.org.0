Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C5314CEB9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 17:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgA2Q6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 11:58:50 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:34528 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgA2Q6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:58:48 -0500
Received: from localhost (dhcp-077-249-119-090.chello.nl [77.249.119.90])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7A0AA14F0D680;
        Wed, 29 Jan 2020 08:58:46 -0800 (PST)
Date:   Tue, 28 Jan 2020 11:00:35 +0100 (CET)
Message-Id: <20200128.110035.1287294869237249484.davem@davemloft.net>
To:     scott.branden@broadcom.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net: phy: add default ARCH_BCM_IPROC for
 MDIO_BCM_IPROC
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200128003828.20439-1-scott.branden@broadcom.com>
References: <20200128003828.20439-1-scott.branden@broadcom.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 29 Jan 2020 08:58:48 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Branden <scott.branden@broadcom.com>
Date: Mon, 27 Jan 2020 16:38:28 -0800

> Add default MDIO_BCM_IPROC Kconfig setting such that it is default
> on for IPROC family of devices.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Applied, thanks.
