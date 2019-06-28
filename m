Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8D459B23
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 14:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfF1Maq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 08:30:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfF1Maj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6/pTZ+xERXtFalv97S9fZEJCCvRhVs0ep0dXd/fG1lc=; b=QPogSYMFgbSZSO2Zlg7G3YFpkQ
        XLUpZtGMd1xag/OzgrdhOY1DGCqk8BpigXSKJkt0f+pV6JRaVlGA/jQqRfJJ/YRFnmbk338wyTDiY
        gL6MYRkyCO3fJX+cz19fAwZjjv4oZoZZPqIMs3BmYb5djNaD1GrQiT/boy55cLgWFJ0xSRh6r8znm
        Gxov7pQibh5IZY+vZq/gH/YrV8PBAp+jNRTzPgCjrmLRtwYrZi1pmXvLAtM6rtm9XMPw1tfKS8uaQ
        p6bAq/r8N8pOy17n70Kdnr2NOjTsg8qcia008CZ+ce8U/2+xANCbNDcfbkiSnJN/KAoWhbxO8kcjl
        hH3gHUYA==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-00055Q-EQ; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005SV-F7; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 20/39] docs: security: move some books to it and update
Date:   Fri, 28 Jun 2019 09:30:13 -0300
Message-Id: <1c99f6df1c199577eb5423045b19663290dcac1d.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following files belong to security:

  Documentation/security/LSM.rst -> Documentation/security/lsm-development.rst
  Documentation/lsm.txt -> Documentation/security/lsm.rst
  Documentation/SAK.txt -> Documentation/security/sak.rst
  Documentation/siphash.txt -> Documentation/security/siphash.rst

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/security/index.rst                        | 5 ++++-
 Documentation/security/{LSM.rst => lsm-development.rst} | 0
 Documentation/{lsm.txt => security/lsm.rst}             | 0
 Documentation/{SAK.txt => security/sak.rst}             | 0
 Documentation/{siphash.txt => security/siphash.rst}     | 0
 Documentation/security/tpm/index.rst                    | 1 +
 Documentation/security/tpm/xen-tpmfront.rst             | 2 --
 7 files changed, 5 insertions(+), 3 deletions(-)
 rename Documentation/security/{LSM.rst => lsm-development.rst} (100%)
 rename Documentation/{lsm.txt => security/lsm.rst} (100%)
 rename Documentation/{SAK.txt => security/sak.rst} (100%)
 rename Documentation/{siphash.txt => security/siphash.rst} (100%)

diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index aad6d92ffe31..fc503dd689a7 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -8,7 +8,10 @@ Security Documentation
    credentials
    IMA-templates
    keys/index
-   LSM
+   lsm
+   lsm-development
+   sak
    SCTP
    self-protection
+   siphash
    tpm/index
diff --git a/Documentation/security/LSM.rst b/Documentation/security/lsm-development.rst
similarity index 100%
rename from Documentation/security/LSM.rst
rename to Documentation/security/lsm-development.rst
diff --git a/Documentation/lsm.txt b/Documentation/security/lsm.rst
similarity index 100%
rename from Documentation/lsm.txt
rename to Documentation/security/lsm.rst
diff --git a/Documentation/SAK.txt b/Documentation/security/sak.rst
similarity index 100%
rename from Documentation/SAK.txt
rename to Documentation/security/sak.rst
diff --git a/Documentation/siphash.txt b/Documentation/security/siphash.rst
similarity index 100%
rename from Documentation/siphash.txt
rename to Documentation/security/siphash.rst
diff --git a/Documentation/security/tpm/index.rst b/Documentation/security/tpm/index.rst
index af77a7bbb070..3296533e54cf 100644
--- a/Documentation/security/tpm/index.rst
+++ b/Documentation/security/tpm/index.rst
@@ -5,3 +5,4 @@ Trusted Platform Module documentation
 .. toctree::
 
    tpm_vtpm_proxy
+   xen-tpmfront
diff --git a/Documentation/security/tpm/xen-tpmfront.rst b/Documentation/security/tpm/xen-tpmfront.rst
index 98a16ab87360..00d5b1db227d 100644
--- a/Documentation/security/tpm/xen-tpmfront.rst
+++ b/Documentation/security/tpm/xen-tpmfront.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ﻿=============================
 Virtual TPM interface for Xen
 =============================
-- 
2.21.0

