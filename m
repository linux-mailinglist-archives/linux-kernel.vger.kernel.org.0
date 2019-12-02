Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09E9F10E6FE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 09:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfLBImg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 03:42:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLBImg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:42:36 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3750E214AF;
        Mon,  2 Dec 2019 08:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575276156;
        bh=DYAeZZ04KqOYDj2hpLpx0whSWeAoAiJAXf5alkSRa3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M+cAgfFv34adtKvNXUVVHJ1GIECoTLnJymcPiVC7Cg/JF0VncEy4XbAo4RLFos7KW
         pgXzuAO1MmtJK8G9/0cb6b8gP5GN2dY+M2crpKD6pbGZpv1LxHUTh1u57ZJv3A2ezV
         hINeo0i+sQe0zVS9+E5IFN/rc17C1WsY6+t1LKqQ=
Date:   Mon, 2 Dec 2019 16:42:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux@armlinux.org.uk, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: imx: Add i.MX7ULP SoC serial number support
Message-ID: <20191202084222.GF9767@dragon>
References: <1572852931-24101-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572852931-24101-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 03:35:31PM +0800, Anson Huang wrote:
> i.MX7ULP's unique ID layout in OCOTP is different from other
> i.MX6/7 SoCs as below:
> 
> OCOTP layout		unique ID
> 
> 0x4b0 bit[15:0]		bit[15:0]
> 0x4c0 bit[15:0]		bit[31:16]
> 0x4d0 bit[15:0]		bit[47:32]
> 0x4e0 bit[15:0]		bit[63:48]
> 
> Add support for reading serial number from OCOTP on i.MX7ULP.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
