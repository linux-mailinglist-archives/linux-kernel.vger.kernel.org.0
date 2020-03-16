Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4E0E186153
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 02:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgCPBdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 21:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbgCPBdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 21:33:18 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FA1620663;
        Mon, 16 Mar 2020 01:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584322398;
        bh=P3cq495tgq4ifTa5c3/W4DsSgs2FTFImzz2EA50xynQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbDdyxp8Vw+fAjuRuSXRETN9asPjzSbPamvOhRaCdYDkv1uNJNavCulyvyzGxhxrX
         2FoA7v3UucbIVQuqCgYBDFA2kWKnC3S242PGHi9nFiRgUDeeaMNVEzik8xl1GhGmd2
         m4jN0TNrzroKXpf/A3auRmq0hP4aPYXsC/hj3GQ0=
Date:   Mon, 16 Mar 2020 09:33:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/15] Enable drivers for NXP/FSL QorIQ arm64 boards
Message-ID: <20200316013312.GQ17221@dragon>
References: <20200311225317.11198-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311225317.11198-1-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 05:53:02PM -0500, Li Yang wrote:
> The series enables necessary drivers for the QorIQ reference boards
> supported in mainline.
> 
> Li Yang (15):
>   arm64: defconfig: run through savedefconfig for ordering
>   arm64: defconfig: Enable NXP flexcan driver
>   arm64: defconfig: Enable QorIQ DPAA1 drivers
>   arm64: defconfig: Enable QorIQ DPAA2 drivers
>   arm64: defconfig: Enable ENETC Ethernet controller and FELIX switch
>   arm64: defconfig: Enable NXP/FSL SPI controller drivers
>   arm64: defconfig: Enable QorIQ cpufreq driver
>   arm64: defconfig: Enable ARM SBSA watchdog driver
>   arm64: defconfig: Enable QorIQ IFC NAND controller driver
>   arm64: defconfig: Enable QorIQ GPIO driver
>   arm64: defconfig: Enable ARM Mali display driver
>   arm64: defconfig: Enable flash device drivers for QorIQ boards
>   arm64: defconfig: Enable RTC devices for QorIQ boards
>   arm64: defconfig: Enable PHY devices used on QorIQ boards
>   arm64: defconfig: Enable e1000 device

Applied all, thanks.
