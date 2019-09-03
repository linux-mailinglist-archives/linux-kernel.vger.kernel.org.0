Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C870CA6974
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 15:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbfICNPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 09:15:22 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:39710 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfICNPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:15:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id D148940484;
        Tue,  3 Sep 2019 15:15:19 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=O9fDiiLP;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U-yWj3dTeUAj; Tue,  3 Sep 2019 15:15:18 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 0FBE54041E;
        Tue,  3 Sep 2019 15:15:17 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 51241360160;
        Tue,  3 Sep 2019 15:15:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567516517; bh=k4qD2CIRuiMN+/xCKKla+Pb1zrd34KXbguPhrJpEa9w=;
        h=From:To:Cc:Subject:Date:From;
        b=O9fDiiLPidkXIiDD+2AOf1LSKTXeBllefKQIB4cGYnYURPm/Ao8IIhnmzodXJ2kd3
         INfw0V3l/64MsjqLjhWg3dMb8Y9OqPgTiEJcgKU3Vbqm1TIyVryZG/2vLPwFWrdkzM
         SxwiygpkgqkOiMD9gHGVwNkOkvx6hE822WJPMW/A=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>
Subject: [PATCH v2 0/4] Have TTM support SEV encryption with coherent memory
Date:   Tue,  3 Sep 2019 15:15:00 +0200
Message-Id: <20190903131504.18935-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With SEV memory encryption and in some cases also with SME memory
encryption, coherent memory is unencrypted. In those cases, TTM doesn't
set up the correct page protection. Fix this by having the TTM
coherent page allocator call into the platform code to determine whether
coherent memory is encrypted or not, and modify the page protection if
it is not.

v2:
- Use force_dma_unencrypted() rather than sev_active() to catch also the
  special SME encryption cases.
