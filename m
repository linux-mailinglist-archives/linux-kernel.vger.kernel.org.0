Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03A7A160BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 08:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgBQHeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 02:34:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:60462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbgBQHeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:34:00 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A16120702;
        Mon, 17 Feb 2020 07:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581924840;
        bh=tNBv8M1oz0oCkR1qBf0U014EsCGTKHhm13pHF8rCiyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yko3PBE32A8ns5DNSSNyu8oDVlFZtm8RjsN96TZXUvG8MyRZS4Iziy0rEuP2ev2si
         2Wr3xN1BuYRXLnU5gO0EcmHtHnZ0aJjLAZ6SFicwl2+zrnhkKfWdl0QCx5wj3R9k2O
         SmdeJfDrjRv47ydbel5lnq4GSIWz6dtccUxA+iJo=
Date:   Mon, 17 Feb 2020 15:33:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/5] ARM: dts: imx6qdl: make clks node name generic
Message-ID: <20200217073354.GH7973@dragon>
References: <1581649180-26086-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581649180-26086-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 10:59:36AM +0800, Anson Huang wrote:
> Node name should be generic, use "clock-controller" instead of
> "ccm" for clks node.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied with squashing, thanks.
