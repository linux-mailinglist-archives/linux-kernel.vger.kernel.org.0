Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 230F2E6C69
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 07:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbfJ1G1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 02:27:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbfJ1G1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 02:27:14 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3CBE20873;
        Mon, 28 Oct 2019 06:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572244034;
        bh=HbkAY+lHAbwVtkObCGbCrSq1LaUQVDeVT+G5E/C+4/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1JhoMeMcY7i7DZSmAbcIw/l2aa0AWSjqrCmnkgyC0CFvlcI8XbD1KWrkUy2CdYQ0j
         9l+L4xHaS3EPeQ6E2ayREo4VgOqUxhYquT1D7ClkzaDLTMt6PwOmSIdML8zqWpkexD
         +awmlK5pXFDkRhf/olUgHNhXzFt7ZQlS+CNq4bi0=
Date:   Mon, 28 Oct 2019 14:26:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Peter Chen <peter.chen@nxp.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: imx: Drop imx_anatop_usb_chrg_detect_disable()
Message-ID: <20191028062654.GP16985@dragon>
References: <20191022041445.23897-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022041445.23897-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 09:14:45PM -0700, Andrey Smirnov wrote:
> With commit b5bbe2235361 ("usb: phy: mxs: Disable external charger
> detect in mxs_phy_hw_init()") in tree all of the necessary charger
> setup is done by the USB PHY driver which covers all of the affected
> i.MX6 SoCs.
> 
> NOTE: imx_anatop_usb_chrg_detect_disable() was also called for i.MX7D,
> but looking at its datasheet it appears to have a different USB PHY IP
> block, so executing i.MX6 charger disable configuration seems
> unnecessary.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Applied, thanks.
