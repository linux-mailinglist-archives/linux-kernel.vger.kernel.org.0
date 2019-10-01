Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33468C3EEC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 19:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbfJARrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 13:47:03 -0400
Received: from ms.lwn.net ([45.79.88.28]:38456 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfJARrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:47:03 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 73359316;
        Tue,  1 Oct 2019 17:47:02 +0000 (UTC)
Date:   Tue, 1 Oct 2019 11:47:01 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: [PATCH] docs/driver-api: Catch up with dma_buf file-name changes
Message-ID: <20191001114701.7349d9ec@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/dma_buf/reservation.c was renamed to dma-resv.c (and
include/linux/reservation.h to dma-resv.h), but the documentation was not
updated to match, leading to these build errors:

  Error: Cannot open file ./drivers/dma-buf/reservation.c
  Error: Cannot open file ./drivers/dma-buf/reservation.c
  Error: Cannot open file ./drivers/dma-buf/reservation.c
  Error: Cannot open file ./include/linux/reservation.h
  Error: Cannot open file ./include/linux/reservation.h

Update the documentation and make the world happy again.

Fixes: 52791eeec1d9 ("dma-buf: rename reservation_object to dma_resv')
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
[I'll carry this in docs-next unless somebody objects.]

 Documentation/driver-api/dma-buf.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
index b541e97c7ab1..c78db28519f7 100644
--- a/Documentation/driver-api/dma-buf.rst
+++ b/Documentation/driver-api/dma-buf.rst
@@ -118,13 +118,13 @@ Kernel Functions and Structures Reference
 Reservation Objects
 -------------------
 
-.. kernel-doc:: drivers/dma-buf/reservation.c
+.. kernel-doc:: drivers/dma-buf/dma-resv.c
    :doc: Reservation Object Overview
 
-.. kernel-doc:: drivers/dma-buf/reservation.c
+.. kernel-doc:: drivers/dma-buf/dma-resv.c
    :export:
 
-.. kernel-doc:: include/linux/reservation.h
+.. kernel-doc:: include/linux/dma-resv.h
    :internal:
 
 DMA Fences
-- 
2.21.0

