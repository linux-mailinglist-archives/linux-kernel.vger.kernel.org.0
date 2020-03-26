Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C75021943DB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 17:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgCZP77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 11:59:59 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52666 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgCZP6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:58:45 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155844euoutp02176fd544e3a18683168cc81cba63af99~-5duLhBYc0032300323euoutp02r
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 15:58:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200326155844euoutp02176fd544e3a18683168cc81cba63af99~-5duLhBYc0032300323euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238324;
        bh=XFteAdww/OChbRFBZe7eQm336foUgFis6vmKGvcMYkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GwXs/By2Sbc1zatKEXSunHuSbJwnfocHTvHLHy42IQsxzwi0XNIFO04/vuBohWJ7U
         pU88cTUadqimNG3Zyu9b8t7cqzmKYF2J5S/8UHWBW4Vpo3T54URDBNYSXmREJ6W9GM
         X3VV1u47Ok8nAVQqB7K7xqCmgoIaFM0vIxnfDyO0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200326155844eucas1p29b13d1567ec6cf72ce19515f4af04768~-5dt4Iq0I2255222552eucas1p2N;
        Thu, 26 Mar 2020 15:58:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 06.E9.60679.431DC7E5; Thu, 26
        Mar 2020 15:58:44 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200326155844eucas1p2e9676a4dd5205dc66c464cf8d9f4efb7~-5dtgiPq92255222552eucas1p2M;
        Thu, 26 Mar 2020 15:58:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155844eusmtrp147bb8d7686f8dbc3083f998a85e5301f~-5dtf9pzJ2090020900eusmtrp1n;
        Thu, 26 Mar 2020 15:58:44 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-cd-5e7cd1341386
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4D.5A.08375.431DC7E5; Thu, 26
        Mar 2020 15:58:44 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155843eusmtip186c3d14313815a86814537b368ec10c7~-5dtAxLy51235312353eusmtip10;
        Thu, 26 Mar 2020 15:58:43 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 14/27] ata: let compiler optimize out
 ata_dev_config_ncq() on non-SATA hosts
Date:   Thu, 26 Mar 2020 16:58:09 +0100
Message-Id: <20200326155822.19400-15-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87omF2viDK48UbBYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnr75xnK5jHUfHp8R72BsZjbF2MnBwS
        AiYSS+8sYOli5OIQEljBKPHz6j0o5wujxK0v7xghnM+MEi+XX2WHadl2axUzRGI5o8TtWR+Y
        QRIQLXeTQWw2ASuJie2rGEFsEQEFiZ7fK9lAGpgF3jNKrJi0lwUkISyQKLF32yKwIhYBVYkt
        DU1gG3gF7CS+9K5mgdgmL7H12ydWEJsTKL583XxmiBpBiZMzn4DVMAPVNG+dDXaRhMAydomJ
        s79Aneoi8WjbdqhBwhKvjm+BistInJ7cwwLRsI5R4m/HC6ju7YwSyyf/g4aNtcSdc7+AbA6g
        FZoS63fpQ4QdJd6+2MYOEpYQ4JO48VYQ4gg+iUnbpjNDhHklOtqEIKrVJDYs28AGs7Zr50pm
        CNtDYsGktcwTGBVnIXlnFpJ3ZiHsXcDIvIpRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMw
        FZ3+d/zLDsZdf5IOMQpwMCrx8Gq01MQJsSaWFVfmHmKU4GBWEuF9GgkU4k1JrKxKLcqPLyrN
        SS0+xCjNwaIkzmu86GWskEB6YklqdmpqQWoRTJaJg1OqgZFnfsyXp6//n72y4Zn+/kVvJkcH
        zGNi9su31TgcyOu9/9dW1ryZz8yDj5QdqbrivUnf9f/rEzrC+q/nvm02t9xUOocx4f6Rax8t
        Jvq9CNtop9C8Vz+1zv5JuICd2m2uO3sWOhlHXWR5zte/vC30Y5v9/lWzqrlaqhan+Xrcm38u
        J0OhMi20bpoSS3FGoqEWc1FxIgAIJ2mJQQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7omF2viDM6vZbdYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehnr75xnK5jHUfHp8R72BsZjbF2MnBwSAiYS226tYu5i5OIQEljKKHG4
        u5+pi5EDKCEjcXx9GUSNsMSfa11sEDWfGCVaJz9hBEmwCVhJTGxfBWaLCChI9PxeCVbELPCV
        UWLppG5mkISwQLxEZ88NFhCbRUBVYktDEzuIzStgJ/GldzULxAZ5ia3fPrGC2JxA8eXr5oP1
        CgnYSiz+8oEJol5Q4uTMJ2D1zED1zVtnM09gFJiFJDULSWoBI9MqRpHU0uLc9NxiQ73ixNzi
        0rx0veT83E2MwIjZduzn5h2MlzYGH2IU4GBU4uHVaKmJE2JNLCuuzD3EKMHBrCTC+zQSKMSb
        klhZlVqUH19UmpNafIjRFOiJicxSosn5wGjOK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5Y
        kpqdmlqQWgTTx8TBKdXAmOfi+u7am3NBasaxTxuff5iQs+hSw6cLBxqblzoLbt/mHGydJHpZ
        XvXquVk6eiZiyfzumxdOzTg/LyYu8U/fritPhPm/5G783y5x2aboNHPdS5Eb78zWLUuX2HYw
        7MXV5R+OmJ5RWKF+qkDoe7RHbG9vVeive3Hm7NOPzCyStF+dvah9zdnINCWW4oxEQy3mouJE
        AD2UzR2uAgAA
X-CMS-MailID: 20200326155844eucas1p2e9676a4dd5205dc66c464cf8d9f4efb7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155844eucas1p2e9676a4dd5205dc66c464cf8d9f4efb7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155844eucas1p2e9676a4dd5205dc66c464cf8d9f4efb7
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155844eucas1p2e9676a4dd5205dc66c464cf8d9f4efb7@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add !IS_ENABLED(CONFIG_SATA_HOST) to ata_dev_config_ncq() to allow
compiler to optimize out the function for non-SATA configs.

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  37582     572      40   38194    9532 drivers/ata/libata-core.o
after:
  36462     572      40   37074    90d2 drivers/ata/libata-core.o

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0a56968e2e98..dcdb7fb46dbd 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2287,6 +2287,8 @@ static int ata_dev_config_ncq(struct ata_device *dev,
 		desc[0] = '\0';
 		return 0;
 	}
+	if (!IS_ENABLED(CONFIG_SATA_HOST))
+		return 0;
 	if (dev->horkage & ATA_HORKAGE_NONCQ) {
 		snprintf(desc, desc_sz, "NCQ (not used)");
 		return 0;
-- 
2.24.1

