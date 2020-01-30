Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7CE14DFC6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 18:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgA3RTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 12:19:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbgA3RTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 12:19:40 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 497AC206F0;
        Thu, 30 Jan 2020 17:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580404780;
        bh=rFDsL3BUlrwi3Q5w/xvsiy0TB0QkGjD2JLhEr2G/vY8=;
        h=In-Reply-To:References:Subject:To:From:Cc:Date:From;
        b=XBrYWZAnXajfFQ063HsnBiHdxazTF/AWneCxmVziiHsqcMMVt4JmKAHZugqEBYU0L
         E+EMOgLu66J0YDf7UrK8jiGHTjdsnXNv8PyndaVigmEvEDtL2qnWjXC6jFeb7dHF77
         GxCAZq9wUMmBNP60D0T+PzZ1zD8mBauS9xC+02MA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200129163821.1547295-3-heiko@sntech.de>
References: <20200129163821.1547295-1-heiko@sntech.de> <20200129163821.1547295-3-heiko@sntech.de>
Subject: Re: [PATCH v3 3/3] clk: rockchip: convert rk3036 pll type to use internal lock status
To:     Heiko Stuebner <heiko@sntech.de>, linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, heiko@sntech.de,
        christoph.muellner@theobroma-systems.com, zhangqing@rock-chips.com,
        robin.murphy@arm.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
User-Agent: alot/0.8.1
Date:   Thu, 30 Jan 2020 09:19:39 -0800
Message-Id: <20200130171940.497AC206F0@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Heiko Stuebner (2020-01-29 08:38:21)
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
>=20
> The rk3036 pll type exposes its lock status in both its pllcon registers
> as well as the General Register Files. To remove one dependency convert
> it to the "internal" lock status, similar to how rk3399 handles it.
>=20
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

