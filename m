Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E62517EF4C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 04:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgCJDco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 23:32:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgCJDco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 23:32:44 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7C6024671;
        Tue, 10 Mar 2020 03:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583811163;
        bh=qkDKOMV7QctTl0QDnIlpTw5MQKWwxRKuxkYh93xEX70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VwvcrPfjbTGrIGLthzALZvv20YpylM4lN7J8wElvRok/GOACijl8xx1KFWqXrEaCi
         YGvjijssmi8xH+wXHor3numDwqTCSdudVYxCTWHURGULepnCATc3jFutdzFyET6gec
         Di5blsdV1ock5d59nCokk582bmuC3owvrhl6HR4s=
Date:   Tue, 10 Mar 2020 11:32:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, aisheng.dong@nxp.com, peng.fan@nxp.com,
        fugang.duan@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] firmware: imx: scu-pd: add power domain for I2C and
 INTMUX in CM40 SS
Message-ID: <20200310033230.GA15729@dragon>
References: <1581909561-12058-1-git-send-email-qiangqing.zhang@nxp.com>
 <1581909561-12058-2-git-send-email-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581909561-12058-2-git-send-email-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 11:19:15AM +0800, Joakim Zhang wrote:
> Add power domain for I2C and INTMUX in CM40 SS.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

Applied, thanks.
