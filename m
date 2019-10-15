Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0105AD7ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 18:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbfJOQDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 12:03:42 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:53849 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731631AbfJOQDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:03:40 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKPIL-0007cZ-5b; Tue, 15 Oct 2019 17:03:33 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKPIK-0003yd-Of; Tue, 15 Oct 2019 17:03:32 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Al Cooper <alcooperx@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 1/2] phy: phy-brcm-usb-init: fix __iomem annotations
Date:   Tue, 15 Oct 2019 17:03:31 +0100
Message-Id: <20191015160332.15244-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register address should have __iomem attributes
so fix this to remove the following sparse warnings:

drivers/phy/broadcom/phy-brcm-usb-init.c:459:30: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:459:30: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:459:30:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:459:30:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:461:30: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:461:30: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:461:30:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:461:30:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:465:30: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:465:30: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:465:30:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:465:30:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:469:30: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:469:30: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:469:30:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:469:30:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:478:30: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:478:30: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:478:30:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:478:30:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:480:30: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:480:30: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:480:30:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:480:30:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:485:30: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:485:30: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:485:30:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:485:30:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:494:9: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:494:9: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:494:9:    expected void [noderef] <asn:2> *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:494:9:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:495:9: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:495:9: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:495:9:    expected void [noderef] <asn:2> *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:495:9:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:498:9: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:498:9: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:498:9:    expected void [noderef] <asn:2> *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:498:9:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:501:9: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:501:9: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:501:9:    expected void [noderef] <asn:2> *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:501:9:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:613:9: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:613:9: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:613:9:    expected void [noderef] <asn:2> *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:613:9:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:640:9: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:640:9: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:640:9:    expected void [noderef] <asn:2> *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:640:9:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13: warning: incorrect type in assignment (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13:    expected void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13:    got void [noderef] <asn:2> *
drivers/phy/broadcom/phy-brcm-usb-init.c:423:38: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:423:38:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:423:38:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:423:52: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:423:52:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:423:52:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:710:64: warning: Using plain integer as NULL pointer
drivers/phy/broadcom/phy-brcm-usb-init.c:712:32: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:712:32: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:712:32:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:712:32:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:713:29: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:713:29: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:713:29:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:713:29:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:717:29: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:717:29: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:717:29:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:717:29:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:720:9: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:720:9: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:720:9:    expected void [noderef] <asn:2> *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:720:9:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:721:9: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:721:9: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:721:9:    expected void [noderef] <asn:2> *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:721:9:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13: warning: incorrect type in assignment (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13:    expected void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13:    got void [noderef] <asn:2> *
drivers/phy/broadcom/phy-brcm-usb-init.c:423:38: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:423:38:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:423:38:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:423:52: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:423:52:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:423:52:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13: warning: incorrect type in assignment (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13:    expected void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13:    got void [noderef] <asn:2> *
drivers/phy/broadcom/phy-brcm-usb-init.c:423:38: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:423:38:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:423:38:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:423:52: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:423:52:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:423:52:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:434:13: warning: incorrect type in assignment (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:434:13:    expected void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:434:13:    got void [noderef] <asn:2> *
drivers/phy/broadcom/phy-brcm-usb-init.c:435:38: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:435:38:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:435:38:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:435:51: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:435:51:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:435:51:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:434:13: warning: incorrect type in assignment (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:434:13:    expected void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:434:13:    got void [noderef] <asn:2> *
drivers/phy/broadcom/phy-brcm-usb-init.c:435:38: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:435:38:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:435:38:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:435:51: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:435:51:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:435:51:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:434:13: warning: incorrect type in assignment (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:434:13:    expected void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:434:13:    got void [noderef] <asn:2> *
drivers/phy/broadcom/phy-brcm-usb-init.c:435:38: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:435:38:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:435:38:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:435:51: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:435:51:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:435:51:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:434:13: warning: incorrect type in assignment (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:434:13:    expected void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:434:13:    got void [noderef] <asn:2> *
drivers/phy/broadcom/phy-brcm-usb-init.c:435:38: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:435:38:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:435:38:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:435:51: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:435:51:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:435:51:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:794:29: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:794:29: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:794:29:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:794:29:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:813:29: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:813:29: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:813:29:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:813:29:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:829:37: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:829:37: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:829:37:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:829:37:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:843:37: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:843:37: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:843:37:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:843:37:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:847:37: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:847:37: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:847:37:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:847:37:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13: warning: incorrect type in assignment (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13:    expected void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13:    got void [noderef] <asn:2> *
drivers/phy/broadcom/phy-brcm-usb-init.c:423:38: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:423:38:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:423:38:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:423:52: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:423:52:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:423:52:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13: warning: incorrect type in assignment (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13:    expected void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13:    got void [noderef] <asn:2> *
drivers/phy/broadcom/phy-brcm-usb-init.c:423:38: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:423:38:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:423:38:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:423:52: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:423:52:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:423:52:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:434:13: warning: incorrect type in assignment (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:434:13:    expected void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:434:13:    got void [noderef] <asn:2> *
drivers/phy/broadcom/phy-brcm-usb-init.c:435:38: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:435:38:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:435:38:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:435:51: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:435:51:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:435:51:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:878:9: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:878:9: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:878:9:    expected void [noderef] <asn:2> *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:878:9:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:880:29: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:880:29: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:880:29:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:880:29:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:896:29: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:896:29: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:896:29:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:896:29:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:901:37: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:901:37: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:901:37:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:901:37:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:905:37: warning: cast removes address space '<asn:2>' of expression
drivers/phy/broadcom/phy-brcm-usb-init.c:905:37: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:905:37:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:905:37:    got void *
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13: warning: incorrect type in assignment (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13:    expected void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13:    got void [noderef] <asn:2> *
drivers/phy/broadcom/phy-brcm-usb-init.c:423:38: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:423:38:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:423:38:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:423:52: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:423:52:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:423:52:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13: warning: incorrect type in assignment (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13:    expected void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13:    got void [noderef] <asn:2> *
drivers/phy/broadcom/phy-brcm-usb-init.c:423:38: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:423:38:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:423:38:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:423:52: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:423:52:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:423:52:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:434:13: warning: incorrect type in assignment (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:434:13:    expected void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:434:13:    got void [noderef] <asn:2> *
drivers/phy/broadcom/phy-brcm-usb-init.c:435:38: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:435:38:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:435:38:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:435:51: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:435:51:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:435:51:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:434:13: warning: incorrect type in assignment (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:434:13:    expected void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:434:13:    got void [noderef] <asn:2> *
drivers/phy/broadcom/phy-brcm-usb-init.c:435:38: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:435:38:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:435:38:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:435:51: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/broadcom/phy-brcm-usb-init.c:435:51:    expected void [noderef] <asn:2> *addr
drivers/phy/broadcom/phy-brcm-usb-init.c:435:51:    got void *reg
drivers/phy/broadcom/phy-brcm-usb-init.c:422:13: warning: too many warnings

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Al Cooper <alcooperx@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com
---
 drivers/phy/broadcom/phy-brcm-usb-init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.c b/drivers/phy/broadcom/phy-brcm-usb-init.c
index 3c53625f8bc2..fa6dd117c40e 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
@@ -126,8 +126,8 @@ enum {
 	USB_CTRL_SELECTOR_COUNT,
 };
 
-#define USB_CTRL_REG(base, reg)	((void *)base + USB_CTRL_##reg)
-#define USB_XHCI_EC_REG(base, reg) ((void *)base + USB_XHCI_EC_##reg)
+#define USB_CTRL_REG(base, reg)	((void __iomem *)base + USB_CTRL_##reg)
+#define USB_XHCI_EC_REG(base, reg) ((void __iomem *)base + USB_XHCI_EC_##reg)
 #define USB_CTRL_MASK(reg, field) \
 	USB_CTRL_##reg##_##field##_MASK
 #define USB_CTRL_MASK_FAMILY(params, reg, field)			\
@@ -416,7 +416,7 @@ void usb_ctrl_unset_family(struct brcm_usb_init_params *params,
 			   u32 reg_offset, u32 field)
 {
 	u32 mask;
-	void *reg;
+	void __iomem *reg;
 
 	mask = params->usb_reg_bits_map[field];
 	reg = params->ctrl_regs + reg_offset;
@@ -428,7 +428,7 @@ void usb_ctrl_set_family(struct brcm_usb_init_params *params,
 			 u32 reg_offset, u32 field)
 {
 	u32 mask;
-	void *reg;
+	void __iomem *reg;
 
 	mask = params->usb_reg_bits_map[field];
 	reg = params->ctrl_regs + reg_offset;
-- 
2.23.0

