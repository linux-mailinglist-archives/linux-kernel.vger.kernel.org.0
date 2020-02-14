Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1770815F661
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 20:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387885AbgBNTIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 14:08:10 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57648 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbgBNTIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:08:09 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01EJ89Id052271
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 13:08:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581707289;
        bh=9nwhCH3qcQ27Kne3iBugcMNWoa9ffDAZFX40uUjU1ss=;
        h=From:To:CC:Subject:Date;
        b=wJazlmx3O92wsQsxHOnNa6LI9gI8aBU+lzKxKJDQggVjGT7mHGl/bvHLH7r6G838p
         cwKuo67liK3mYRFoNdKDiyapNUy8/jvhaQfQPqERYUUPy1V72L3eUPLyB6A14A3TRd
         S8B4+gkIalXigDiHFWGjjw7aW3Ax1OaJQ9gI0Rb4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01EJ88Kk123031
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 13:08:08 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 14
 Feb 2020 13:08:08 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 14 Feb 2020 13:08:08 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01EJ87a7050798;
        Fri, 14 Feb 2020 13:08:08 -0600
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 0/2] phy: ti: gmii-sel: two fixes
Date:   Fri, 14 Feb 2020 21:07:59 +0200
Message-ID: <20200214190801.3030-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

Here the two minor fixes for TI phy-gmii-sel PHY.
 - Patch 1: few minor copy-paste errors.
 - Patch 2: enables back gmii mode (not used now, so no issues reported til now)

Grygorii Strashko (2):
  phy: ti: gmii-sel: fix set of copy-paste errors
  phy: ti: gmii-sel: do not fail in case of gmii

 drivers/phy/ti/phy-gmii-sel.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.17.1

