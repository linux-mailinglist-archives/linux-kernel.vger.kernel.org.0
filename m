Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49F321325C2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 13:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgAGMMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 07:12:09 -0500
Received: from mail.intenta.de ([178.249.25.132]:31300 "EHLO mail.intenta.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgAGMMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de; s=dkim1;
        h=Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date; bh=yu3PLm+8T3Mx/VSxTyUUuChYt5tKi+SrAfDxJHZn6Zo=;
        b=MqcIzY3KOEIcIueRfXgZuSsZ5LLhY6fyWzgX+YreRLWPeOi0E4hmRug0NktpzfTpRnxpfo5Y0ksOijsyUEm8bEF9ncyMtjmaSkjqjw826kXhGo0SLz3KYhT/txBro+UZN/PFXrNL139CmLSalD9qXLBrLzL8OaKBub5JWKoeTfYLziiOAC5ZnCPWSDKxItml7qYJoURE7TXmpLPHDtot/UDL5W3d2kuuXB/abAkS+M37QU2bZYLGnxfkfhNCV0qOlz6UMYDRxyqfJ5BZLUrXEY4mAEuJBKnno+2ulK+GAfTJHPSKcunZg2m2lU1IovnpzhzA3940Q+4u026Ppc4zrw==;
Date:   Tue, 7 Jan 2020 13:06:15 +0100
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] dt-bindings: mfd: da9062 can be a system power controller
Message-ID: <20200107120613.GA746@laureti-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ICSMA002.intenta.de (10.10.16.48) To ICSMA002.intenta.de
 (10.10.16.48)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DA9062 can be used to power off a system if it is appropriately
wired.

Signed-off-by: Helmut Grohne <helmut.grohne@intenta.de>
---
 Documentation/devicetree/bindings/mfd/da9062.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
index bc4b59de6a55..4b53a5b7147a 100644
--- a/Documentation/devicetree/bindings/mfd/da9062.txt
+++ b/Documentation/devicetree/bindings/mfd/da9062.txt
@@ -38,6 +38,10 @@ Required properties:
 See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt for
 further information on IRQ bindings.
 
+Optional properties:
+
+- system-power-controller
+
 Sub-nodes:
 
 - regulators : This node defines the settings for the LDOs and BUCKs.
-- 
2.20.1

