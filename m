Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77F15E6B83
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 04:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbfJ1Dsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 23:48:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729328AbfJ1Dsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 23:48:40 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E804D20659;
        Mon, 28 Oct 2019 03:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572234520;
        bh=+v2nHJWW8uJ0j5XhT13GaUAs7RJX1oty9dbstfaFroY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DWNEMqZgdJ6nfhjBNdTsSyu/VD4Zw1lpdgN/lHi9MvTZda6XGDqU5UId2BpVK3Isk
         CvwL8Q3MILQKgln5TSP3fl1FImUIBAuTb+JSdf6pazOxZTWNEaJBteFaNbEjCEfju7
         /+hqwlgtO+ckln+BoXYEYMrmX/gRC9vuCKMAvqq0=
Date:   Mon, 28 Oct 2019 11:48:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        aisheng.dong@nxp.com, sebastien.szymanski@armadeus.com,
        leoyang.li@nxp.com, pramod.kumar_1@nxp.com, l.stach@pengutronix.de,
        ping.bai@nxp.com, bhaskar.upadhaya@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/3] arm64: dts: imx8mn: Create EVK dtsi file for common
 use
Message-ID: <20191028034819.GJ16985@dragon>
References: <1571281984-7125-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571281984-7125-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 11:13:02AM +0800, Anson Huang wrote:
> i.MX8MN has different EVK boards to support different DDR types,
> the ONLY differences are DDR chips and PMIC, so most of the devices
> can be shared between these EVK boards, create a EVK dtsi file for
> common use.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied all, thanks.
