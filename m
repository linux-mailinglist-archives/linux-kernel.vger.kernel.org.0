Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E211155A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 23:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfFYVhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 17:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfFYVhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 17:37:01 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 256D920883;
        Tue, 25 Jun 2019 21:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561498620;
        bh=BLzSmjR9b+HaZLX9oIqe+r8P8oHxFdm13l5nu5siGNU=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=q4k7lDYZtDNT1A/IS9RSFJj/VROHbBZ0mN9Sap5YYfXAp/ly5TtBnlxI4Na94D+Ql
         Ozy0HkKwoL1XFw1aolZA+ypBFeCUypAKcJpMMlNKgvqxOtpTIbw7rUDco+XAJys5bb
         3mvM95JRKrTNAf7gI3PV1QbUhop37ekroxKd8cuo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190624214710.11836-1-dinguyen@kernel.org>
References: <20190624214710.11836-1-dinguyen@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: socfpga: stratix10: add additional clocks needed for the NAND IP
Cc:     dinguyen@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 14:36:59 -0700
Message-Id: <20190625213700.256D920883@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dinh Nguyen (2019-06-24 14:47:10)
> The nand_clk is actually called the nand_x_clk and the parent is the
> l4_mp_clk, not the l4_main_clk. The nand_clk is a child of the
> nand_x_clk and has a fixed divider of 4. The same is true for the
> nand_ecc_clk.
>=20
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---

Applied to clk-next

