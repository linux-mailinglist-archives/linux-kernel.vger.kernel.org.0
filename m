Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7D44B53FA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 19:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbfIQRVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 13:21:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfIQRVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:21:09 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB65E20640;
        Tue, 17 Sep 2019 17:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568740869;
        bh=ydTUCdJAPGYhabNpZ66dL0ndFxJMVe5sulmz4uh2qJM=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=AJfmEDdwEAlzgHOPus89Nua4kSlGVHzLRwMB1032GSSlTMmduuiN+0qjPoBVygNyM
         fY8QpSfU1cx3xTWmF56Gfe4l8FsQVM7OZWHyeY6+jhADteguoS4noqDG6CPMLZtoz+
         3eDY4DKU/6iwersL3tKWWjlthrvWgnxuwX0VPcqA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1566980533-28282-2-git-send-email-chunfeng.yun@mediatek.com>
References: <1566980533-28282-1-git-send-email-chunfeng.yun@mediatek.com> <1566980533-28282-2-git-send-email-chunfeng.yun@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Erin Lo <erin.lo@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 2/2] clk: mediatek: add pericfg clocks for MT8183
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 10:21:08 -0700
Message-Id: <20190917172108.EB65E20640@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunfeng Yun (2019-08-28 01:22:13)
> Add pericfg clocks for MT8183, it's used when support USB
> remote wakeup
>=20
> Cc: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---

Applied to clk-next

