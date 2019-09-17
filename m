Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54BFEB5438
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 19:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbfIQR20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 13:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731152AbfIQR2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:28:25 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1760C2171F;
        Tue, 17 Sep 2019 17:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568741305;
        bh=i6cu//8UqqnO+AXA2MTlSGElpD6de5WiTt762/oa82w=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=0tMCD6z73L9+9dQNwM1b+ZADypT22NiA64cLairhrh0p0O4PYjpxQ0uqjnqYxM53T
         nRoQ1DC2HoFni38vzHwBxHOw97Pq8edm9msUqyeIVctZvwYP3MnkiASSJqvUUQ+h+R
         FXAl8qvFKyOF0IQVB5d3uhq6qHXYIzkSH4xKcI2c=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190822093126.594013-1-lkundrak@v3.sk>
References: <20190822093126.594013-1-lkundrak@v3.sk>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: remove extra ---help--- tags in Kconfig
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 10:28:24 -0700
Message-Id: <20190917172825.1760C2171F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2019-08-22 02:31:26)
> Sometimes an extraneous "---help---" follows "help". That is probably a
> copy&paste error stemming from their inconsistent use. Remove those.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Applied to clk-next

