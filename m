Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC441DA209
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 01:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395483AbfJPXSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 19:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729316AbfJPXSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:18:37 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1F0120872;
        Wed, 16 Oct 2019 23:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571267916;
        bh=9GwVHIhpDb3lsuz2VZlfX9zCGY0Gd78lkJdnslS7qFI=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=olV9ACCmY1PV3guCBUGy0aYKJhjOmUEC+IxuUjWRfAG2qX9F++3J9LnkkHk73iAgX
         ayq7EZaMEOi8SIwFSOxoDQrzfp6M1UWqmNvXNX7y0TMO+maaGLEzlYGjqmZ/UbZ5HO
         KXha3+TxVuEplcNYtWcgJi2pfpc3EEERzj0EVjc8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <841d26a2adb4bf3b4423f82a41dd3f1346413db6.1570520268.git.baolin.wang@linaro.org>
References: <1995139bee5248ff3e9d46dc715968f212cfc4cc.1570520268.git.baolin.wang@linaro.org> <841d26a2adb4bf3b4423f82a41dd3f1346413db6.1570520268.git.baolin.wang@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>, mturquette@baylibre.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] clk: sprd: Change to use devm_platform_ioremap_resource()
User-Agent: alot/0.8.1
Date:   Wed, 16 Oct 2019 16:18:36 -0700
Message-Id: <20191016231836.C1F0120872@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Baolin Wang (2019-10-08 00:41:39)
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together, which can simpify the code.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---

Applied to clk-next

