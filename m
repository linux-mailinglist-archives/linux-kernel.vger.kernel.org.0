Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90364D2B94
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 15:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388304AbfJJNl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 09:41:27 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:46781 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388271AbfJJNlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:41:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 741453F49B;
        Thu, 10 Oct 2019 15:41:18 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=Rix0aEWR;
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
        with ESMTP id cahSb6bMUdIh; Thu, 10 Oct 2019 15:41:17 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 493113F218;
        Thu, 10 Oct 2019 15:41:17 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 0DD4D36016C;
        Thu, 10 Oct 2019 15:41:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570714877; bh=n0r0/gr5DGR8PKfDTpl5xOseUsgi8gjV64mOMzX31mg=;
        h=From:To:Cc:Subject:Date:From;
        b=Rix0aEWR6MmQ3IMpwzhAJ7nxL1ZmI7koM15not/pYLFsz5Q96lP3VpexvNYEOq43t
         IevhIYzceltokMIkYLDVJUA69uoPPp3B95Iuam64ihG5ZXnj5raBIayjng0fq1GQQr
         3RibwTeSADJ13s7gNhiUWxjcFTy9i5HZh8EHcKEI=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        torvalds@linux-foundation.org, kirill@shutemov.name
Cc:     =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>
Subject: [RFC PATCH 0/4] mm: pagewalk: Rework callback return values and optionally skip the pte level
Date:   Thu, 10 Oct 2019 15:40:54 +0200
Message-Id: <20191010134058.11949-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts all users of pagewalk positive callback return values
to use negative values instead, so that the positive values are free for
pagewalk control. Then the return value PAGE_WALK_CONTINUE is introduced.
That value is intended for callbacks to indicate that they've handled the
entry and it's not necessary to split and go to a lower level.
Initially this is implemented only for pmd_entry(), but could (should?)
at some point be used also for pud_entry().

Finally the mapping_dirty_helpers pagewalk is modified to use the new value
indicating that it has processed a read-only huge pmd entry and don't want
it to be split and handled at the pte level.

Note: This series still needs some significant testing and another re-audit
to verify that there are no more pagewalk users relying on positive return
values.
