Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 755D0191F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 03:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgCYC2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 22:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbgCYC2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 22:28:14 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B862320714;
        Wed, 25 Mar 2020 02:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585103293;
        bh=2DoQvWSfSUyb/O+cac3YzadOd+Zx15xEkvIy4BYdPpw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=E5GK46EuR4njBQMPJqLwOWXoW6mRNvfouwqIxgMbkm9nlUhZBqlDWhS0HGZME6Bi9
         TItLxgOkJgiefm1vS7c+ilr8/y6b2ZEPhgqH1ccU2DZ3+JuUsoXZa3VN5za1+iYAAM
         nVMz9vyM+8noCvwi7jIO6KuY/D5eseHU6UXKmg54=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200325022257.148244-1-sboyd@kernel.org>
References: <20200325022257.148244-1-sboyd@kernel.org>
Subject: Re: [PATCH] clk: Pass correct arguments to __clk_hw_register_gate()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Tue, 24 Mar 2020 19:28:12 -0700
Message-ID: <158510329289.125146.2737057581185153152@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-03-24 19:22:57)
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 952ac035bab9..95cc8a4f6e39 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -539,10 +539,10 @@ struct clk *clk_register_gate(struct device *dev, c=
onst char *name,
>   * @clk_gate_flags: gate-specific flags for this clock
>   * @lock: shared register lock for this clock
>   */
> -#define clk_hw_register_gate_parent_data(dev, name, parent_name, flags, =
reg,  \
> +#define clk_hw_register_gate_parent_data(dev, name, parent_data, flags, =
reg,  \
>                                        bit_idx, clk_gate_flags, lock)    =
     \
> -       __clk_hw_register_gate((dev), NULL, (name), (parent_name), NULL, =
     \
> -                              NULL, (flags), (reg), (bit_idx),          =
     \
> +       __clk_hw_register_gate((dev), NULL, (name), NULL, NULL, (parent_d=
ata) \

And this needs a comma after it.

I'll apply this to clk-fixes and send to Linus in the next few days.

> +                              (flags), (reg), (bit_idx),                =
     \
>                                (clk_gate_flags), (lock))
