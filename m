Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF36169F76
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 08:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgBXHq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 02:46:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:53072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgBXHq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 02:46:57 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F042420675;
        Mon, 24 Feb 2020 07:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582530417;
        bh=x8vWVdrCVtYmpsdSTYu+lTyddkui5cEZft/LbfgJlQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lipfdEm0MWk7qTMKMmxondt7aV1ammLyd8fB/RxWmkr1XyGtJfqwrRvwIQAGwIEKv
         LnAP/074CSmXimzPb6CvuA7a29S2hRnrX88pD1gVZvYfGzpndwAalCpPfWMSOvNjP6
         xc0EDxlse5qaYwzPUn+qoKrIc/cKKJMQ361HFP7o=
Date:   Mon, 24 Feb 2020 15:46:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx: Align ocotp node name
Message-ID: <20200224074648.GZ27688@dragon>
References: <1582253153-22053-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582253153-22053-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 10:45:53AM +0800, Anson Huang wrote:
> Node name should be generic, use "ocotp-ctrl" instead of "ocotp"
> for all i.MX6 SoCs.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
