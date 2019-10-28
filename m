Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF9C0E7D23
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 00:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbfJ1Xka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 19:40:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbfJ1Xk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 19:40:29 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07821214E0;
        Mon, 28 Oct 2019 23:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572306029;
        bh=ObPc5KxyfF36jBQrMbOO/RrJdWvyO4TVaIiA0XQNzyc=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=YkJki0OHTQCbmQe2ENpLJpntLyj1ThZeESVUxufVFkBQjK5yzJQzYbGsIy6S/qxc+
         swSCGeziuE9AE7bCWtLOBnQ+YmCmc/5+xJOaS5H1fiSeMew4Jc+2tSTNvi51g+i+EV
         jfB3Pw6I/c9kR4RM9bEr+uTp6ZZi5E42U7S/kOjU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191016131319.31318-1-joel@jms.id.au>
References: <20191016131319.31318-1-joel@jms.id.au>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: ast2600: Fix enabling of clocks
To:     Joel Stanley <joel@jms.id.au>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>
User-Agent: alot/0.8.1
Date:   Mon, 28 Oct 2019 16:40:28 -0700
Message-Id: <20191028234029.07821214E0@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joel Stanley (2019-10-16 06:13:19)
> The struct clk_ops enable callback for the aspeed gates mixes up the set
> to clear and write to set registers.
>=20
> Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Applied to clk-fixes

