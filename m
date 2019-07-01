Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 902E22E936
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 01:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfE2XZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 19:25:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49170 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfE2XYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=101NUubdgdQ5XTreIrPkh1wQNPvLvYeTkirlA9vazw4=; b=cKuo/zXENJygACfL65gsogn05p
        6dIGhbpUvFYawarAVSJsma9Vw6fOxOHyu/mwvi/d2ZVecEoeeaXAA68FOLsQFeeOV7XdYvxNjX0mG
        cJWjhDNATPJktdkHX7JOxE9x+5obzsy0G37bhR67isEeziusXUCWAsMW5xJYOvnmCWIKtX3YX0nFG
        +uOIVLVbZWtqA5XFmDCrA2mzsR0DEPFuIK2HxD5Su9WXdseaROor5JXldCnoQ27RF6+oYgEbM4+vl
        jYF/RlcmyGsWvbMuxWI9Yeqrfic+T2ivdtVfxO8KlfDTkuM+xWP7oK+BX2V1mKaeooKXxyw+SEx0m
        nK53Q09w==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7vL-0005Rq-9i; Wed, 29 May 2019 23:23:59 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7vI-0007xU-Pz; Wed, 29 May 2019 20:23:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 12/22] gpu: i915.rst: Fix references to renamed files
Date:   Wed, 29 May 2019 20:23:43 -0300
Message-Id: <5ecde05364284f6845b651297fd9ce8225af2bcd.1559171394.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559171394.git.mchehab+samsung@kernel.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -function Hardware workarounds ./drivers/gpu/drm/i915/intel_workarounds.c' failed with return code 1
WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -function Logical Rings, Logical Ring Contexts and Execlists ./drivers/gpu/drm/i915/intel_lrc.c' failed with return code 1
WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/intel_lrc.c' failed with return code 2

Fixes: 112ed2d31a46 ("drm/i915: Move GraphicsTechnology files under gt/")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/gpu/i915.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index 055df45596c1..38fefeb99bba 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -61,7 +61,7 @@ Intel GVT-g Host Support(vGPU device model)
 Workarounds
 -----------
 
-.. kernel-doc:: drivers/gpu/drm/i915/intel_workarounds.c
+.. kernel-doc:: drivers/gpu/drm/i915/gt/selftest_workarounds.c
    :doc: Hardware workarounds
 
 Display Hardware Handling
@@ -379,10 +379,10 @@ User Batchbuffer Execution
 Logical Rings, Logical Ring Contexts and Execlists
 --------------------------------------------------
 
-.. kernel-doc:: drivers/gpu/drm/i915/intel_lrc.c
+.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_lrc.c
    :doc: Logical Rings, Logical Ring Contexts and Execlists
 
-.. kernel-doc:: drivers/gpu/drm/i915/intel_lrc.c
+.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_lrc.c
    :internal:
 
 Global GTT views
-- 
2.21.0

