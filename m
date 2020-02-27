Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F93B17160C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 12:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgB0Lbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 06:31:34 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:55900 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728856AbgB0Lbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:31:33 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D704943B60;
        Thu, 27 Feb 2020 11:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1582803093; bh=wDA1AiJunhzsZFcDF4j0BmRmmFKn+Y6/dgk0kHTzJ3E=;
        h=From:To:Cc:Subject:Date:From;
        b=Q9e79+LknaGdmsD1gSD1A+ltfxvaEB4O6XkHM0WV162HxZW/Lx838ViDjm19puHFg
         TBsyaYv7Z99HKIwl7hegGdKeiSxm01Z3zVUXQcLWKSrDsr+oTY2HgqtIi7/AAa2Kou
         RseZKjnzQ2Uo2LRbk1lBqFuQZwqZwtv9YgEJKTyefENP/+Y54CKXn2jzY+o9C5DhVv
         XJc+gjGGSxJtOUrDlVTGlrnzX96vg+3nrzy7b/8NSAIPZyurPNn49XtARL1QbGLYfs
         wOoNOWPEGtV0jiAaRxzdGhAp4bry7qv4J/kHCmeUvfC38rBmeo+RqC4F76LdpmyDAO
         cF08/veeSda8Q==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 77E19A005D;
        Thu, 27 Feb 2020 11:31:26 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 471693E9DF;
        Thu, 27 Feb 2020 12:31:26 +0100 (CET)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     pgaj@cadence.com, bbrezillon@kernel.org,
        linux-i3c@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v2 0/4] i3c: Address i3c_device_id related issues
Date:   Thu, 27 Feb 2020 12:31:05 +0100
Message-Id: <cover.1582796652.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When the I3C subsystem was introduced part of the modalias generation
logic was missing (modalias generation based on i3c_device_id tables).
This patch series addresses that limitation and simplifies our match
function along the way.

Changes in v2:
  Add modalias sysfs attribute
  Fix i3c_entry fields

Boris Brezillon (4):
  i3c: Fix MODALIAS uevents
  i3c: Add modalias sysfs attribute
  i3c: Generate aliases for i3c modules
  i3c: Simplify i3c_device_match_id()

 drivers/i3c/device.c              | 50 +++++++++++++++++----------------------
 drivers/i3c/master.c              | 24 ++++++++++++++++++-
 scripts/mod/devicetable-offsets.c |  7 ++++++
 scripts/mod/file2alias.c          | 19 +++++++++++++++
 4 files changed, 71 insertions(+), 29 deletions(-)

-- 
2.7.4

