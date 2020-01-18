Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C405141A4F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jan 2020 00:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgARXBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 18:01:16 -0500
Received: from gloria.sntech.de ([185.11.138.130]:40726 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbgARXBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 18:01:15 -0500
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1isx5Z-0007IA-RU; Sun, 19 Jan 2020 00:01:09 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: rockchip: rename dwmmc node names to mmc
Date:   Sun, 19 Jan 2020 00:01:09 +0100
Message-ID: <4658509.s4iD4QMAIY@phil>
In-Reply-To: <20200115185244.18149-1-jbx6244@gmail.com>
References: <20200115185244.18149-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 15. Januar 2020, 19:52:43 CET schrieb Johan Jonker:
> Current dts files with 'dwmmc' nodes are manually verified.
> In order to automate this process rockchip-dw-mshc.txt
> has to be converted to yaml. In the new setup
> rockchip-dw-mshc.yaml will inherit properties from
> mmc-controller.yaml and synopsys-dw-mshc-common.yaml.
> 'dwmmc' will no longer be a valid name for a node,
> so change them all to 'mmc'
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied both for maybe still 5.6

Thanks
Heiko


