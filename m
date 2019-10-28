Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E13D8E6F28
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 10:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733274AbfJ1JeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 05:34:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730412AbfJ1JeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:34:09 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2FB020B7C;
        Mon, 28 Oct 2019 09:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572255248;
        bh=wt7wY2XXzBNHgwGfoHCaCbW8jjguK6Tt1epg+hNe6t0=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=tlf0EWQenuUC9Poai0zEw4HgO3ax5MtKBHBUkhuut7YO06cu+b0OyEsix0nYsm9+8
         UoDMBDXEXSmyxjZdpI1kLeE2HBjj3lgpX+C+Z3pjr80un8JqhF9Y/Aen7PF3RPKbvc
         3Y2SrzIz3O8jaUtoll2lCgp/NByODB3xbfEM3qeE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191018154201.1276638-36-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de> <20191018154201.1276638-36-arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 36/46] ARM: pxa: move smemc register access from clk to platform
To:     Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
User-Agent: alot/0.8.1
Date:   Mon, 28 Oct 2019 02:34:07 -0700
Message-Id: <20191028093408.B2FB020B7C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2019-10-18 08:41:51)
> The get_sdram_rows() and get_memclkdiv() helpers need smemc
> register that are separate from the clk registers, move
> them out of the clk driver, and use an extern declaration
> instead.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

