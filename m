Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7680F19450E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 18:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgCZRHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 13:07:30 -0400
Received: from muru.com ([72.249.23.125]:33262 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgCZRH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:07:29 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3E2EF8102;
        Thu, 26 Mar 2020 17:08:16 +0000 (UTC)
Date:   Thu, 26 Mar 2020 10:07:26 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: DTS: OMAP3: disable RNG on N950/N9
Message-ID: <20200326170726.GE37466@atomide.com>
References: <20200325212149.27547-1-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325212149.27547-1-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [200325 14:22]:
> Like on N900, we cannot access RNG directly on N950/N9. Mark it disabled in
> the DTS to allow kernel to boot.
>
> Fixes: 308607e5545f ("ARM: dts: Configure omap3 rng")

Oops sorry looks like I missed that one. Applying into fixes.

Thanks,

Tony
