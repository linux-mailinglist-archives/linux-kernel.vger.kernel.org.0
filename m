Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F21056AB4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 15:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfFZNgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 09:36:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfFZNgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vjIOKCboXHW6Mjixp79Kk6C1xDXu7gjmz0O9Axsf0MM=; b=PCLh0txTepWivhui/lf1a6LRk
        MlxUkWxltrq9e7vJoBgvuGfdGXgFAF9ignUrfYEus8Xw4F+HunNQ5VqYGauPI6K29f5lV/EmRsA3k
        ColDokfjeEWY2auwVjpTjA/OaIn9OtiSKHeR4SQP+o3EDy2LFjTFooznQcN8A6ZFO+8RSE6xTXZ08
        XvUG+3cu8sBe6e6Fujv+svM7KbZtXVVGXFvphYvBJA/rj+kHkJFsiwlwHTs3XzUFd0Co5ola8Tcny
        h/Ijce5kZ1THb96rBj2dslJIa+spsaN3WVgXnGTfj1XxF6G4VmNcs62MEYOBCb7fWQ8T+P5VXQk+8
        G7GxOP0EA==;
Received: from 177.205.71.220.dynamic.adsl.gvt.net.br ([177.205.71.220] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg85u-0004t1-0v; Wed, 26 Jun 2019 13:36:14 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hg85s-0003Ss-0I; Wed, 26 Jun 2019 10:36:12 -0300
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
Subject: [PATCH] docs: gpu: add msm-crash-dump.rst to the index.rst file
Date:   Wed, 26 Jun 2019 10:36:11 -0300
Message-Id: <e22a340cf94240094cfb38f8c62f6916ea99394a.1561556169.git.mchehab+samsung@kernel.org>
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
 Documentation/gpu/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/gpu/index.rst b/Documentation/gpu/index.rst
index 1fcf8e851e15..55f3f4294686 100644
--- a/Documentation/gpu/index.rst
+++ b/Documentation/gpu/index.rst
@@ -12,6 +12,7 @@ Linux GPU Driver Developer's Guide
    drm-uapi
    drm-client
    drivers
+   msm-crash-dump
    vga-switcheroo
    vgaarbiter
    todo
-- 
2.21.0

