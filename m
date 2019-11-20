Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1B25104249
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 18:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfKTRl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 12:41:56 -0500
Received: from muru.com ([72.249.23.125]:43074 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfKTRl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:41:56 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8AC54811B;
        Wed, 20 Nov 2019 17:42:32 +0000 (UTC)
Date:   Wed, 20 Nov 2019 09:41:52 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, bcousson@baylibre.com, robertcnelson@gmail.com
Subject: Re: [PATCH] ARM: dts: am57xx-beagle-x15: Update pinmux name to
 ddr_3_3v
Message-ID: <20191120174152.GT35479@atomide.com>
References: <20191118111654.9843-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118111654.9843-1-faiz_abbas@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [191118 03:16]:
> am57xx-beagle-x15 revb1 and revc have 3.3V connected to the eMMC I/O
> lines. Update the pinmux name to reflect this.

Thanks applying into omap-for-v5.5/dt.

Tony
