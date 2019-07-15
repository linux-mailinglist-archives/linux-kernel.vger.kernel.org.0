Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D795D69E97
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 00:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbfGOWAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 18:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbfGOWAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 18:00:43 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55E8A20665;
        Mon, 15 Jul 2019 22:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563228043;
        bh=Iy7STftwgZfnOEy4ZhvvVHfFsXBiGQ26ut0JvJEzVFs=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=lVfD/jQOT5YdHENMFIJqYuaTYaZwgEZimApdtyeyxJcca4+PCOeMORIyMa5vkfqDE
         Zd39bIh+JO/NRUbCY3qpPGwtnlUy8twpjL0l36r5d0ddjjiZYArSMc/uyvuTmmnRaA
         drIVrelplVuvLVL8edVH++rth2ndm6xD4p6BqDKY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190715201234.13556-1-andrew.smirnov@gmail.com>
References: <20190715201234.13556-1-andrew.smirnov@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-clk@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] clk: Sync prototypes for clk_bulk_enable()
User-Agent: alot/0.8.1
Date:   Mon, 15 Jul 2019 15:00:42 -0700
Message-Id: <20190715220043.55E8A20665@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrey Smirnov (2019-07-15 13:12:29)
> No-op version of clk_bulk_enable() should have the same protoype as
> the real implementation, so constify the last argument to make it so.
>=20
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---

No cover letter, but I'm inclined to squash these all together into one
patch instead of 6. I'm not sure why each function gets a different
patch.

>  include/linux/clk.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
