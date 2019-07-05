Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47AFB5F52D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 11:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfGDJKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 05:10:15 -0400
Received: from host-88-217-225-28.customer.m-online.net ([88.217.225.28]:51098
        "EHLO mail.dev.tdt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727153AbfGDJKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:10:15 -0400
Received: from feckert01.dev.tdt.de (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id D9CD921441;
        Thu,  4 Jul 2019 09:02:13 +0000 (UTC)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, info@metux.net,
        dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Eckert <fe@dev.tdt.de>
Subject: [PATCH 0/3] Update pcengines-apuv2 platform device
Date:   Thu,  4 Jul 2019 11:02:02 +0200
Message-Id: <20190704090205.19400-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.dev.tdt.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the following changes to this pcengines-apuv2
platform device.

* Add mpcie reset gpio export
* Add legacy leds gpio definitions
* Update gpio buttion definitions

Florian Eckert (3):
  platform/x86/pcengines-apuv2: add mpcie reset gpio export
  platform/x86/pcengines-apuv2: add legacy leds gpio definitions
  platform//x86/pcengines-apuv2: update gpio button definition

 drivers/platform/x86/pcengines-apuv2.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

-- 
2.11.0

