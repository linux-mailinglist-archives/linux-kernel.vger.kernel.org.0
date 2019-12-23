Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E685712925A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 08:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfLWHn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 02:43:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:53806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfLWHn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 02:43:57 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25FA0206CB;
        Mon, 23 Dec 2019 07:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577087036;
        bh=h6EH2+PnURrm6sSUmcVcpanV5gKp3CsoiRzWqGWTG4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LQOUIxZv2iRve78q3Q2flctcenggUDshzxdU09nILznGnwlU/DyF7HFASDmjMLxen
         Jlz2vScxPNlI28NAE7Rn1WeOk7O/tswG+jYkha9OFYBJUvDFle8stK1TFGUO81NFqa
         kYUOijTh1xt2wOE2kzYnZbhHDN9BnwQIi/UWYMy4=
Date:   Mon, 23 Dec 2019 15:43:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH V2] arm: dts: imx7ulp: fix reg of cpu node
Message-ID: <20191223074331.GU11523@dragon>
References: <1576671574-14319-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576671574-14319-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 12:22:32PM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> According to arm cpus binding doc,
> "
>       On 32-bit ARM v7 or later systems this property is
>         required and matches the CPU MPIDR[23:0] register
>         bits.
> 
>         Bits [23:0] in the reg cell must be set to
>         bits [23:0] in MPIDR.
> 
>         All other bits in the reg cell must be set to 0.
> "
> 
> In i.MX7ULP, the MPIDR[23:0] is 0xf00, not 0, so fix it.
> Otherwise there will be warning:
> "DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map"
> 
> Fixes: 20434dc92c05 ("ARM: dts: imx: add common imx7ulp dtsi support")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

For arm32 DTS patches, we use 'ARM: ...' prefix.  Fixed it up and
applied.

Shawn
