Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A09F2CADE8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 20:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbfJCSNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 14:13:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732618AbfJCSNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:13:54 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 304B520862;
        Thu,  3 Oct 2019 18:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570126434;
        bh=OEFcG8Srhv/ZYjCll5MhUaVrXvpLIbrBCRSqjpiiIA8=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=sUPn/ARNFZqfClXLICHZK6NPr0REdXEB476kJ0611ANUQHt9gL40z9v8L14djPWn+
         izGkbv1jIE8yRn8xIzhu7FDNm+RXop7VmOFFBOFSZDFQNrj2tNykzR6ZueyWoR3+/O
         4xS6sxAYfdZJYGfydjpeOhAQcPHkDi9YExTXxzY4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1569553244-3165-5-git-send-email-zhangqing@rock-chips.com>
References: <1569553244-3165-1-git-send-email-zhangqing@rock-chips.com> <1569553244-3165-5-git-send-email-zhangqing@rock-chips.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        Elaine Zhang <zhangqing@rock-chips.com>
Subject: Re: [PATCH v3 4/5] clk: rockchip: add pll up and down when change pll freq
User-Agent: alot/0.8.1
Date:   Thu, 03 Oct 2019 11:13:53 -0700
Message-Id: <20191003181354.304B520862@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Elaine Zhang (2019-09-26 20:00:43)
> set pll sequence:
>         ->set pll to slow mode or other plls
>         ->set pll down
>         ->set pll params
>         ->set pll up
>         ->wait pll lock status
>         ->set pll to normal mode
>=20
> To slove the system error:

solve?

> wait_pll_lock: timeout waiting for pll to lock
> pll_set_params: pll update unsucessful,
>                 trying to restore old params
>=20

This commit text needs help. It looks like pseudo-code.

