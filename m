Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6E251309AA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jan 2020 20:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgAETqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jan 2020 14:46:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgAETqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 14:46:51 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52B8A206E6;
        Sun,  5 Jan 2020 19:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578253610;
        bh=2qzC2UMI2DIxIBRnPl5K9OcJa0SeoY/dfiK9tSsqfdE=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=AGOf4Vmz9GJc4lYsYQ/Z/o6wpzbxi/IJLhVTqvmTgq16nxRHSJw4t8nPCvD/jQEgR
         uSy8Jx1jqyZgO4xLa7M3G4lwRtRXo6+y0MX/QOCKkWVy6Dt+C7pV9GSZbeycVxoqSR
         gaskqhV9OuCbxr0K0XGW0HopVi+9cKrtexEzfgMk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a0880cfbbcc729171a37e2a3bc27680efb06e398.1574922435.git.shubhrajyoti.datta@xilinx.com>
References: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com> <a0880cfbbcc729171a37e2a3bc27680efb06e398.1574922435.git.shubhrajyoti.datta@xilinx.com>
Cc:     gregkh@linuxfoundation.org, mturquette@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        soren.brinkmann@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     devel@driverdev.osuosl.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, shubhrajyoti.datta@gmail.com
Subject: Re: [PATCH v3 10/10] clk: clock-wizard: Fix the compilation failure
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sun, 05 Jan 2020 11:46:49 -0800
Message-Id: <20200105194650.52B8A206E6@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting shubhrajyoti.datta@gmail.com (2019-11-27 22:36:17)
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>=20
> After 90b6c5c73 (clk: Remove CLK_IS_BASIC clk flag)
> The CLK_IS_BASIC is deleted. Adapt the driver for the same.

I don't see any CLK_IS_BASIC in the tree right now, so did it get
reintroduced by this patch series? Can you squash this into whatever
patch introduces CLK_IS_BASIC usage?

