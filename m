Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67EE3190BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 12:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgCXLA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 07:00:57 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50340 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbgCXLA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:00:57 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02OB0tFH081711;
        Tue, 24 Mar 2020 06:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585047655;
        bh=PZiIDKvlZ8YWgOUnB0MYx/H5CXsMSyveAKNZNO9jwTA=;
        h=From:To:CC:Subject:Date;
        b=yd1Va8tQ6XJxh7Wy6KASp1yLw1ztO6S8fXtKW/zGBzrhOZJYSSilrq56lP/KtTtHg
         JUCCukDYdl9okHG7atJPd5p4b+W0dyolFffbsPoQBJ7MV8FgzKRzQYiSWhqCZJKFXp
         U4rKM2pcIQyp/BhNUVprWczcpzaDnz/FOxbk2d+Y=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02OB0tS0108822;
        Tue, 24 Mar 2020 06:00:55 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 24
 Mar 2020 06:00:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 24 Mar 2020 06:00:55 -0500
Received: from sokoban.bb.dnainternet.fi (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02OB0rAk008648;
        Tue, 24 Mar 2020 06:00:53 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>,
        <linux-remoteproc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mathieu.poirier@linaro.org>,
        <s-anna@ti.com>, <afd@ti.com>
Subject: [PATCHv9 00/15] remoteproc: updates for omap remoteproc support
Date:   Tue, 24 Mar 2020 13:00:20 +0200
Message-ID: <20200324110035.29907-1-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v9 is just a rebase on top of rproc-next (I am optimistic here still
assuming that maintainers would pick this up for 5.7), and fixing one
final comment from Mathieu on patch #14. Rebase on top of rproc-next
causes a couple of minor changes to fix compile breakages compared to v8
of this series (some APIs have changed slightly, see patch #3, #5 and #7.)

-Tero


--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
