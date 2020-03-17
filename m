Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11D3B1884F6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 14:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgCQNLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 09:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgCQNK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:10:56 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACE172076C;
        Tue, 17 Mar 2020 13:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584450655;
        bh=TwNQje5NiXBQuCZC9dL451ir+wqT2jRS4iXukxlPVxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ifjyG/dAdE4YmWlSU6Hel+A5cD5MZJK+I9EoO1qVVRLoO/ZcuYDnHgb5EUxj/7L8r
         Ra7WzXDUh2lq2gLRly2qsY1Z8O9wBLAcrbhJzSqKqPp3i+4eGDcOG5XUwQEcQexNUd
         xt4DYAf2fxolxwz8gVx7jKYTZRPaMWh9gBFPkRDc=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jEBzh-0006SF-Ni; Tue, 17 Mar 2020 14:10:53 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yuti Amonkar <yamonkar@cadence.com>, devicetree@vger.kernel.org
Subject: [PATCH 07/12] docs: dt: fix broken reference to phy-cadence-torrent.yaml
Date:   Tue, 17 Mar 2020 14:10:46 +0100
Message-Id: <afff684f552c7f3855439da3a0bb30ec5592c682.1584450500.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584450500.git.mchehab+huawei@kernel.org>
References: <cover.1584450500.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file was removed, and another file was added instead of
it, on two separate commits.

Splitting a single logical change (doc conversion) on two
patches is a bad thing, as it makes harder to discover what
crap happened.

Anyway, this patch fixes the broken reference, making it
pointing to the new location of the file.

Fixes: 922003733d42 ("dt-bindings: phy: Remove Cadence MHDP PHY dt binding")
Fixes: c6d8eef38b7f ("dt-bindings: phy: Add Cadence MHDP PHY bindings in YAML format.")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
index 452cee1aed32..072efe675203 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -146,7 +146,7 @@ patternProperties:
       bindings specified in
       Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
       Torrent SERDES should follow the bindings specified in
-      Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
+      Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
 
 required:
   - compatible
-- 
2.24.1

