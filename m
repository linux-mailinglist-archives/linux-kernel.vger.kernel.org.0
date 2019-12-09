Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3191165C8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 05:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfLIEQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Dec 2019 23:16:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfLIEQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 23:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m6ahlMt+Kd2tTBI1aH0mtOYUrtuS0vfuctXuJUFSEFU=; b=mNFpPPMj9nmB/M8V1a0Tvmchh
        VoALfSB3jInmHM1kQVCKHAqWuI1I0FyzreS/7BbJf1w328lymBIQaSIJeHaplpbOKUUbD6zK1dowH
        lJQHK3/IvhUuvGXP/bCbJz2VvLI5NSPjkZVu+HYTUNRPuQ645z58oQODehUbyU9MIYgEuDm0zmyZP
        mgrLUeJrxna4ZFDPgm4TieulqgXq7ZFKgoJ9spHXjQKKamn3PnzxmkF/w5yffCCMWfYoi/Fmvxyi3
        boVcrL5WflKRUH49VU1Fan7IO1GxXIbifsM/QxXawACkeRky1nSe9coPO8RuaOcNhfj6bINGZLKy/
        LsWFU5XLA==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieATR-0005sI-86; Mon, 09 Dec 2019 04:16:41 +0000
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: fix Sphinx warning in xilinx_sdfec.rst
Message-ID: <8d644cf1-fa7b-ec62-84cf-9b41d7c30eed@infradead.org>
Date:   Sun, 8 Dec 2019 20:16:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Sphinx format warning by adding a blank line.

Documentation/misc-devices/xilinx_sdfec.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Derek Kiernan <derek.kiernan@xilinx.com>
Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/misc-devices/xilinx_sdfec.rst |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20191209.orig/Documentation/misc-devices/xilinx_sdfec.rst
+++ linux-next-20191209/Documentation/misc-devices/xilinx_sdfec.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0+
+
 ====================
 Xilinx SD-FEC Driver
 ====================


