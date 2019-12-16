Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8119311FCCE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 03:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfLPC0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 21:26:20 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:51031 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbfLPC0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 21:26:20 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7C7466A76;
        Sun, 15 Dec 2019 21:26:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 15 Dec 2019 21:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=HY55BCVsizFE8+s5E5ZBDonzCD
        FgxVsezznsO8iULcc=; b=W+Xc8tt9dsunJkPbmapfHbyXyhB2inF4eWJeuWOiJK
        dZFSGVbwBCmANEChYj5alB/hZdOX4dUzeEFoCulR6wEvurJgyZnG7gZ4hNMEJw7O
        ML17QLvkLC8b1VkW88Ipi5wwQheF9It0JizgRIcmNe6xAn+l5cUssEEANiFtuwsV
        CJMOWeSHjGe59br2dondIo7k0FNNQwvLz17UxCeGipUeLYqTuZJaf6evkummXk1C
        M0MXvjoK2fRv5CRh3jooRUgParRsQ4TBaqHk96kIve28gcLA3ujO0nDUMfq3mPgB
        Dvy42fejruxyv4bE/7AICUJOBgMp8gi9zPsEKcE+8Xcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=HY55BCVsizFE8+s5E
        5ZBDonzCDFgxVsezznsO8iULcc=; b=tNboqBN9XCn19Xbkqh8Z5zg0fVHL8mEOg
        QHIpglvdl8mFrMseerat/B+VBgkasl6ht6HkflO7N2rmBPz55RuJPFDiKTSbDdzA
        gKBt/CD9Zib6C82j4ZeZYo97BoCG/Inus+mgEzOvpT004NtkevpDVGCobqdR1Xbu
        BN9wZfo6df4ZpUSNUkuc0Kj+mwCLhfSTrx6a8XjNepX+ZXQ+XNc/SVPQsEPB6WnY
        Qia1/0zSo37dOLsUlH25G4Tk8u6DXAtYYD6x7RFpmp8LuBTBEpPWBLV35p+Gefud
        ToUfeAu+a2FvEd074k17YVQx1KvnuZY8fTUALi5I7aponf3KnD9AQ==
X-ME-Sender: <xms:Sev2XXu6NPaW4uIIrHyI8tUYiHz8u1LPn_e95Knw_XJUqNoFNSjJfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtgedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
    ihgurdgruheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtvddrke
    durddukedrfedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhi
    ugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:Sev2XUvprDZT1Kq-4QFhUz7J7QSFqx5SeRu6mf3Ueu-0YukI-wVLCQ>
    <xmx:Sev2XUY_RdiEA_vgeARq788LRe5KrHlkxMNehsCziEbPKzxR1q3XNA>
    <xmx:Sev2XWgG_MdkKBkDd5017W2E62NgbqFMzgBzJ959uBNJ9StiVF3nDQ>
    <xmx:Suv2XUE0TtfxRlHxN7DSR5sC2uBzlN6uKISs_F3LqXqWglTBfKeGDg>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id EDC798005A;
        Sun, 15 Dec 2019 21:26:12 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     openipmi-developer@lists.sourceforge.net
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        haiyue.wang@linux.intel.com, minyard@acm.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, robh+dt@kernel.org, joel@jms.id.au,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/3] ipmi: kcs-bmc: Rework bindings to clean up DT warnings
Date:   Mon, 16 Dec 2019 12:57:39 +1030
Message-Id: <cover.fe20dfec1a7c91771c6bb574814ffb4bb49e2136.1576462051.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a short series reworking the devicetree binding and driver for the
ASPEED BMC KCS devices. With the number of supported ASPEED BMC devicetrees the
changes enable removal of more than 100 lines of warning output from dtc.

v1 can be found here:

https://lore.kernel.org/lkml/cover.5630f63168ad5cddf02e9796106f8e086c196907.1575376664.git-series.andrew@aj.id.au/

v2 cleans up the commit message of 2/3 and changes the name of the property
governing the LPC IO address for the KCS devices.

Cheers,

Andrew

Andrew Jeffery (3):
  dt-bindings: ipmi: aspeed: Introduce a v2 binding for KCS
  ipmi: kcs: Finish configuring ASPEED KCS device before enable
  ipmi: kcs: aspeed: Implement v2 bindings

 Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt |  20 +-
 drivers/char/ipmi/kcs_bmc_aspeed.c                        | 151 +++++--
 2 files changed, 139 insertions(+), 32 deletions(-)

base-commit: 937d6eefc716a9071f0e3bada19200de1bb9d048
-- 
git-series 0.9.1
