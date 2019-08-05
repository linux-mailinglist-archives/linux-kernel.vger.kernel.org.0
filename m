Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D678105B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 04:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfHECvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Aug 2019 22:51:48 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46853 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726757AbfHECvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 22:51:48 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0083CA41;
        Sun,  4 Aug 2019 22:51:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 04 Aug 2019 22:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=i0qal0AGEr2Bges+vL14pUAf+z
        DcRqtDacbfO105sJc=; b=Y9oOz+cTp1dT+y9k89c0uF6jS0yIndtfJNF1u4HoLQ
        KyubJDrvyoRf68NY+GsS6W7kgAUl6O9VmVHuRcXU4ah5Sl8//gs1nlI12eGbCRZv
        BVeK6/xOvqNz6qB0N12dE0RWrCcYY163qCA6iIIM4K7r2CRKqx6t9CXhMMwheBQy
        chtRDWXY+yyT7Q79f9UMOf50J1nIdlsCd95f589YfsUh9x0a9yHK3nsPfTxh07Sl
        p44fD3I40yEut/wU4v3qiI4pHd3liTwupUyXoCqW4Ur1Ek9grqwpSpB9DxCKDyP2
        nC4SG4OHqEooCSlNIre/04iNdo+uIposhTSCRJ+prRbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=i0qal0AGEr2Bges+v
        L14pUAf+zDcRqtDacbfO105sJc=; b=IAYIFF98qPYkFbby2SbF3OR5KLzHzOewm
        gOwkeahS2KdwI2dFHuqStcqzrR9qux+C+8wXustFgY9PaUmDiZY5G2TxmEsgMgS1
        j97E14jv24n4cV+ppLVlGswNf3XjXpyROCgnvXZdQWyrdbzSM6VhWarWyhvhTLqg
        lDX8JBcssJ/IybNKuNB+53Z92fPzNivtTCeqverl3FS+adHiE9PvfcmqkfsKv9PF
        Vg8twHoTEAlj4zjm7AfFV6DLVGqrLU8+uIYzyV4Rol7UIXGgXlKnJxs0DIl5b/6V
        jHL/gpU8fs3bsLL7Xi6C21MF99mPcATvoFMBgvzXQQNyg2ChDozIg==
X-ME-Sender: <xms:wZlHXXD0suC-nz7sWbzArC6Mypbq4If5EatWrrD9Kgm_ePEvZrBD8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddtiedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
    ihgurdgruheqnecuffhomhgrihhnpehoiihlrggsshdrohhrghenucfkphepuddukedrvd
    dutddrudegfedruddvheenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegr
    jhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:wZlHXQ345z92tZP1ACqP10TCE9ZpcEwwp-7h4R9lNu4cwEpdY5sIkg>
    <xmx:wZlHXeY5LoeDNbXS05AywJ3Z0HnfcMwSB-xO4Z32R0MrKipPVjYBtg>
    <xmx:wZlHXc_08vgXDATORorRjBu-vlNoNjMn488L9EhWF9TC7baXsMB05Q>
    <xmx:wplHXftMESaP-1jQepQHnAik1vm9r-oKrmGZgGO9HtuKWPmb1PlLKw>
Received: from localhost.localdomain (ppp118-210-143-125.adl-adc-lon-bras33.tpg.internode.on.net [118.210.143.125])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2EE18380084;
        Sun,  4 Aug 2019 22:51:40 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        adrian.hunter@intel.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ryanchen.aspeed@gmail.com
Subject: [PATCH v4 0/2] mmc: Add support for the ASPEED SD controller
Date:   Mon,  5 Aug 2019 12:21:53 +0930
Message-Id: <20190805025155.9020-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

v4 of the ASPEED SDHCI driver addresses Rob's comments on the binding, making
it utilise the new mmc-controller schema and describing the sdhci,auto-cmd12
property.

v3 can be found here:

http://patchwork.ozlabs.org/cover/1138793/

Please review!

Andrew

Andrew Jeffery (2):
  dt-bindings: mmc: Document Aspeed SD controller
  mmc: Add support for the ASPEED SD controller

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 105 ++++++
 drivers/mmc/host/Kconfig                      |  12 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-aspeed.c            | 328 ++++++++++++++++++
 4 files changed, 446 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-aspeed.c

-- 
2.20.1

