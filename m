Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 732588551F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 23:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfHGVXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 17:23:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388496AbfHGVXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:23:43 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABD8921743;
        Wed,  7 Aug 2019 21:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565213022;
        bh=grO+DVwLrFzvyLQYKg15Nx4cEFnP98gsoGYaAZVXCNE=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=HyDHtsGXL7qFR5SHG5nRm31lPdR5tAbu0p7NddSzjlOnRyE7zT6ZyMv2KzD6jzKed
         wQ3AR2FAdiefQOUVhDCuOhH7JB2/zdKozYht+ePkhjbUGEzxSRyQ931W0+ymXlEB4m
         jeH/RMq/OXuyirasbX5na8iMfgKXnRlj5fSD4Jew=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190701165020.19840-1-colin.king@canonical.com>
References: <20190701165020.19840-1-colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH][next] clk: Si5341/Si5340: remove redundant assignment to n_den
To:     Colin King <colin.king@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Wed, 07 Aug 2019 14:23:41 -0700
Message-Id: <20190807212342.ABD8921743@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2019-07-01 09:50:20)
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The variable n_den is initialized however that value is never read
> as n_den is re-assigned a little later in the two paths of a
> following if-statement.  Remove the redundant assignment.
>=20
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied to clk-next

