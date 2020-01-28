Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD5714C292
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 23:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgA1WEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 17:04:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:60880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgA1WEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:04:46 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE778207FD;
        Tue, 28 Jan 2020 22:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580249085;
        bh=DwHhjxonGfhRBhfm6DKZap3UKOXbvwtde49wjyeZc3k=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=0XLBzC1mgdzImyl5ll1gXEvJPq62+7ulErNi9w0TucGqlT8EakJR5quuU/+HS0O+k
         fyZh3mhHeNGFC77fDDW3RHCoQLIKwHh0rFJryifu9DHNi8AXZLsC8Ddi8/xHga+5ed
         LjJGk88qucnPU6vZ718BQ+Uhv8EXBiWl9q08Rc8I=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200102231101.11834-2-michael@walle.cc>
References: <20200102231101.11834-1-michael@walle.cc> <20200102231101.11834-2-michael@walle.cc>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: clock: document the fsl-sai driver
To:     Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Walle <michael@walle.cc>, Rob Herring <robh@kernel.org>
User-Agent: alot/0.8.1
Date:   Tue, 28 Jan 2020 14:04:45 -0800
Message-Id: <20200128220445.DE778207FD@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michael Walle (2020-01-02 15:11:00)
> Signed-off-by: Michael Walle <michael@walle.cc>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next

