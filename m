Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC83BBC879
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 15:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441068AbfIXNBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 09:01:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408233AbfIXNBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 09:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=z43OkAB95HOlKNI2nX5uTHQ1xxrOwjBrNrtUqWz6rPc=; b=J3NPHSYyFPp5qKWh7ttErnKOiR
        T9XoDvRCGNis97j6NGlzD1ARzJKefBU1YWVRlG7PTMSrdTKVNCRVQiYhMtcb/CVWBNyiUPG0ea/mX
        98ZOsgWUGEpZ7BcHHRwMgAKfduK0AkM4/p47jeIWlsHmFuj1txmoX4YoATOc0FIhERHLhFzKI2TT9
        TJWYXjObdjVbSef0+4AtAS3vPAchPA80yrO8u4OpbrbqykpjMWdQp/Vrn9IZQdPRlOD3lVkvxsyof
        7yvfA44NYsAtNDmoxBrbfpEYvka8nY9QcoT25Von9Ue93GJ+pjSFkj3+oEk7uSfNO2nyeJO5jzfHm
        O3EJxRjQ==;
Received: from 177.96.206.173.dynamic.adsl.gvt.net.br ([177.96.206.173] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCkRi-0000ul-3S; Tue, 24 Sep 2019 13:01:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.2)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1iCkRf-0001b4-TC; Tue, 24 Sep 2019 10:01:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>, corbet@lwn.net
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] bindings: MAINTAINERS: fix references to Allwinner LRADC
Date:   Tue, 24 Sep 2019 10:01:30 -0300
Message-Id: <65d8ef7ceda713e2c799f7be6b2487d350386711.1569330078.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <b87385b2ac6ce6c75df82062fce2976149bbaa6b.1569330078.git.mchehab+samsung@kernel.org>
References: <b87385b2ac6ce6c75df82062fce2976149bbaa6b.1569330078.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file got converted to yaml, but the reference at MAINTAINERS
was not updated.

Fixes: 5bf2845ece35 ("dt-bindings: input: Convert Allwinner LRADC to a schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 65b7d9a0a44a..4bd3a13f5386 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15527,7 +15527,7 @@ SUN4I LOW RES ADC ATTACHED TABLET KEYS DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	linux-input@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
+F:	Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
 F:	drivers/input/keyboard/sun4i-lradc-keys.c
 
 SUNDANCE NETWORK DRIVER
-- 
2.21.0

