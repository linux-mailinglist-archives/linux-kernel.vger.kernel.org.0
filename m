Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 840D7119C4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 15:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfEBNJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 09:09:20 -0400
Received: from internet2.beckhoff.com ([194.25.186.210]:59762 "EHLO
        Internet2.beckhoff.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfEBNJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 09:09:20 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 May 2019 09:09:19 EDT
Received: from std-ryzen.beckhoff.com (172.17.66.182) by
 NT-Mail02.beckhoff.com (10.1.0.27) with Microsoft SMTP Server (TLS) id
 14.3.301.0; Thu, 2 May 2019 15:04:17 +0200
From:   <linux-kernel-dev@beckhoff.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/1] Add several Beckhoff Automation boards to critclk_systems DMI table
Date:   Thu, 2 May 2019 15:03:50 +0200
Message-ID: <20190502130351.5341-1-linux-kernel-dev@beckhoff.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.17.66.182]
X-OLX-Disclaimer: Done
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

There are several Beckhoff Automation industrial PC boards which use
pmc_plt_clk* clocks for ethernet controllers. The patch adds affected boards
to critclk_systems DMI table so the clocks are marked as CLK_CRITICAL and
not turned off.
This should be applied on top of another patch as both change
the same table:
[PATCH] platform/x86: pmc_atom: Add Lex 3I380D industrial PC to critclk_systems DMI table

Steffen Dirkwinkel (1):
  platform/x86: pmc_atom: Add several Beckhoff Automation boards to
    critclk_systems DMI table

 drivers/platform/x86/pmc_atom.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

-- 
2.21.0
