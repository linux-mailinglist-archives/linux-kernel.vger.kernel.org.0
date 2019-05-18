Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3166F221CC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2019 08:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfERGe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 May 2019 02:34:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35443 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERGe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 02:34:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id g5so4347833plt.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 23:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eKe6mQqRIzmIAL3NH48NT4h4QYXymD38jNnChIfW1BM=;
        b=D8bcf6mOVVWuhxtlOYV82wNaZNpBanxO+avwGxv+FsAgKqgEJMjEwQVEGTsJoK4yJ5
         34Un4QzPJGiWMl0xy4zRDWaXR6vNnlEZE4bOmVIjZ2qcNxu+yQi7IM13GiaJ+xIa82jF
         AgHe2ozPdAcbctyUznTyXPJwN6OqvNSTjpjpCLp/3wqIU6ZvfRjEVziT4TFqs7YrCuFo
         s8znKfEr2M4WguFHEzyVWGMAssTFHue4MfJ95kfoJ0MaMCoGK6Ft3zRFq4WMBRZgu/ra
         KVM4GEJAb/bU1W7TK5sgB4RZ67s9v8aJPiYN2bvEcXnG1xhpY2xPJc+FQUIl1xELOBUk
         nszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eKe6mQqRIzmIAL3NH48NT4h4QYXymD38jNnChIfW1BM=;
        b=G5I0UbpJwmtNSRQVuhs3mNRVSxnY6nBIeH+ydw5dlbhcDFNUuciT+yPKnURK71o6wr
         O86b0TPgwnodZoYSOSzgcrf8oYJNI1YTnlTCQ4/gyy97gCVu9hOE/g5hoVRPnbYXbtmW
         m+jFRZuXTWeY58nfqELE9YEJB2Ng7QHoBQD1f0qFse8Fzj/NcOXfrhIH8euSdl5m37bz
         He3DVSwzSdvbyk6JdUZE0EkrtwmM8Efb/nB27UAuxLYm8O7WILDWOEeaWQEKsJB+bO4G
         E06i/53awlW3CHTQ4siyuYnaiH+55U/ps0TydXLgdPE9pREnw2SzkUpjBrB1zsQ0LQG/
         ubew==
X-Gm-Message-State: APjAAAWhxBtntOa/MFvBCv0W9u0BFRoN2yOGHaZtCA7XJkXRMqGvGNDA
        Rb+PYUioMevQvMnaZef0HRg=
X-Google-Smtp-Source: APXvYqzUwba2P7OrmWV5/zy/5X85L0OlHg2I/fXqKhGzPkH54H8SSW2HP6qfE9nZyUZMIfJLhMAg8g==
X-Received: by 2002:a17:902:9a81:: with SMTP id w1mr59449007plp.71.1558161266954;
        Fri, 17 May 2019 23:34:26 -0700 (PDT)
Received: from localhost.localdomain ([103.227.98.84])
        by smtp.googlemail.com with ESMTPSA id h26sm14347874pgh.26.2019.05.17.23.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 23:34:26 -0700 (PDT)
From:   Moses Christopher <moseschristopherb@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Larry.Finger@lwfinger.net, david.kershner@unisys.com,
        forest@alittletooquiet.net, davem@davemloft.net,
        ruxandra.radulescu@nxp.com, yangbo.lu@nxp.com, arnd@arndb.de,
        christian.gromm@microchip.com, insafonov@gmail.com,
        hdegoede@redhat.com, devel@driverdev.osuosl.org,
        sparmaintainer@unisys.com,
        Moses Christopher <moseschristopherb@gmail.com>
Subject: [PATCH v1 0/6] use help instead of ---help--- in Kconfig 
Date:   Sat, 18 May 2019 12:03:35 +0530
Message-Id: <20190518063341.11178-1-moseschristopherb@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolve the Warning that comes from the Kconfig file, which states,
"WARNING: prefer 'help' over '---help---' for new help texts"

Moses Christopher (6):
  staging: fsl-dpaa2: use help instead of ---help--- in Kconfig
  staging: most: use help instead of ---help--- in Kconfig
  staging: unisys: use help instead of ---help--- in Kconfig
  staging: rtl8188eu: use help instead of ---help--- in Kconfig
  staging: rtl8723bs: use help instead of ---help--- in Kconfig
  staging: vt665*: use help instead of ---help--- in Kconfig

 drivers/staging/fsl-dpaa2/Kconfig | 8 ++++----
 drivers/staging/most/Kconfig      | 2 +-
 drivers/staging/rtl8188eu/Kconfig | 4 ++--
 drivers/staging/rtl8723bs/Kconfig | 2 +-
 drivers/staging/unisys/Kconfig    | 4 ++--
 drivers/staging/vt6655/Kconfig    | 5 ++---
 drivers/staging/vt6656/Kconfig    | 5 ++---
 7 files changed, 14 insertions(+), 16 deletions(-)

-- 
2.17.1

