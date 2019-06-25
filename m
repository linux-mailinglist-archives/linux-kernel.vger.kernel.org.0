Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6FF755A16
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 23:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfFYVkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 17:40:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfFYVkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 17:40:00 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F0342084B;
        Tue, 25 Jun 2019 21:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561498799;
        bh=nyRwuJgfrpX9R0MJMgmknrMJZz1d3tHRTtm3SGWftsY=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=oOBsVfMLJpxrKCsCKt0C2yjKOyBs3EaUYMn9lPHO/xQ+/U6dwYK+qfFw19a9DWn/F
         Z0zKwILR0d1hjpHKDP6Vrh+Y/lXbaJK6o7JsceblKtv4wbkj/7W+pN5f5CRhcQKUsT
         ZI3LnsJf0S16oOFFdwgpFEB34jDELZwvk3bDB7I0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190625135535.14179-1-dinguyen@kernel.org>
References: <20190625135535.14179-1-dinguyen@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH RESEND] clk: socfpga: stratix10: fix divider entry for the emac clocks
Cc:     dinguyen@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 14:39:58 -0700
Message-Id: <20190625213959.7F0342084B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dinh Nguyen (2019-06-25 06:55:35)
> The fixed dividers for the emac clocks should be 2 not 4.
>=20
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---

Applied to clk-next

