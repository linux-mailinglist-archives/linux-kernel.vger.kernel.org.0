Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D78129A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 20:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLWTce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 14:32:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfLWTce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 14:32:34 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F24720643;
        Mon, 23 Dec 2019 19:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577129553;
        bh=QfKtMLGxljFw/KshM8x46uF/Pyo4opuhzCgjdMUg6yo=;
        h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
        b=KTMyiuvyhndvakZKuyNbsQvJekp61EtkjMEEOOKjsgTchQ5vmUJLcrYwlyBPHAlCk
         5fZToEbdJIHVRaveWXM1m0vpQRfoKrt5ToHv8a59oJvoQL+n74vJdJA6qO3Qk9VtKI
         BdPnJU8vVNdMDHOOQb+r55lDOIo43TuAxJ8+I+vo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191220065314.237624-2-lkundrak@v3.sk>
References: <20191220065314.237624-1-lkundrak@v3.sk> <20191220065314.237624-2-lkundrak@v3.sk>
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
Subject: Re: [PATCH 1/5] dt-bindings: marvell,mmp2: Add clock ids for the HSIC clocks
User-Agent: alot/0.8.1
Date:   Mon, 23 Dec 2019 11:32:32 -0800
Message-Id: <20191223193233.7F24720643@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2019-12-19 22:53:10)
> There are two USB HSIC controllers on MMP2 and MMP3.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

