Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45CE9129A63
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 20:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfLWTdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 14:33:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfLWTdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 14:33:09 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3E6E20643;
        Mon, 23 Dec 2019 19:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577129589;
        bh=42fYECSTluuRQ8eLqMhkXNWwb8IO70Xx5mGL32XhXK0=;
        h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
        b=dLnNk/YN7gVRHkJ157sA0ImKSiZcsLw8dM1m2//GLkfeImDc9U4ztYuu2sTtksSCa
         +AgT8n7Na50i3VoDqVphcM641JDyDDTmvceD9d9zgR+SbzD886KW5motsX708cC9Ny
         JMnIBNVsc6A3Rk1V4GTRGUMuq7pFo9xCTmp4FgsI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191220065314.237624-3-lkundrak@v3.sk>
References: <20191220065314.237624-1-lkundrak@v3.sk> <20191220065314.237624-3-lkundrak@v3.sk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, soc@kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/5] clk: mmp2: Add HSIC clocks
User-Agent: alot/0.8.1
Date:   Mon, 23 Dec 2019 11:33:08 -0800
Message-Id: <20191223193308.E3E6E20643@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2019-12-19 22:53:11)
> There are two USB HSIC controllers on MMP2 and MMP3.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

