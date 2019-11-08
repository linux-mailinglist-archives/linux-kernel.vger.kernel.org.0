Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9239DF592D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 22:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbfKHVHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 16:07:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:54482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729973AbfKHVHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:07:08 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8220420865;
        Fri,  8 Nov 2019 21:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573247227;
        bh=yw3Wks3+OuBGI/aNPSNar3tbWKS3qQGk9xnPEixJja4=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=BY5QsDaODsF9hk1DYyI3IArhHOnTu8UKKbwE0QtpYAF3T/b9VPB5nQU9xTSeJgGV/
         5licrcxzE9BGmKxkW8wiXtSw0YAevku1DP8m/wHcbuyCvm+LFgfNo2KnlzPXyTD2Qd
         +5CfFYvCbxSp3bEXgbpMJtVAUZm2Tyzk6Zd6E0cU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191107214018.184105-1-sboyd@kernel.org>
References: <20191107214018.184105-1-sboyd@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH] clk: qcom: rpmh: Reuse sdm845 clks for sm8150
User-Agent: alot/0.8.1
Date:   Fri, 08 Nov 2019 13:07:06 -0800
Message-Id: <20191108210707.8220420865@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-11-07 13:40:18)
> The SM8150 list of clks is almost the same as the list for SDM845,
> except there isn't an IPA clk. Just point to the SDM845 clks from the
> SM8150 list for now so we can reduce the amount of struct bloat in this
> driver.
>=20
> Suggested-by: Vinod Koul <vkoul@kernel.org>
> Cc: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

