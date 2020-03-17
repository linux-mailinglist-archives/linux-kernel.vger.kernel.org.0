Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC1C81884CF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 14:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgCQNK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 09:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbgCQNK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:10:56 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4DAB20771;
        Tue, 17 Mar 2020 13:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584450656;
        bh=mk8yrQgkQyBugbYLHmm+tFdVac0Y5h97Jl9+snWpEaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRLrwE8NPBGx2fpI5vfgihq7wN49b+3eEzaHFlThlQYHnpR1GQZ2qOJxwBnHBrn7Q
         csbw96IVb8qHenA021C7/cNAe2qWSo6TN9k9u3NbsVbGvuCMUyuA5rq2/XCB5S6UIF
         mcgv9MkW6KxcEAkcNs3VpDQNRnwZD1lNnS/+eWUs=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jEBzh-0006SS-Sy; Tue, 17 Mar 2020 14:10:53 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH 10/12] docs: dt: display/ti: fix typos at the devicetree/ directory name
Date:   Tue, 17 Mar 2020 14:10:49 +0100
Message-Id: <875b824ac97bd76dfe77b6227ff9b6b2671a6abf.1584450500.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584450500.git.mchehab+huawei@kernel.org>
References: <cover.1584450500.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the devicetree directory is wrong on those three
TI bindings:

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml | 2 +-
 Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml | 2 +-
 Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
index cac61a998203..c6598d2e3fa3 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
@@ -65,7 +65,7 @@ properties:
   ports:
     type: object
     description:
-      Ports as described in Documentation/devictree/bindings/graph.txt
+      Ports as described in Documentation/devicetree/bindings/graph.txt
     properties:
       "#address-cells":
         const: 1
diff --git a/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
index ade9b2f513f5..9e19293c0dbc 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
@@ -98,7 +98,7 @@ properties:
   ports:
     type: object
     description:
-      Ports as described in Documentation/devictree/bindings/graph.txt
+      Ports as described in Documentation/devicetree/bindings/graph.txt
     properties:
       "#address-cells":
         const: 1
diff --git a/Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml
index 385bd060ccf9..698f439d839c 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml
@@ -56,7 +56,7 @@ properties:
   port:
     type: object
     description:
-      Port as described in Documentation/devictree/bindings/graph.txt.
+      Port as described in Documentation/devicetree/bindings/graph.txt.
       The DSS DPI output port node
 
   max-memory-bandwidth:
-- 
2.24.1

