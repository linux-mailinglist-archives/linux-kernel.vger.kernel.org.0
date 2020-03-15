Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92F00185AEF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 08:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgCOHPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 03:15:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgCOHPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 03:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=M43Fclutcops3LTjLdBwRIG7fc6qs+/SivGL6t7wtcQ=; b=lVXJbQWZKeohEKZYCbB4VhDVV/
        XsMhxq3ZNhrJcH+HIjJOQHNOsyeBe6gyt/qf17MIyA30PaqWRrm5Vdf7f8V0BLXsHIMfNCUAwWOfX
        Hdv6oCUPEO/gWtLLMSrlPwujR4mKGfHvDB9Th85vsLEPxrICNf428R4H+9NcuNKn1cXLuVn8DBQYr
        PAKt5dFeWs/7RigXJ6QKkltkEKahOwGjNOKiF33VFufb5+yh6yGONB+L8n5sjZWUPF4pihtmPa/Bl
        PgfmRJNOnrkswUYLJn9gG7nD5o31pDXVK1s1qG1KXOHs3Y9QTWvqVhE7CGYAFSl9SPVAgZE8rnGVH
        Ya3xZTQw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDKbE-0003dY-6j; Sun, 15 Mar 2020 04:10:04 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Antonino Daplas <adaplas@gmail.com>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: fbdev: fix -Wextra build warnings
Date:   Sat, 14 Mar 2020 21:09:56 -0700
Message-Id: <20200315041002.24473-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes warnings in fbdev that are found when
-Wextra is used. In fixing these, there were a few other build
errors discovered (mostly caused by bitrot) and fixed.

[PATCH 1/6] fbdev: fbmon: fix -Wextra build warnings
[PATCH 2/6] fbdev: aty: fix -Wextra build warning
[PATCH 3/6] fbdev: matrox: fix -Wextra build warnings
[PATCH 4/6] fbdev: savage: fix -Wextra build warning
[PATCH 5/6] fbdev: pm[23]fb.c: fix -Wextra build warnings and errors
[PATCH 6/6] fbdev: via: fix -Wextra build warning and format warning

 drivers/video/fbdev/aty/atyfb_base.c       |    2 +-
 drivers/video/fbdev/core/fbmon.c           |    2 +-
 drivers/video/fbdev/matrox/matroxfb_base.h |    2 +-
 drivers/video/fbdev/pm2fb.c                |    2 +-
 drivers/video/fbdev/pm3fb.c                |    8 ++++----
 drivers/video/fbdev/savage/savagefb.h      |    2 +-
 drivers/video/fbdev/via/debug.h            |    6 ++++--
 drivers/video/fbdev/via/viafbdev.c         |    2 +-
 8 files changed, 14 insertions(+), 12 deletions(-)
