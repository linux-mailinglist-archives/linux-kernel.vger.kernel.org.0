Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27D4D186B40
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 13:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbgCPMky convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Mar 2020 08:40:54 -0400
Received: from poy.remlab.net ([94.23.215.26]:34276 "EHLO
        ns207790.ip-94-23-215.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731109AbgCPMkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:40:53 -0400
Received: from basile.remlab.net (87-92-31-51.bb.dnainternet.fi [87.92.31.51])
        (Authenticated sender: remi)
        by ns207790.ip-94-23-215.eu (Postfix) with ESMTPSA id 72F825FD9C;
        Mon, 16 Mar 2020 13:40:50 +0100 (CET)
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCHv2 0/3] arm64: clean up trampoline alignment
Date:   Mon, 16 Mar 2020 14:40:49 +0200
Message-ID: <4064091.qgymGCTE6G@basile.remlab.net>
Organization: Remlab
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The KPTI and SDE trampolines each load a pointer from the same fixmap data 
page. This reduces the data alignment to the useful value, and tries to 
clarify the assembler code.

----------------------------------------------------------------
Rémi Denis-Courmont (3):
      arm64: clean up trampoline vector loads
      arm64/sdei: gather trampolines' .rodata
      arm64: reduce trampoline data alignment

 arch/arm64/kernel/entry.S | 23 ++++++++++-------------
 arch/arm64/mm/mmu.c       |  5 ++---
 2 files changed, 12 insertions(+), 16 deletions(-)

-- 
雷米‧德尼-库尔蒙
http://www.remlab.net/



