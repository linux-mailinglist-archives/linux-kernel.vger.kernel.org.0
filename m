Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E2DAEDD0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 16:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393669AbfIJOxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 10:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732106AbfIJOxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:53:15 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1209E216F4;
        Tue, 10 Sep 2019 14:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568127195;
        bh=ntFjl67nxoRyK8Sdto19vdllPdxmhbm0zE2ozFdj2D0=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=OQVRXs6Yol30TirIuzbeEzizXtcskMTz5Y3EZcqXs0JoyWTBFGJsaycxXx5pM188I
         j2Wtt2fib1CwZ+qmXl38NE4x1J+Ne6VqTYgu21MOP9ui84dHLe8+8z53k2ourCAPiq
         ejxfWbW5S6wfsIvAZ/sjMh0Hvzvb5QtR/2OSip84=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1566206502-4347-10-git-send-email-mars.cheng@mediatek.com>
References: <1566206502-4347-1-git-send-email-mars.cheng@mediatek.com> <1566206502-4347-10-git-send-email-mars.cheng@mediatek.com>
Cc:     CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        mtk01761 <wendell.lin@mediatek.com>, linux-clk@vger.kernel.org
To:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Sean Wang <sean.wang@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 09/11] clk: mediatek: Add dt-bindings for MT6779 clocks
User-Agent: alot/0.8.1
Date:   Tue, 10 Sep 2019 07:53:14 -0700
Message-Id: <20190910145315.1209E216F4@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mars Cheng (2019-08-19 02:21:40)
> From: mtk01761 <wendell.lin@mediatek.com>
>=20
> Add MT6779 clock dt-bindings, include topckgen, apmixedsys,
> infracfg, and subsystem clocks.
>=20
> Signed-off-by: mtk01761 <wendell.lin@mediatek.com>
> ---

Applied to clk-next

