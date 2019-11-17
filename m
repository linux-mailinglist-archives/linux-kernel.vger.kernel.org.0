Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA28FF814
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 07:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfKQG35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 01:29:57 -0500
Received: from smtpq3.tb.mail.iss.as9143.net ([212.54.42.166]:44696 "EHLO
        smtpq3.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbfKQG35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 01:29:57 -0500
Received: from [212.54.42.110] (helo=smtp7.tb.mail.iss.as9143.net)
        by smtpq3.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <jongk@linux-m68k.org>)
        id 1iWE4J-0007l2-8z; Sun, 17 Nov 2019 07:29:55 +0100
Received: from mail-wr1-f46.google.com ([209.85.221.46])
        by smtp7.tb.mail.iss.as9143.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <jongk@linux-m68k.org>)
        id 1iWE4J-0006tw-54; Sun, 17 Nov 2019 07:29:55 +0100
Received: by mail-wr1-f46.google.com with SMTP id s5so15732774wrw.2;
        Sat, 16 Nov 2019 22:29:55 -0800 (PST)
X-Gm-Message-State: APjAAAU3vgOrRMPuUlcEkwzCGIiU5z0Y0WCvCJmUWOFZpLU1Hnf7dloN
        uiyMEzIQDWOsfOmDwj1C8WOckIEYy2YIKebIWlc=
X-Google-Smtp-Source: APXvYqyFMzuM1pPgk4XlPud09E/GOi9t1wSuSwcleGfGzmW3DbfeeHqHBUjg0ssMjg8BJSIjjnxVL+ybT5uM4+zkGgE=
X-Received: by 2002:adf:ea8d:: with SMTP id s13mr23994205wrm.366.1573972194665;
 Sat, 16 Nov 2019 22:29:54 -0800 (PST)
MIME-Version: 1.0
References: <2bbb6359d542f5882be67c415ecc25ad2d9eeb5e.1573875417.git.fthain@telegraphics.com.au>
 <CACz-3rjHAyi6kMQ6j9YALLm1ApYrsqKiTnGNPUhxqqEuRJ9TjQ@mail.gmail.com>
In-Reply-To: <CACz-3rjHAyi6kMQ6j9YALLm1ApYrsqKiTnGNPUhxqqEuRJ9TjQ@mail.gmail.com>
From:   Kars de Jong <jongk@linux-m68k.org>
Date:   Sun, 17 Nov 2019 07:29:43 +0100
X-Gmail-Original-Message-ID: <CACz-3rhGZ7SiYMOWv8ER7u8pzx=pxq9k4sQjJQqh4Qrn+74C2A@mail.gmail.com>
Message-ID: <CACz-3rhGZ7SiYMOWv8ER7u8pzx=pxq9k4sQjJQqh4Qrn+74C2A@mail.gmail.com>
Subject: Re: [PATCH] esp_scsi: Clear Transfer Count registers before PIO transfers
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-SourceIP: 209.85.221.46
X-Authenticated-Sender: karsdejong@home.nl (via SMTP)
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=cPSeTWWN c=1 sm=1 tr=0 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=MeAgGD-zjQ4A:10 a=tBb2bbeoAAAA:8 a=d8rZ9vRRgRfmWEAI3WsA:9 a=QEXdDO2ut3YA:10 a=win4SnVEMkUA:10 a=Oj-tNtZlA1e06AYgeCfH:22
X-Ziggo-Spam-Status: No
X-Spam-Status: No
X-Spam-Flag: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op zo 17 nov. 2019 om 07:26 schreef Kars de Jong <jongk@linux-m68k.org>:
> The only place the controller reads these registers is when a DMA
> command is issued.

The only time it does this, I mean.
