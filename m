Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43C6657073
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 20:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfFZSQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 14:16:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfFZSQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:16:48 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 993C221726;
        Wed, 26 Jun 2019 18:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561573007;
        bh=ngfloKnnEljm5koGJ5y0rZ8cyy4BPg9KdJZKx/SEddk=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=2rBqUqBZkbNa47oKYmqOlCjsXw7fvrPVeaLx3mkT665MfNL2CP8LtDZM1AaGPICRt
         TphgoDg2KmGK3cMU/FMdW3vXX+c2+D+CUS4nQkjeQThHu42C6vpRTp0cDyh8xN7GzO
         QtzeTx5T3Z7Nig2Y4fx7qYmoUSfRnLTC7iOIK+3s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190522011504.19342-4-zhang.chunyan@linaro.org>
References: <20190522011504.19342-1-zhang.chunyan@linaro.org> <20190522011504.19342-4-zhang.chunyan@linaro.org>
To:     Chunyan Zhang <zhang.chunyan@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 3/3] clk: sprd: Add check for return value of sprd_clk_regmap_init()
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
User-Agent: alot/0.8.1
Date:   Wed, 26 Jun 2019 11:16:46 -0700
Message-Id: <20190626181647.993C221726@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2019-05-21 18:15:03)
> sprd_clk_regmap_init() doesn't always return success, adding check
> for its return value should make the code more strong.
>=20
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
> ---

Applied to clk-next

