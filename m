Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9681385505
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 23:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389326AbfHGVPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 17:15:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfHGVPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:15:42 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D6B0217D9;
        Wed,  7 Aug 2019 21:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565212541;
        bh=mPs5ZRxH/plyzQCc3mZVnB4VCrN6NeDkFyiCjTFTVtE=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=evVShKsELYA/qJL/FotSY8uoAWZf/EbpbypuGS9QvppQIIUWYxHHjl70dzSqeF2/s
         BHZw3OUEZ0Nq7db9hOloZhWWBoVvcnV8fWciveKFPCSnX38Rq6WajRrhfbyJ1Zx9Gc
         1jmyIRmeSDb4mjzAWhRtKj/hmThM7QY0q3pyKpO8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190710141009.20651-1-andrew@aj.id.au>
References: <20190710141009.20651-1-andrew@aj.id.au>
Cc:     Joel Stanley <joel@jms.id.au>, mturquette@baylibre.com,
        ryanchen.aspeed@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: aspeed: Add SDIO gate
To:     Andrew Jeffery <andrew@aj.id.au>, linux-clk@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Wed, 07 Aug 2019 14:15:40 -0700
Message-Id: <20190807211541.5D6B0217D9@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Jeffery (2019-07-10 07:10:09)
> From: Joel Stanley <joel@jms.id.au>
>=20
> The clock divisor comes with an enable bit (gate). This was not
> implemented as we didn't have access to SD hardware when writing the
> driver. Now that we can test it, add the gate as a parent to the
> divisor.
>=20
> There is no reason to expose the gate separately, so users will enable
> it by turning on the ASPEED_CLK_SDIO divisor.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> [aj: Minor style cleanup]
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---

Applied to clk-next

