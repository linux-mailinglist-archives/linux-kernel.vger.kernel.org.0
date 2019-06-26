Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91A7756E5E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 18:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfFZQJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 12:09:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57706 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZQJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gCTAps/lYoSk9lPt+qf517YJddtp5CleOCu5z7O8PhY=; b=Nf/H1sdFoSNlSGwY2S6sd4HVQ
        nmeKZ3Z/tecPr3cXWRdyRA8+fl0gJKFC33IUlNN1M0Udy2sZann0YYMW4Piy+St/Tx1zLsS58sc6M
        F7L78si7kGv5NeOBGl0cV4Jah94hDY/MlnfgI6s42ZnuAVu3UhmYWpEwepAP3NKlF2noMIlDD/Lu6
        9g21Ncqgi6b+fSmQOacDqSEYJ7z0DANeQ44bl6essqwqCrrlRfEWdk39koNTa5K/Wu7AQA1AsYtpv
        wDupzG57mzknnSHdqVVa1WC0E72OtZMYIUZ4PGhH+/3QNdPdTfn6pcqtKiy83iSwUWTJ53p5hdLGC
        Hsl9WcoQQ==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgAUU-0002Um-Vg; Wed, 26 Jun 2019 16:09:46 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgAUR-00083F-FM; Wed, 26 Jun 2019 13:09:43 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org
Subject: [PATCH v2] docs: gpu: add msm-crash-dump.rst to the index.rst file
Date:   Wed, 26 Jun 2019 13:09:42 -0300
Message-Id: <f6cc8cf99067d44b0a43c2b7cfbee273e8cc974b.1561565379.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file is currently orphaned.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/gpu/drivers.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/gpu/drivers.rst b/Documentation/gpu/drivers.rst
index 4bfb7068e9f7..6c88c57b90cf 100644
--- a/Documentation/gpu/drivers.rst
+++ b/Documentation/gpu/drivers.rst
@@ -20,6 +20,7 @@ GPU Driver Documentation
    xen-front
    afbc
    komeda-kms
+   msm-crash-dump
 
 .. only::  subproject and html
 
-- 
2.21.0

