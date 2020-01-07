Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC47132008
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 07:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgAGG5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 01:57:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:34146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgAGG5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 01:57:47 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C994206DB;
        Tue,  7 Jan 2020 06:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578380267;
        bh=Jnu9fLHdwStF+AS9+hAiCSf7VY6jLg776ztQ1t6rgbM=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=lRPsMRSPHgXhU78pTkxszHSxzsFvesiOuuRPBuU79S357p91ivjtY6ka9eEE9aFol
         +S4tzi3liMQR5qNmPmkaUDReHibSlDYTbiDAD/ogsiDtweuBQdKgjvAdnxLfz9jYsv
         ILT+/mTBmQ9oQIGHEiruC/DwizNgvUtBALZEm82Q=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190830150923.259497-7-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org> <20190830150923.259497-7-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 06/12] clk: fixed-rate: Add support for specifying parents via DT/pointers
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 06 Jan 2020 22:57:46 -0800
Message-Id: <20200107065747.0C994206DB@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-30 08:09:17)
> After commit fc0c209c147f ("clk: Allow parents to be specified without
> string names") we can use DT or direct clk_hw pointers to specify
> parents. Create a generic function that shouldn't be used very often to
> encode the multitude of ways of registering a fixed rate clk with
> different parent information. Then add a bunch of wrapper macros that
> only pass down what needs to be passed down to the generic function to
> support this with less arguments.
>=20
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

