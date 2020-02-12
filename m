Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEB715B45C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 00:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgBLXEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 18:04:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbgBLXEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:04:21 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4726321569;
        Wed, 12 Feb 2020 23:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581548660;
        bh=HrJBnblSfWmWwgI83SVI7TY0He/HLHUPnLOtpHBJKNs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Mj7I5OK79wE4/AaycfFfkvbGzGXqVboYK8N5KcvC0kfqhwRWRJIJWieiqNj22WOX2
         ptbvJDjRC1NU+ypfSNcc/vgMP0MpoRdT3gSipL9ZAmRhFydnSZMuhVnmebYxrwpHDE
         QGJgsuuSvzp73nYgl3McO2Ei3cf548I4jknfFlZE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1581307266-26989-1-git-send-email-tdas@codeaurora.org>
References: <1581307266-26989-1-git-send-email-tdas@codeaurora.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: clk: qcom: Add support for GPU GX GDSCR
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>, robh@kernel.org
Date:   Wed, 12 Feb 2020 15:04:19 -0800
Message-ID: <158154865957.184098.10654117317352376518@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2020-02-09 20:01:05)
> In the cases where the GPU SW requires to use the GX GDSCR add
> support for the same.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-next
