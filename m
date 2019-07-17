Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB5E6B2B9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 02:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388951AbfGQAPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 20:15:31 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11572 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbfGQAPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 20:15:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d2e68a80001>; Tue, 16 Jul 2019 17:15:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Jul 2019 17:15:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Jul 2019 17:15:29 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 17 Jul
 2019 00:15:29 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 17 Jul 2019 00:15:29 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d2e68a10000>; Tue, 16 Jul 2019 17:15:29 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 0/3] mm/hmm: fixes for device private page migration
Date:   Tue, 16 Jul 2019 17:14:43 -0700
Message-ID: <20190717001446.12351-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563322536; bh=QsS0ZqN4YggOSSwkzcpaGSaK/G4QRt1uJsrCicwV7Ig=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=leC/Gb3qxcTdl7ZxhD/ykWwGw86krGQRaZO7OGchr2aUxHZbQW/aj6ghYjKJaB2sg
         LN6dtU9KfwqXAhpso+OWUQNKC6cFk18ZRuZIGgr/EGOvWAdmnylyUg58D3H5vjfvGn
         2FAgd6tdTzVwWKB/uTtaEY0+pfsdaMKKJLZgbSedqpka1JJb9zIfa7ooPuLPKnEYyK
         yzYjLrl4H8kwhU3Q3YBZ28rIzMsv3YfeAGBrRijqQu+amFWj7kLzlLhiSc1sgqNkfl
         8GW7bQfebpC8hnNsFLRBGLDCDPTkhXEoXjkMujCpSGkUy+27tEFrSY+YZQY6bLFB1I
         K51ZVi3Q3NZgg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing the latest linux git tree turned up a few bugs with page
migration to and from ZONE_DEVICE private and anonymous pages.
Hopefully it clarifies how ZONE_DEVICE private struct page uses
the same mapping and index fields from the source anonymous page
mapping.

Patch #3 was sent earlier and this is v2 with an updated change log.
http://lkml.kernel.org/r/20190709223556.28908-1-rcampbell@nvidia.com

Ralph Campbell (3):
  mm: document zone device struct page reserved fields
  mm/hmm: fix ZONE_DEVICE anon page mapping reuse
  mm/hmm: Fix bad subpage pointer in try_to_unmap_one

 include/linux/mm_types.h | 9 ++++++++-
 kernel/memremap.c        | 4 ++++
 mm/rmap.c                | 1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

--=20
2.20.1

