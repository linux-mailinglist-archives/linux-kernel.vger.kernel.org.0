Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 847228C51A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 02:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfHNAZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 20:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfHNAZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 20:25:30 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 795E620844;
        Wed, 14 Aug 2019 00:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565742329;
        bh=QJGNq5K2WcYs2wUMlToJJUeku7ZnJDO0C0x7LZ2dbEk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dXe909GKrfuIWB/6ClVXkwkHGU1eUgNht8PtfTd39aOQzhMahTui/cQNXOb5U779Y
         6tUAlpb1aeHXZj2HKt5EYKjdnsObv0Jq/W2ITzFGLfqnOF+3r8dC6Sw9QAVqcPSY+J
         ntFwfNkoUkO3xJOmAIKhYyWUkyYje5cD1vOxQLyw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190731193517.237136-10-sboyd@kernel.org>
References: <20190731193517.237136-1-sboyd@kernel.org> <20190731193517.237136-10-sboyd@kernel.org>
Subject: Re: [PATCH 9/9] clk: Overwrite clk_hw::init with NULL during clk_register()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Tue, 13 Aug 2019 17:25:28 -0700
Message-Id: <20190814002529.795E620844@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-07-31 12:35:17)
> We don't want clk provider drivers to use the init structure after clk
> registration time, but we leave a dangling reference to it by means of
> clk_hw::init. Let's overwrite the member with NULL during clk_register()
> so that this can't be used anymore after registration time.
>=20
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

