Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95B1A191F27
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 03:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgCYCdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 22:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbgCYCdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 22:33:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BE7D20714;
        Wed, 25 Mar 2020 02:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585103628;
        bh=2yJJvOmfTjEvAcEL5kv6bJT0ZOpWZUNEjyffqitODPQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=L+cY5BN9ty3VRUkqVHcTZHowB8Urq1Rj7pzhiF+cWAl6TSNy4nDWYG26nTULJobcf
         ZxqBGKScg565aURtRCR7phxmH8OjRsIu2jA7X1QQAuGqj2x6o/6Py0gH5fNh4jnXf+
         qECBbvkeV36G+/3Q+h/FBtize0mO3S4+QyFhRg0U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200309221232.145630-2-sboyd@kernel.org>
References: <20200309221232.145630-1-sboyd@kernel.org> <20200309221232.145630-2-sboyd@kernel.org>
Subject: Re: [PATCH 1/2] clk: qcom: rpmh: Simplify clk_rpmh_bcm_send_cmd()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Tue, 24 Mar 2020 19:33:47 -0700
Message-ID: <158510362776.125146.11065115657793883744@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-03-09 15:12:31)
> This function has some duplication in unlocking a mutex and returns in a
> few different places. Let's use some if statements to consolidate code
> and make this a bit easier to read.
>=20
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> CC: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
