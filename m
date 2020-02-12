Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90FB615ADF1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 18:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgBLRCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 12:02:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbgBLRCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:02:36 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D31420658;
        Wed, 12 Feb 2020 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581526955;
        bh=epztuBXNxSt78F+TKCt3ZY3CVeU3AJAclTwzzjcScOo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bO4uj04GC2zMlEPlQBJZaEiznnEDVyc6xaYnDmtAT3xtfJNbA5nMEcgKEkp/Q4fJj
         HPbwO4n1X2qBIVXufCpeUKIv5CrSl6w/6fFK0TBc8F5ccjYHRMIfQaBbg7ZcZtx2+N
         n5i7EVWUdyim1FdG7OhlyFMLjveKuvzih0+NOoSA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200212101947.9534-1-geert+renesas@glider.be>
References: <20200212101947.9534-1-geert+renesas@glider.be>
Subject: Re: [PATCH] xtensa: Replace <linux/clk-provider.h> by <linux/of_clk.h>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     Chris Zankel <chris@zankel.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Date:   Wed, 12 Feb 2020 09:02:34 -0800
Message-ID: <158152695460.121156.12938099669254492177@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2020-02-12 02:19:47)
> The Xtensa time code is not a clock provider, and just needs to call
> of_clk_init().
>=20
> Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
