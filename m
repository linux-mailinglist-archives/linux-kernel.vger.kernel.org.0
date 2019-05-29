Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8A2D2E8FD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 01:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfE2XYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 19:24:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfE2XYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=seXeb75OKv0MSbPUJnbqhrRx7j2bM0Rtx83TOff+P2A=; b=Yeb9ALjiDrJ2ntYw5ga3E6+tli
        OMTK2A3HyHnHqn0hTVbhfhwLbANaOml46BH/EEqJ3GANruwXTmGqfSlaOaNGU5y51d55PlniD+U6m
        M0c5eTDsy58l7WhFozsuqHvyr0xHO75Sk99/V8tkwK8lA/a1ig0fDaZTA4vVCsuHuplGZZkGUvG7K
        UmnxPgN+VWZnL8PHbB3qNzPKJdNeXHjG8h7xZ9hRSselkAA3VMU9xeCvgmczisdXgO1rdQZf16RqJ
        VywTWx4eiCad+BWWOmtco8UEKGgcpZFRfWZVG4rlaCZ1okoVaUdpkq5V3V3OBhYGTlOBqRxtL2YTJ
        /Q4x+90w==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7vL-0005Rd-26; Wed, 29 May 2019 23:23:59 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7vI-0007x6-L0; Wed, 29 May 2019 20:23:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alessia Mantegazza <amantegazza@vaga.pv.it>
Subject: [PATCH 06/22] doc: it_IT: fix reference to magic-number.rst
Date:   Wed, 29 May 2019 20:23:37 -0300
Message-Id: <76713fe801e082e54e4412331d14495f2620ee59.1559171394.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559171394.git.mchehab+samsung@kernel.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a typo at the referred file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/translations/it_IT/process/magic-number.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Documentation/translations/it_IT/process/magic-number.rst
index 5281d53e57ee..ed1121d0ba84 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/magic-numbers.rst <magicnumbers>`
+:Original: :ref:`Documentation/process/magic-number.rst <magicnumbers>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_magicnumbers:
-- 
2.21.0

