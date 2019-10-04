Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0989DCC416
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 22:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbfJDUSX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Oct 2019 16:18:23 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37538 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbfJDUSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:18:22 -0400
Received: from 94.112.246.102.static.b2b.upcbusiness.cz ([94.112.246.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iGU1o-0006Z3-VO; Fri, 04 Oct 2019 22:18:17 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Soeren Moch <smoch@web.de>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: fix RockPro64 sdmmc =?UTF-8?B?c2V0dGluZ3PjgJDor7fms6jmhI/vvIzpgq7ku7bnlLFsaW51eC1yb2NrY2hpcC1ib3VuY2VzK3NoYXduLmxpbj1yb2NrLWNoaXBzLmNvbUBsaXN0cy5pbmZyYWRlYWQub3Jn5Luj5Y+R44CR?=
Date:   Fri, 04 Oct 2019 22:18:16 +0200
Message-ID: <2162187.GalWoky0CO@phil>
In-Reply-To: <c180ec58-083b-5730-a188-58eb6100b7b6@web.de>
References: <20191003215036.15023-1-smoch@web.de> <e4aaddc2-441b-b835-380e-374a3d935474@web.de> <c180ec58-083b-5730-a188-58eb6100b7b6@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sören,

Am Freitag, 4. Oktober 2019, 22:15:45 CEST schrieb Soeren Moch:
> Heiko,
> 
> since you started to apply the first 2 Patches of this series (thanks
> for that!), now after all the discussions here (and the heads-up for the
> implemented mode detection) I think we should leave the vcc_sdio
> regulator settings unmodified.

I was composing a mail about me holding off on this patch due to the
ongoing discussion when your mail came ;-)

> It still could make sense to remove the cap-mmc-highspeed property. Are
> you OK with a V2 patch for that?

Sure, go ahead.

Heiko



