Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00703188835
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 15:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCQOyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 10:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgCQOyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:54:32 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D29092077A;
        Tue, 17 Mar 2020 14:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584456871;
        bh=iuxHZUHgV1Ve8453hRLoOALmDPKLOUsSVmgcVeZhw4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=utq+Q3tRhWIkQyERasQeahiB9WO1fD1N3jDhBmZw8vHCGCZr9EeXl2wkAC90UicVd
         sL/eK1FM427PeiyYdoW8QxxHxToCKILBVET+uaXnc2EoXxnvCfgg4Rs/Crh7FTtz9+
         L5mudHqkjoxdWDLSqAltjVWokw0LRfVJDXLsanuY=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jEDbw-000ANJ-U6; Tue, 17 Mar 2020 15:54:28 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Subject: [PATCH 15/17] ata: libata-core: fix a doc warning
Date:   Tue, 17 Mar 2020 15:54:24 +0100
Message-Id: <af7858d43dc600c780c39e4daa79e92e7d3858ec.1584456635.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584456635.git.mchehab+huawei@kernel.org>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The docs toolchain doesn't recognise this pattern:

	@link->[hw_]sata_spd_limit

As it can't really process it. So, instead, let's mark it with
a literal block markup:

	``link->[hw_]sata_spd_limit``

in order to get rid of the following warning:

	./drivers/ata/libata-core.c:5974: WARNING: Unknown target name: "hw".

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 175b2a9dc000..ae0230740474 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5975,7 +5975,7 @@ void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp)
  *	sata_link_init_spd - Initialize link->sata_spd_limit
  *	@link: Link to configure sata_spd_limit for
  *
- *	Initialize @link->[hw_]sata_spd_limit to the currently
+ *	Initialize ``link->[hw_]sata_spd_limit`` to the currently
  *	configured value.
  *
  *	LOCKING:
-- 
2.24.1

