Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78299151FF1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 18:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgBDRsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 12:48:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:45378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbgBDRsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:48:32 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4F0C20674;
        Tue,  4 Feb 2020 17:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580838511;
        bh=a3KBuVii4ykZYAHefMxyqZRiKMOGHzb5w1yXP18t36s=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=YdD56vXdyR5tndR7j+j0Q1unr67Ko8AWNSCgO6P/S+sF0WXJjFt0q/S5EyLq1Z07l
         bLjyOKj2JaWd0RMGac0KgEm42PC8IceW//CYvAIB4K7eVwWve3j55Uh7GqAc2Ueaqo
         x2h2LMzp1HDVhBUbhL/zQ65glNKQWim8M5xVqvN8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200203103049.v4.9.I6d5276b768f6593053be036a3e70cce298d39f0c@changeid>
References: <20200203183149.73842-1-dianders@chromium.org> <20200203103049.v4.9.I6d5276b768f6593053be036a3e70cce298d39f0c@changeid>
Subject: Re: [PATCH v4 09/15] clk: qcom: Get rid of the test clock for gpucc-sc7180
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, jeffrey.l.hugo@gmail.com,
        linux-arm-msm@vger.kernel.org, harigovi@codeaurora.org,
        devicetree@vger.kernel.org, mka@chromium.org,
        kalyan_t@codeaurora.org, Mark Rutland <mark.rutland@arm.com>,
        linux-clk@vger.kernel.org, hoegsberg@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Tue, 04 Feb 2020 09:48:31 -0800
Message-Id: <20200204174831.C4F0C20674@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-02-03 10:31:42)
> The test clock isn't in the bindings and apparently it's not used by
> anyone upstream.  Remove it.
>=20
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Applied to clk-next

