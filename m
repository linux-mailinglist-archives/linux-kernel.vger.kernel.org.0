Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83CAC216F2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 12:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfEQKeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 06:34:04 -0400
Received: from gloria.sntech.de ([185.11.138.130]:60778 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbfEQKeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 06:34:04 -0400
Received: from we0524.dip.tu-dresden.de ([141.76.178.12] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hRaBc-0001Qh-LY; Fri, 17 May 2019 12:34:00 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ezequiel@collabora.com, tom@vamrs.com, dev@vamrs.com
Subject: Re: [PATCH v2 1/2] arm64: dts: rockchip: Enable SPI0 and SPI4 on Rock960
Date:   Fri, 17 May 2019 12:33:59 +0200
Message-ID: <2079428.WrHPkSWNQI@phil>
In-Reply-To: <20190517040625.14607-1-manivannan.sadhasivam@linaro.org>
References: <20190517040625.14607-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 17. Mai 2019, 06:06:24 CEST schrieb Manivannan Sadhasivam:
> Enable SPI0 and SPI4 exposed on the Low and High speed expansion
> connectors of Rock960.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

applied both patches for 5.3

Thanks
Heiko


