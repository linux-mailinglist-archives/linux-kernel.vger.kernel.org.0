Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03BE5AEDC8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 16:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392567AbfIJOxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 10:53:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732106AbfIJOxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:53:10 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C48421479;
        Tue, 10 Sep 2019 14:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568127190;
        bh=NnZvpAPp1JY2JAEz2JDDpJXD0IBzD0bjDvth6kMNPJg=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=mI+egIP/Ls8WMbn49fMaaO+nsJwgreE2LqKTz86Li6BopVAlXgnyEnriclpgAUb18
         iCG2+qd6ZPlYnaqEn1KmZyk41vEgHsTR2mFevk1WQhFXr8oT2ZCpT482nffnk5Wil+
         Ct2aLv4jqPNHVNfAQa+lTLwbufXFlXmsfX2ltBtQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1566206502-4347-9-git-send-email-mars.cheng@mediatek.com>
References: <1566206502-4347-1-git-send-email-mars.cheng@mediatek.com> <1566206502-4347-9-git-send-email-mars.cheng@mediatek.com>
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
Subject: Re: [PATCH v2 08/11] dt-bindings: mediatek: bindings for MT6779 clk
User-Agent: alot/0.8.1
Date:   Tue, 10 Sep 2019 07:53:09 -0700
Message-Id: <20190910145310.2C48421479@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mars Cheng (2019-08-19 02:21:39)
> From: mtk01761 <wendell.lin@mediatek.com>
>=20
> This patch adds the binding documentation for
> apmixedsys, audiosys, camsys, imgsys, ipesys,
> infracfg, mfgcfg, mmsys, topckgen, vdecsys,
> and vencsys for Mediatek MT6779.
>=20
> Signed-off-by: mtk01761 <wendell.lin@mediatek.com>
> ---

Applied to clk-next

