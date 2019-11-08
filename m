Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B77F5AE0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 23:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfKHW2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 17:28:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfKHW2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 17:28:39 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07D7120865;
        Fri,  8 Nov 2019 22:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573252119;
        bh=LG611A+ex7oq1k+JPYb9ycFte2tnXj4oZlhBs5QXIfU=;
        h=In-Reply-To:References:From:To:Subject:Date:From;
        b=LeUbuj9WYeec1GKOZruYBgcjdf5hOZY7IaATePNLJiFvxYo0oEhb75+mln9EznTlR
         Zs2JNHzg6PtNV62t85S9ah3NXMYzKe83NxrR5YPY8d7bUUw6HT6EFtw6RaY1hD2a1q
         fpdRdiJZbq8D2riuDCxqLuhhtHN437AJQjbSbbHw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABvMjLSomcm5Yi8b8YNgJGkQkc++qdCS_SQvKfmsV0CfS+GLuA@mail.gmail.com>
References: <CABvMjLSomcm5Yi8b8YNgJGkQkc++qdCS_SQvKfmsV0CfS+GLuA@mail.gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Chengyu Song <csong@cs.ucr.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Yizhuo Zhai <yzhai003@ucr.edu>,
        Zhiyun Qian <zhiyunq@cs.ucr.edu>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Potential uninitialized variable "reg" in clk: axi-clkgen
User-Agent: alot/0.8.1
Date:   Fri, 08 Nov 2019 14:28:38 -0800
Message-Id: <20191108222839.07D7120865@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yizhuo Zhai (2019-10-09 17:55:06)
> Hi All:
> drivers/clk/clk-axi-clkgen.c:
>=20
> Inside function axi_clkgen_recalc_rate(), variable "reg" could be
> uninitialized if axi_clkgen_mmcm_read() fails. However, "reg" is used
> to decide the control flow later in the if statement, which is
> potentially unsafe.
>=20
> The patch for this case is not easy since the error return is not an
> acceptable return value for axi_clkgen_recalc_rate().
>=20

I think we will do nothing unless you send some sort of patch. Sorry.

