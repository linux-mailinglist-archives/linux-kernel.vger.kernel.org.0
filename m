Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC210132009
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 07:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgAGG5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 01:57:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgAGG5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 01:57:50 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 150AF207FF;
        Tue,  7 Jan 2020 06:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578380270;
        bh=gXJJue7hgH5InTQmZ7hj+8r2WicBtPbs7DsJGQQWrtY=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=sSY0v66VvuYOXYjEvT5k0ywxAcnIPeH6hPq4QOPn6006Fcmnvoad96kPRUi45kr5u
         gavdV2KKth9S+YIgFmNV/njsoFcMI0bkmXvRGM1kmzmHxFBGGgDYEkQkLAWAC2sSzG
         ieLSbo/IxcRUIuxvygNnshCuiJGCdiG+lm0xQ3YI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190830150923.259497-8-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org> <20190830150923.259497-8-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 07/12] clk: fixed-rate: Add clk flags for parent accuracy
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 06 Jan 2020 22:57:49 -0800
Message-Id: <20200107065750.150AF207FF@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-30 08:09:18)
> Some clk providers want to use the accuracy of the parent clk and use
> the fixed rate basic type clk to do that. This requires getting the
> parent clk and extracting the accuracy before registering the fixed rate
> clk. Let's add a flag for this and update the clk_ops to support this.
>=20
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

