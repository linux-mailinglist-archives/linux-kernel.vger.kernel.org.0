Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF5B359B86
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 14:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfF1Mdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 08:33:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39074 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfF1Mah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0aEolBB9p0NRfu6v8+LX19O7Lh4+iqEIQaIwN5pAjCQ=; b=o+Rc+T5A749UHNUXIx8Ef1huFf
        CNZwmFoTIPR7aVP6ISJfnQ9S+0c8cVmA0XV9deU0aCEKwi7UUvrg7bckLpcVJ4+a9IV5prsBpV6Y5
        62PODtxVcBM4S/uQNoYTiTTgKJemkHeGuxgmdnw8fnhKMOXaoKyUxpwT1vi+4YbRh1/AGL29wNdco
        9me4Tntve7pkVYLO0a4TgSkN5fufuyo7e8tknMubgeSBxMtDnoQVZ9XPZanPKxRuLsOu5vKZSOSNF
        xswG0844p0JWj9sWm+tIlCQiFdDcg1YDCd77CCRFti/qgxLlAp2Fn57J81TP4hYMy5+qNZnOrZSH1
        6NVXhuhg==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-000550-3S; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005RT-49; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 07/39] docs: nfc: add it to the driver-api book
Date:   Fri, 28 Jun 2019 09:30:00 -0300
Message-Id: <8a86a20fe20b08bff95861e22b6d26673f5e4952.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the descriptions here are oriented to a Kernel developer.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/driver-api/index.rst               | 1 +
 Documentation/{ => driver-api}/nfc/index.rst     | 2 --
 Documentation/{ => driver-api}/nfc/nfc-hci.rst   | 0
 Documentation/{ => driver-api}/nfc/nfc-pn544.rst | 0
 4 files changed, 1 insertion(+), 2 deletions(-)
 rename Documentation/{ => driver-api}/nfc/index.rst (92%)
 rename Documentation/{ => driver-api}/nfc/nfc-hci.rst (100%)
 rename Documentation/{ => driver-api}/nfc/nfc-pn544.rst (100%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 488c0347fa98..a8b3634287de 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -55,6 +55,7 @@ available subsections can be seen below.
    pinctl
    gpio/index
    misc_devices
+   nfc/index
    dmaengine/index
    slimbus
    soundwire/index
diff --git a/Documentation/nfc/index.rst b/Documentation/driver-api/nfc/index.rst
similarity index 92%
rename from Documentation/nfc/index.rst
rename to Documentation/driver-api/nfc/index.rst
index 4f4947fce80d..3afb2c0c2e3c 100644
--- a/Documentation/nfc/index.rst
+++ b/Documentation/driver-api/nfc/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ========================
 Near Field Communication
 ========================
diff --git a/Documentation/nfc/nfc-hci.rst b/Documentation/driver-api/nfc/nfc-hci.rst
similarity index 100%
rename from Documentation/nfc/nfc-hci.rst
rename to Documentation/driver-api/nfc/nfc-hci.rst
diff --git a/Documentation/nfc/nfc-pn544.rst b/Documentation/driver-api/nfc/nfc-pn544.rst
similarity index 100%
rename from Documentation/nfc/nfc-pn544.rst
rename to Documentation/driver-api/nfc/nfc-pn544.rst
-- 
2.21.0

