Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A12CCDB3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 03:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfJFBWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 21:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbfJFBWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 21:22:09 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84B3A222C8;
        Sun,  6 Oct 2019 01:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570324929;
        bh=lg1rcaPaYzlWfGFd7qFkTdrWx6pX1IzDsEq3GfuVM7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tKSRDosiWc8MJ8AXoLQ4RxgA03z9u8Yw/Mbw9HgGxtf+SR359QrHrFv5dG332rVLh
         rcNM/S4ZtrviI1Kjak/neKKCbN2JsuXaLNiTIgzaa6N4Mt78oYPERAX1oHpmBvVY9G
         ePT4hYVqeBXGDU6yEJga2m5VXaHZ7DI4UiahDyF8=
Date:   Sun, 6 Oct 2019 09:21:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        daniel.baluta@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] soc: imx: imx-scu: Getting UID from SCU should have
 response
Message-ID: <20191006012149.GI7150@dragon>
References: <1567624394-25023-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567624394-25023-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 03:13:14PM -0400, Anson Huang wrote:
> The SCU firmware API for getting UID should have response,
> otherwise, the message stored in function stack could be
> released and then the response data received from SCU will be
> stored into that released stack and cause kernel NULL pointer
> dump.
> 
> Fixes: 73feb4d0f8f1 ("soc: imx-scu: Add SoC UID(unique identifier) support")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
