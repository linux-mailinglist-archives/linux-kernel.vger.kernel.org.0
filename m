Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69BF6DC3B4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 13:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409956AbfJRLLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 07:11:38 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:58120 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409922AbfJRLLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 07:11:36 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 77C90C038C;
        Fri, 18 Oct 2019 11:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571397096; bh=e8yggv0btZRuFr6l3qUhzUGs2B07uTUAhsF6E9pwFQ0=;
        h=From:To:Cc:Subject:Date:From;
        b=JAfzKRqJN/knBHIhtODeGolVsw1cKqnMa1YJSUxdFInIDBEhcjf2RnOv3fPheaafQ
         104PIuQEajrdUI4Ubn2r10ogn+aNYlNbCqbTX3aEVflgU/lqwcs5rhk9pGIvM+by3J
         6wcEi7pao5nwpINOCkjQJNfjn2eew+f3yCgwRRjLV/HvQCxoX579aNdElExrV4ReTk
         NJmxVcAQbpx9tHMHl2JSuSO1F/AnL6BZdlJmVY5dhQpp4FVcWt1RyUh+nVel35VdeI
         qn4zRKRuHQjm3JeZrhmwC3vJ5DiEFVokTf88garIOFubFPfPwdM6H5FxC+mQdqkQXx
         4ca00S6sIV5lA==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id EAF6AA005C;
        Fri, 18 Oct 2019 11:11:28 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 0/2] ARC: [plat-hsdk]: enable on-board SPI peripherals
Date:   Fri, 18 Oct 2019 14:11:24 +0300
Message-Id: <20191018111126.5246-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HSDK board has SPI flash IC and SPI ADC IC. As all SPI-related
blocking changes/fixes are finally applied we can enable them.

Eugeniy Paltsev (2):
  ARC: [plat-hsdk]: Enable on-board SPI NOR flash IC
  ARC: [plat-hsdk]: Enable on-boardi SPI ADC IC

 arch/arc/boot/dts/hsdk.dts      | 23 +++++++++++++++++++++++
 arch/arc/configs/hsdk_defconfig |  6 ++++++
 2 files changed, 29 insertions(+)

-- 
2.21.0

