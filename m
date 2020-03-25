Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEFC191F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 03:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgCYCdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 22:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbgCYCdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 22:33:52 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F79C20724;
        Wed, 25 Mar 2020 02:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585103632;
        bh=AvA8oO+nGO+Fqj87/wMvXZnjbd/focwYI0y4gQoIMQY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=2M8zExUiDz1eH1VoOlxZbWnIP0FDsiEqv2m4PihQUNYsLv8FBzbKFFTXvBwMoyKAv
         M+KjgBzqXJZIvwVGy/OC+wcuNN+Xtci6OvoASZJ72h/hyq84NSBOQKfukABY/fmzn/
         frDOO7HB5VdXRXJeMIQ55/LsHK+faL+l+MRLpTTc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200309221232.145630-3-sboyd@kernel.org>
References: <20200309221232.145630-1-sboyd@kernel.org> <20200309221232.145630-3-sboyd@kernel.org>
Subject: Re: [PATCH 2/2] clk: qcom: rpmh: Drop unnecessary semicolons
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Tue, 24 Mar 2020 19:33:51 -0700
Message-ID: <158510363123.125146.1108786142813393278@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-03-09 15:12:32)
> Some functions end in }; which is just bad style. Remove the extra
> semicolon.
>=20
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
