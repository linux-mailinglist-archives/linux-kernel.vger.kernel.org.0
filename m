Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1898F3815F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 00:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfFFW5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 18:57:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfFFW5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 18:57:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3F3A2089E;
        Thu,  6 Jun 2019 22:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559861842;
        bh=SbcmLhRUMEcKE2G1wyLK7KO1wG+abbZtFt5UzD5yYPM=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=fLZhLm4O0ZRtATNhW6LC8DXAUlbFw6Hdz13pkrUZtvPnELiNLq2VReUt+CngNwlGD
         knziL1f0OQGfjCRdXxjd2806IfTPb5FK3Bqi+Iypc9kJPU2k3iD6SJOu/EVG9uOHqL
         /MBIOc9pI1yZaqRGKB3VCU/QwOE9nbYVyujz1y3E=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190502121843.14493-2-fparent@baylibre.com>
References: <20190502121843.14493-1-fparent@baylibre.com> <20190502121843.14493-2-fparent@baylibre.com>
To:     Fabien Parent <fparent@baylibre.com>, mark.rutland@arm.com,
        matthias.bgg@gmail.com, mturquette@baylibre.com,
        robh+dt@kernel.org, ryder.lee@mediatek.com, sean.wang@mediatek.com,
        wenzhen.yu@mediatek.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/2] clk: mediatek: add audsys clock driver for MT8516
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
User-Agent: alot/0.8.1
Date:   Thu, 06 Jun 2019 15:57:21 -0700
Message-Id: <20190606225721.F3F3A2089E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fabien Parent (2019-05-02 05:18:43)
> Add audsys clock driver for MediaTek MT8516 SoC.
>=20
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---

Applied to clk-next

