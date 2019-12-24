Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 917EC129CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 04:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfLXC7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 21:59:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:58800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbfLXC7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 21:59:54 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F419F20709;
        Tue, 24 Dec 2019 02:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577156394;
        bh=MHunSC4TWQNoyQvvbVQmGGtWnGdlGPMSSzGaJcjZTII=;
        h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
        b=lf3WVvBOwlWomSCyRIYVJ8Pcdy66FsrtpAV8SVSgohsq2yBqmuBSJb5bOVnV064Ok
         HYPOn8iSdEHs2g3wZz5oScM8h12T1zXUW2x9RZh84sPKZfiRCIY1TCDacS5YXS2ydB
         +rLwf/8FbGpaQ7TsrqNFQsFTTUi0zbfb8ckru2Us=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190924123954.31561-4-jbrunet@baylibre.com>
References: <20190924123954.31561-1-jbrunet@baylibre.com> <20190924123954.31561-4-jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 3/3] clk: add terminate callback to clk_ops
User-Agent: alot/0.8.1
Date:   Mon, 23 Dec 2019 18:59:53 -0800
Message-Id: <20191224025953.F419F20709@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-09-24 05:39:54)
> Add a terminate callback to the clk_ops to release the resources
> claimed in .init()
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Applied to clk-next

