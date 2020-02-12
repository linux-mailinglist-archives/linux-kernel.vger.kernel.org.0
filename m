Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1399315B428
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 23:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgBLW4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 17:56:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728185AbgBLW4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:56:10 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D357B2168B;
        Wed, 12 Feb 2020 22:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581548169;
        bh=SCnNSfEGNeaLvEPYBFXgqfow4bBeZQwy5T7gptghPE8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=x/+w7+6ZCMH4J8zy6pThODObm0WIsKddbKyctJ1uGJ2hLo2RqxUYjFhzF/DOhJgqJ
         /IQuYnyWJxDNkg8SRGiWkoBFl0RP6kIuVEMXx6kOgGrOqFvvX7H8FBGG7prp5Hl2Xa
         sP9pjAeUtAb6P53W5C0wakF+gvlwUz82LxutybE4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1581490943-17920-1-git-send-email-Anson.Huang@nxp.com>
References: <1581490943-17920-1-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH] clk: imx: Include clk-provider.h instead of clk.h for i.MX8M SoCs clock driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, abel.vesa@nxp.com,
        festevam@gmail.com, jun.li@nxp.com, kernel@pengutronix.de,
        leonard.crestez@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, peng.fan@nxp.com, ping.bai@nxp.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Wed, 12 Feb 2020 14:56:09 -0800
Message-ID: <158154816906.184098.11837279192030973805@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-02-11 23:02:23)
> The i.MX8M SoCs clock driver are provider, NOT consumer, so clk-provider.h
> should be used instead of clk.h.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
