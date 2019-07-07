Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E59FF614AB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2019 12:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfGGK1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jul 2019 06:27:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38682 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfGGK1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 06:27:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id z75so6197859pgz.5;
        Sun, 07 Jul 2019 03:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8zUSV3oUAOKo1p9yciN3aXy3pVPdOrPwzw0QPi5xIzo=;
        b=VBjqvvTXk8FATRmQEiOuWon5GfWlkAvU4GGZ6FUmW7+3gmXcpcm4/fFEGzxd2XhrtB
         PHtGO0BF15qudbOJN1Mb2S1EJXqlorX0y4YkkVQOtl+YRryzXGN/AjqF79esn/tuNQd+
         ifppzkOODJ5w7jSvmT2lYljvh+zH7Re24g7l3J1/t0Z86tiKN0LOopmOQAf74LcDlod4
         en+RY5ZRD75cN+LkdTg1L5u6r9vgS9J8VHxz11zeiwh8ffZpiGe2eZTarrX6OzfTK1TS
         u5qJHUe1a1kMyxm5DV9PSMrA4nHyW32fBjW+23vrFzWpH6RZ1gZQTX7oSbYd9n4DgFYj
         2Fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8zUSV3oUAOKo1p9yciN3aXy3pVPdOrPwzw0QPi5xIzo=;
        b=I46owV0g0pSPhUgqvdWU1cyhyynDclEre1V+x7sn5JRy7deGLJSWOzePcz/yGEiBQb
         adHlgW1znvC5ZHt050X6UQMaLnL+B2RmQI4PtXXUXMBrNr/M9rQKC9i8gnqV1j/S9u85
         7z/gdkNVNK8SjksIzwwUjf+/E2tVBueBkPROnOaJBdQ+uZku2TRnWvA6aIhcN1X4uBx3
         HSuCuUc10mh64W12/UE3dRbgo+QHLPdc+t9NKsfEV+/6gfCHQjy8GXEsDHVcWQe/rtUg
         EkUS9QlnVzfcSUlaPKmQ17mEKO0iOwakaKbDPRpmALCNJr+c3l67S6HU4/bYf9+MC1eb
         A+Pw==
X-Gm-Message-State: APjAAAUiFlLo6btvuo3W8/92I+99xE+iWTF05yJ6y+uoHbFZ/atzni/9
        k8LrF5h7q/Ru8p7OQiWN9cc=
X-Google-Smtp-Source: APXvYqyMx2+32HyNXxBJxnXN90ZX/eNGMf1iEDAGfhyfSUHZUz4eRncpRFe5vwFlPtEZBqtHdLc5ng==
X-Received: by 2002:a17:90a:bf0e:: with SMTP id c14mr16074811pjs.55.1562495234516;
        Sun, 07 Jul 2019 03:27:14 -0700 (PDT)
Received: from carrot.localdomain (i60-35-92-254.s42.a014.ap.plala.or.jp. [60.35.92.254])
        by smtp.gmail.com with ESMTPSA id x128sm35195975pfd.17.2019.07.07.03.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 03:27:12 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH] MAINTAINERS: nilfs2: update email address
Date:   Sun,  7 Jul 2019 19:25:53 +0900
Message-Id: <1562495153-8166-1-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change my email since lab.ntt.co.jp email domain has been deprecated
due to company policy.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 01a52fc..b8eadb3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11116,7 +11116,7 @@ F:	include/uapi/linux/nfs*
 F:	include/uapi/linux/sunrpc/
 
 NILFS2 FILESYSTEM
-M:	Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
+M:	Ryusuke Konishi <konishi.ryusuke@gmail.com>
 L:	linux-nilfs@vger.kernel.org
 W:	https://nilfs.sourceforge.io/
 W:	https://nilfs.osdn.jp/
-- 
1.8.3.1

