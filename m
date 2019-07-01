Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17A5E23877
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 15:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389401AbfETNnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 09:43:18 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:51636 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731875AbfETNnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:43:17 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D263DC0185;
        Mon, 20 May 2019 13:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558359784; bh=fehVZmzAKfTYKXby0hwi6xFx6X2hjj3eoZIKDWG+gOs=;
        h=From:To:Cc:Subject:Date:From;
        b=DUISUlCcve8zdBfHCMRbWWbnYxWGCx0WXBRnv4jeTPRwV5pCO6EiV7PQ9PHXfBPBp
         MEtEzn7wk1q0gQj9OWKQlyv2VYZRugK3a6cKWlEHhjRK0o9deJyC+yqPP3HoXMqX1N
         lnxbGzPaJ4puCIxjSIY5AjcwbYZ2wxCIcwVJbvpUbbMytwenDomHUo49vAp2KPg8+S
         ItV4O3WSosinSv47Yp/zC2JqBG4mnLWpZSksFxKPZJubNJuUIBb+11nr4MYwSGodXk
         OniW/HIqNsYdYwBKDfGcj4lEVsJXB0U3q1MD0BlrPv4ITuz4ZXDJ8Qfdx6hZwMu6A7
         CQxhpROlHLDRA==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 98C05A009B;
        Mon, 20 May 2019 13:43:15 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id C61163CE81;
        Mon, 20 May 2019 15:43:14 +0200 (CEST)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     devicetree@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH 0/2] ARC: [plat-hsdk]: GMAC DT Bindings Improvements
Date:   Mon, 20 May 2019 15:43:11 +0200
Message-Id: <cover.1558359611.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two missing bindings.

Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Alexey Brodkin <abrodkin@synopsys.com>

Jose Abreu (2):
  ARC: [plat-hsdk]: Add missing multicast filter bins number to GMAC
    node
  ARC: [plat-hsdk]: Add missing FIFO size entry in GMAC node

 arch/arc/boot/dts/hsdk.dts | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.7.4

