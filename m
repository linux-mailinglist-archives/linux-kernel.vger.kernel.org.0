Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB90413AB42
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 14:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgANNoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 08:44:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38829 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANNoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:44:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id u2so13767918wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 05:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+KDdpEda72c8Z0y+Uj5w7oRFnZJtRQ2x+bj/uoKma6Y=;
        b=F70YThTIPBalEBh5BaB4WYK/iNuuMLjbLJDtK9u8ERnymTv/m3y7Re0n1+rWrQZdse
         r7eMfhF8ZvnUCa0Al3k1LX4TB/pTbLTJKcf1mrisc7CdbfM/HB6VZigFvcmCSwT5Cz9r
         DlR2LOTxSUwDvHEqXqE+9WHog4PHqPKNOH2jj3tpCBoqQtBcAURrIlNEFixlt2C40MxX
         MbQqWthaVKlKqeGaKphwsJYHqxuN2otetm7rMUa/hKlpV/N622Z+TfWbkvqd2KLNo6rk
         V0yvs73Dx5RHISY1Fi0vA3O/Quozqv7cLSrWTyhYPOwUMv/BRy7beLR4Wi1riAJ2eJH+
         gvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+KDdpEda72c8Z0y+Uj5w7oRFnZJtRQ2x+bj/uoKma6Y=;
        b=E7PIskGxZKah0qvDjWgypBBf72pRMUPGS/E1cn2jViNlxI1BieORxEBLzh2NxVDY5D
         jG72go2lTB64Wd74P0/j402yONxBcrmG5yM7GGYOzZgxzkONOK5xRG78LNcji55p1VCU
         g6xWcl+k00HM74v4DogDsx4QdjQJ+rXEqMgVqpu7KOMA0Tvbeylg35DdjC6WcPl94hsX
         6qFdkdyqmh7h+AATcc1wj8Zr0WGFcGRoCDK6/+tyFN2y6kKM4jE6GrE5kNahmPF4p2+F
         UGQSZrg0kIJL5VqsoxzeTGqYSdK15vHIxHeRMIveqTkx07wP95h0CER4RCX0S08N6cJe
         exqA==
X-Gm-Message-State: APjAAAU5i+rAZyQLlJj2NU42vO+8YPe3iqSOEpWs4OE2Riale1diGxe4
        4io2E7hinVE/txaGahmkSdmmhTAKo1Hp0g==
X-Google-Smtp-Source: APXvYqz6pQGuJ8RWbU3QjpoUZVeVLsYzd8lQ0OC99bXw2E3+C16tX3Covj6I95Wpi3TV8OXwLOjZQg==
X-Received: by 2002:a7b:cf2d:: with SMTP id m13mr27350242wmg.163.1579009448141;
        Tue, 14 Jan 2020 05:44:08 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id d8sm20094697wre.13.2020.01.14.05.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jan 2020 05:44:07 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Subject: [PATCH] microblaze: Add ID for Microblaze v11
Date:   Tue, 14 Jan 2020 14:44:06 +0100
Message-Id: <5e56ec0090bceb711dbab145ffffa52f60c23d87.1579009444.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

List Microblaze v11 from PVR.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/kernel/cpu/cpuinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/microblaze/kernel/cpu/cpuinfo.c b/arch/microblaze/kernel/cpu/cpuinfo.c
index ef2f49471a2a..cd9b4450763b 100644
--- a/arch/microblaze/kernel/cpu/cpuinfo.c
+++ b/arch/microblaze/kernel/cpu/cpuinfo.c
@@ -51,6 +51,7 @@ const struct cpu_ver_key cpu_ver_lookup[] = {
 	{"9.5", 0x22},
 	{"9.6", 0x23},
 	{"10.0", 0x24},
+	{"11.0", 0x25},
 	{NULL, 0},
 };
 
-- 
2.24.0

