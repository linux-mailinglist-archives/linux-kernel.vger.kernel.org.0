Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B914180548
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 18:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCJRrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 13:47:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgCJRrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:47:13 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDEC320727;
        Tue, 10 Mar 2020 17:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583862432;
        bh=Oh9ZvT4Bvl8uZds2f5cLSdbfHTOwhbdXpqse6mjFJ8A=;
        h=From:To:Cc:Subject:Date:From;
        b=nqX5P860kUst2mq+YE/8D+trqHK9MpxmtbDRBdlzzFY4I5MkI3QoiUu/T2WdWHAfr
         dei9VWzgsIc6vPDp+YkvTMgixX5B2wy4AJ6Ne9vS676l14agqOGeZDwM8+LeeMmPoC
         y92YWqKfDtGo8NqqZjgQYrfAP5NNR2cxtN7JCq3g=
Received: by wens.tw (Postfix, from userid 1000)
        id 031656045B; Wed, 11 Mar 2020 01:47:09 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ARM: dts: sun8i: r40: fix SPI address and reorder nodes
Date:   Wed, 11 Mar 2020 01:47:06 +0800
Message-Id: <20200310174709.24174-1-wens@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Hi,

Here are some fixes for the R40 device tree for v5.6. The base addresses
for SPI2 and SPI3 were incorrect and are fixed. I also found some nodes
were not added in the proper order, possibly because git matched the
incorrect place when applying the patch. These are fixed as well.

ChenYu

Chen-Yu Tsai (3):
  ARM: dts: sun8i: r40: Move AHCI device node based on address order
  ARM: dts: sun8i: r40: Fix register base address for SPI2 and SPI3
  ARM: dts: sun8i: r40: Move SPI device nodes based on address order

 arch/arm/boot/dts/sun8i-r40.dtsi | 126 +++++++++++++++----------------
 1 file changed, 63 insertions(+), 63 deletions(-)

-- 
2.25.1

