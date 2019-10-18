Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61EDEDC65A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 15:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439523AbfJRNlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 09:41:10 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:37454 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392320AbfJRNlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:41:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id CF66C3F867;
        Fri, 18 Oct 2019 15:41:07 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=SsF4ZbqW;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TOTufyBBa0V2; Fri, 18 Oct 2019 15:41:04 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 45F6F3F7F6;
        Fri, 18 Oct 2019 15:41:04 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id C66A6360591;
        Fri, 18 Oct 2019 15:41:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1571406063; bh=gGaWHO4KvUf91pQm6umckHTl12QmRAuYU6HJ9fAM6fU=;
        h=From:To:Cc:Subject:Date:From;
        b=SsF4ZbqWje6RizrLxTyQMT92ptjr6gRwqIXdD9hUUFujuA41PVa7zh4zPIxM68BbK
         EZwfg2h+hTRdzj0I+1OTyCWw5BXC88tbzLuZgIRG26EmlcH1Ipt1tu7/noxLZWwRC2
         6v7jR+JeYLC0c+7GUGJyv7lkLKFGw5X1/fbqnE/o=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH 0/2] x86/cpu/vmware: Fixes for 5.4
Date:   Fri, 18 Oct 2019 15:40:50 +0200
Message-Id: <20191018134052.3023-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Two fixes for recently introduced regressions:

Patch 1 is more or less idential to a previous patch fixing the VMW_PORT
macro on LLVM's assembler. However, that patch left out the VMW_HYPERCALL
macro (probably not configured for use), so let's fix that also.

Patch 2 fixes another VMW_PORT run-time regression at platform detection
time
