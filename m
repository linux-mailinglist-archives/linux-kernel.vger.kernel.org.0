Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA62270B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 23:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbfGVVaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 17:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731852AbfGVVaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:30:11 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C64421900;
        Mon, 22 Jul 2019 21:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563831011;
        bh=F1h4fbko3GoKghOyB8V2PZNI7J3t6w8bvytUqOh9UCI=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=lKNFptlRtG+jdk5J6/RG/mxeYrChsOZgEG7uWSrdIecM4fgYTLnaNjW1FabV+PB3f
         P/W2bulFx9XZidJ6MqJX97/eJGtsTM14z4p1kAQl0ptKDcUm133f0Ab+5tZe9QTIl3
         vKUZtYRXL7ZiHsd17KAGufwcFQySmMVAk1SF1uQA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190708154730.16643-11-sudeep.holla@arm.com>
References: <20190708154730.16643-1-sudeep.holla@arm.com> <20190708154730.16643-11-sudeep.holla@arm.com>
Subject: Re: [PATCH 10/11] firmware: arm_scmi: Drop config flag in clk_ops->rate_set
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jul 2019 14:30:10 -0700
Message-Id: <20190722213011.0C64421900@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sudeep Holla (2019-07-08 08:47:29)
> CLOCK_PROTOCOL_ATTRIBUTES provides attributes to indicate the maximum
> number of pending asynchronous clock rate changes supported by the
> platform. If it's non-zero, then we should be able to use asynchronous
> clock rate set for any clocks until the maximum limit is reached.
>=20
> In order to add that support, let's drop the config flag passed to
> clk_ops->rate_set and handle the asynchronous requests dynamically.
>=20
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

