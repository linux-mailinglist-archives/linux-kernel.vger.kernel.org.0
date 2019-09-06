Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5DDAC275
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 00:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404861AbfIFWXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 18:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391961AbfIFWXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 18:23:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04419214E0;
        Fri,  6 Sep 2019 22:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567808629;
        bh=7fWT4pSEpV668ptngcAoGmXNSeOFGFx6ayqh1U9b/uc=;
        h=In-Reply-To:References:To:From:Cc:Subject:Date:From;
        b=PcVCeOpwb38RDWS/yuj5NA6PzqfUXRkDLDdWnyHqWvGf+ibd3zRGHXkz+W5PI+Mi/
         uQsMpsP4fmSBvZDsCFX2sxrmLFU0QaBs7hGaJzuUfm9PQIP57QxduygJsaYI5UMf8Q
         yltad5HTkUhYeC0w5OhY+BKUvA026HZlDJ5p5wmc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190825141848.17346-3-joel@jms.id.au>
References: <20190825141848.17346-1-joel@jms.id.au> <20190825141848.17346-3-joel@jms.id.au>
To:     Joel Stanley <joel@jms.id.au>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] clk: Add support for AST2600 SoC
User-Agent: alot/0.8.1
Date:   Fri, 06 Sep 2019 15:23:48 -0700
Message-Id: <20190906222349.04419214E0@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joel Stanley (2019-08-25 07:18:48)
> The ast2600 is a new BMC SoC from ASPEED. It contains many more clocks
> than the previous iterations, so support is broken out into it's own
> driver.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Applied to clk-next

