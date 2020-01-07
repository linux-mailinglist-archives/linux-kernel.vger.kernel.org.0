Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66635132013
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 07:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbgAGG6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 01:58:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727555AbgAGG6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 01:58:07 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44A80206DB;
        Tue,  7 Jan 2020 06:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578380287;
        bh=eUsS+9OV8oq4r1RDOOiNxN07Oc34uXxH50jSTlZHufo=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=ddRYLEmAZuWH4qyfENa3JG5jla+w6ORViKKSqK7qj9qiZ77lzs96YQkq3xos+4pOh
         bI5Vat4S6q/r0Nw3ULpSA8jpg5tUBWtAZrAAVtJI1SbALEoIZ1GY1uIfUu+whGPaMR
         X36tcRBzzu/gd9xO1zhVwphGgELZO2aPwhV2iAXI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190830150923.259497-13-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org> <20190830150923.259497-13-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 12/12] clk: divider: Add support for specifying parents via DT/pointers
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 06 Jan 2020 22:58:06 -0800
Message-Id: <20200107065807.44A80206DB@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-30 08:09:23)
> After commit fc0c209c147f ("clk: Allow parents to be specified without
> string names") we can use DT or direct clk_hw pointers to specify
> parents. Create a generic function that shouldn't be used very often to
> encode the multitude of ways of registering a divider clk with different
> parent information. Then add a bunch of wrapper macros that only pass
> down what needs to be passed down to the generic function to support
> this with less arguments.
>=20
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

