Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A659B5D53B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 19:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfGBR1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 13:27:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42002 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfGBR1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 13:27:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so721623plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 10:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4BWRhGGfD41X+BXS6YHybFemLR0f5btRLnjH/VaAfp4=;
        b=QDAeo86ZOjwzdMaiUs8OP5BQogZ27q/Pyp5Zjcq4ng235dn7iYmoahw7r1RMYzg/4R
         NLFe38GxJd3PeofXVq/3juXFoqlBG0Nq7lGnwaN1Mm7BoW4h0Xt+obcgMVg/gJUmdXZs
         p0ndDWW7ZRbnmasf7/ozZ5No+XLngPA0W4ZVCIKQjNHnckuJzPOwzJEixyfzeWhkJobS
         /FCCrMyPJzMCeEN96qMHR90eeWmCYJZE16OryozyzqSXcA+mem/gGGAzjA8sX0VcLWUb
         ebf6ac6/jTiw02WJ0S1wnAmquJ/q9qgmMe0yzjEgb33w5SU68zWFEs6Qwj4/tmdkryjh
         OrqQ==
X-Gm-Message-State: APjAAAUP7m3Wosjzidzn6jsG85NX+xT9f/CuBzK5vtlwiVv3alL9ej6X
        TQOVgHT25zCx0Ia/JkvR7/E=
X-Google-Smtp-Source: APXvYqw+8oKnZiDm/OPgXK9Ojv0T86PA9M3eznJ0G7bYU2Peh7V61K74H9Ov9V/boi8YEZHJVRZOTg==
X-Received: by 2002:a17:902:22e:: with SMTP id 43mr29447700plc.272.1562088460406;
        Tue, 02 Jul 2019 10:27:40 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id x14sm17331522pfq.158.2019.07.02.10.27.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 10:27:39 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>
Subject: [PATCH] vmw_balloon: Remove Julien from the maintainers list
Date:   Tue,  2 Jul 2019 03:05:19 -0700
Message-Id: <20190702100519.7464-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Julien will not be a maintainer anymore.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 01a52fc964da..f85874b1e653 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16886,7 +16886,6 @@ F:	drivers/vme/
 F:	include/linux/vme*
 
 VMWARE BALLOON DRIVER
-M:	Julien Freche <jfreche@vmware.com>
 M:	Nadav Amit <namit@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.17.1

