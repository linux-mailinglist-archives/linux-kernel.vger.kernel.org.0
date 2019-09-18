Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D50FB5A95
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 07:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfIRFAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 01:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbfIRFAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 01:00:42 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9387218AE;
        Wed, 18 Sep 2019 05:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568782841;
        bh=E3gLt8qy6bKN/iocSp2f2JOPT5gytsrkMuVkTEdMOw0=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=waAJ9pg/NbDoVo7cpYvXZNLttKJQHLqdoJlfBLTH+2IIspcr/e7dM8nsW4T+kguuX
         LBSuIdfoqS1WkWXrJlTje0Olfmmk/8qFmJi4jGUou3KugeR0EsY45EMoYDRG+xUFAn
         j8SqKrHdlZi+9wZrE+nkCTtKqapeTmtu6VuQW5+g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1568183622-7858-1-git-send-email-eugen.hristev@microchip.com>
References: <1568183622-7858-1-git-send-email-eugen.hristev@microchip.com>
Cc:     Nicolas.Ferre@microchip.com, Eugen.Hristev@microchip.com
To:     Eugen.Hristev@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: at91: allow 24 Mhz clock as input for PLL
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 22:00:40 -0700
Message-Id: <20190918050041.A9387218AE@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eugen.Hristev@microchip.com (2019-09-10 23:39:20)
> From: Eugen Hristev <eugen.hristev@microchip.com>
>=20
> The PLL input range needs to be able to allow 24 Mhz crystal as input
> Update the range accordingly in plla characteristics struct
>=20
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---

Applied to clk-next

