Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 675B4DA23F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 01:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438682AbfJPXdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 19:33:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732849AbfJPXdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:33:41 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57DC12168B;
        Wed, 16 Oct 2019 23:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571268821;
        bh=/E0VyZIy4/8Mg0FgYOZKjRIod7V/jBESeEq3WrZKmAw=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=HTUwJo9YfO3eqNKfYZtv1XYTDTy1NmvGE4bgc9YX4cc1pFGgIwro51GHr2/QJyC1n
         Kim1Dq4jhY4bALixDzKyPlxHdUeZqQGsebcsvmlehcDeeIAMDOUSS+mDUC94dxbQK6
         1W/9/qyW3sPznsno1QwaSS9qC4tcGyC/0FgmzDto=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191015121735.26228-1-yuehaibing@huawei.com>
References: <20191015121735.26228-1-yuehaibing@huawei.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>, allison@lohutok.net,
        gregkh@linuxfoundation.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, rfontana@redhat.com, tglx@linutronix.de
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] clk: mediatek: mt7622: use devm_platform_ioremap_resource() to simplify code
User-Agent: alot/0.8.1
Date:   Wed, 16 Oct 2019 16:33:40 -0700
Message-Id: <20191016233341.57DC12168B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-10-15 05:17:35)
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next

