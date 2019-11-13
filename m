Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9C7BFBC31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 00:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfKMXEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 18:04:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbfKMXEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 18:04:21 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48A04206E3;
        Wed, 13 Nov 2019 23:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573686262;
        bh=hVxRaAKO0Uplv/Oc7yoFCmBYC10wOCMNRXTieFKdhrs=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=EqDjLfdAniDVLR4+36d5vVDB7xvMJ/Q3raqmT+k9PWjKTYmtb9RUheNBn9/YELbxZ
         Q9Ioc0G+laMtSa/ZCii9zf3BAQftZ4FVYvUDKBS0h2KG5s1ai8qgrtdUIdpAGGtzBL
         z7oS7+JtuNmx1d6pBQkpPLSbVC1ndJn4cVxxYNlU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191109034226.21044-1-yuehaibing@huawei.com>
References: <20191109034226.21044-1-yuehaibing@huawei.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, jonathanh@nvidia.com,
        mturquette@baylibre.com, pdeschrijver@nvidia.com,
        pgaikwad@nvidia.com, thierry.reding@gmail.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH -next] clk: tegra: Use match_string() helper to simplify the code
User-Agent: alot/0.8.1
Date:   Wed, 13 Nov 2019 15:04:20 -0800
Message-Id: <20191113230422.48A04206E3@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-11-08 19:42:26)
> match_string() returns the array index of a matching string.
> Use it instead of the open-coded implementation.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next

