Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84C981FFB9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 08:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfEPGn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 02:43:27 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:35127 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfEPGn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 02:43:27 -0400
Received: by mail-pf1-f169.google.com with SMTP id t87so1313144pfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 23:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=SqLUabMMzxCxSOebL0RIYlE+FsNekjMKv483Qc3eXKM=;
        b=Gj9MopXzSpqX85oENFLgCbsQfKjA/2mr/v96/x0XAw0Hvk8iHXljsbU6k1UPa6KoNO
         WpUUifFovIYExm9wJGV4MjhzPN0QSigTkRwcSmnRqbu7Wmrp95PheEVUpAuud2Wz6u+0
         3JcCajMcAlMUF0NUGU71tAlntbJTe3XI1CKwg9GQIHwYNYpXvNYLAFWG63JDkxX030Lh
         honZKMzNdGDe6REuxNlGdr6zwSaI436RfSlMSClCWcXdp2u9xCCXVAHRUUqxD/isb94S
         3ivwctJp1mJY5KiwBTxkNUc+8nauKCHnmHaVY74lpJlX2PVhJJpNWsKs6cHOLFdw9WaB
         q6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SqLUabMMzxCxSOebL0RIYlE+FsNekjMKv483Qc3eXKM=;
        b=bvUJZaQEKvQfQ2FAQAF2ZI/RDCyvHAxeExB5pcv3HqNWv3urT35LtLTFS9BgHM1J39
         mjOb/0m5SUUYdsXn1zy9ygmDW5w5XBzXMgQ40nqNY+3GGUl3lYsoUDKFd55lDWpAcDBl
         fD+SbbiyDDXtB8vg1sqoUMZsg06vU1T2XFkaqcd5Sxu/kIoE5bm1h4tJvsWHALeRkXGp
         rsTcJfpES/80PgdV+yOV50TSUrodd7P1MLc/mnkSEb51dy/G+2QWsf8xCFh0dpSTR8es
         kp+E/PZ1atv20cLKQBTLYxqiY14Tt/MMg1UGw5FdaO+om7NWPsPTCkEiVjaumlzU4uM/
         R1Cw==
X-Gm-Message-State: APjAAAVNUAjN4mdfU71j5fiI8RPHhYq8csF6DDmmYwFisb24VAECc+Rf
        /z9Dlu2enY6apJ9tPr0LkSFkwA==
X-Google-Smtp-Source: APXvYqw0OJ+MvOqREfJMhEjQhim2lbFJ/Zb5HXYS1GVYKGGhMwv45V3f+lNiCcI9UVQISNRsYlPgcQ==
X-Received: by 2002:a62:c4:: with SMTP id 187mr40911403pfa.55.1557989006488;
        Wed, 15 May 2019 23:43:26 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id w194sm11196050pfd.56.2019.05.15.23.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 23:43:25 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     arm@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 0/4] ARM: SoC contents for 5.2 merge window
Date:   Wed, 15 May 2019 23:43:00 -0700
Message-Id: <20190516064304.24057-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The usual batch of patches for ARM SoCs. Like always, DT is the dominant
portion, but there's an unusual amount of driver updates this release.

Main reason for that is that ixp4xx is seeing a bunch of modernization
work by Linus Walleij, and some of that has included bringing some things
out to proper driver. Acks have been collected, but are merged through
our trees to keep things together.

Besides that it's a quiet-to-average merge window for us.

Some statistics:

82 downstream branches
791 patches
175 contributors

4 upstream-bound branches (platform, DT, drivers, defconfig)

New SoCs:
 - Intel Agilex (SoCFPGA)
 - NXP i.MX8MM (variant of i.MX8M)

New boards:
 - Numerous, see DT pull request for full list
 - Most visible one is probably Nvidia's Jetson Nano

Contributors with 10 or more patches this cycle:
  54 Maxime Ripard
  43 Tony Lindgren
  38 Christina Quast
  34 Linus Walleij
  29 Neil Armstrong
  27 Andrey Smirnov
  20 Krzysztof Kozlowski
  18 Thierry Reding
  17 Amit Kucheria
  17 Anson Huang
  13 Dmitry Osipenko
  12 Douglas Anderson
  11 Biju Das
  11 Manivannan Sadhasivam
  11 Ondrej Jirman
  10 Fabrizio Castro
