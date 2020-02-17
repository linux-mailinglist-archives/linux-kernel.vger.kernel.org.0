Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0318160B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 08:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgBQH21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 02:28:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:58282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgBQH21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:28:27 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA7F320702;
        Mon, 17 Feb 2020 07:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581924506;
        bh=cPS7LQHL3jV9vM0N4GPZ8EkMZtcszWpjOmq6/0CNaa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AN8qdv9DhHJQyyGcNkA95/2kh6i0Gvl2FdI42Hdcto5Qy/Eo6udniNB550h8YIKYF
         5QV6idsBFxePUyBV66uEZgnl55cCJ7KbHMb45ZLMbQBMBN5XcxkQdzk4hKTr3ElB87
         FNj/9KKjT5tST2sU/1QbFUgIbe99lSAGE1z4Qw/U=
Date:   Mon, 17 Feb 2020 15:28:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Robert Jones <rjones@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ARM: dts: imx: ventana: add fxos8700 on gateworks
 boards
Message-ID: <20200217072820.GE7973@dragon>
References: <20200214210155.32518-1-rjones@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214210155.32518-1-rjones@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 01:01:55PM -0800, Robert Jones wrote:
> Add fxos8700 iio imu entries for Gateworks ventana SBCs.
> 
> Signed-off-by: Robert Jones <rjones@gateworks.com>

Applied, thanks.
