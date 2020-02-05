Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA21C153A05
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 22:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBEVTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 16:19:22 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:42736 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgBEVTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 16:19:22 -0500
Received: by mail-il1-f170.google.com with SMTP id x2so3143810ila.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 13:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=xPQe3mAJAqIOBNafRoq+xaJrp5nS3FabT69MWAxiV8c=;
        b=hpJv/OJ4GzMRWCrODxUh7AITdb6Wftn+AaRx01nvqoL20o39GNMxWekDTXXE0FVnbe
         sUXtTF0eOqGswAtYODhm5PpwsIMevm0q0dBQz9cmVtWRXJLY9hATRGD0C03bES44YS8l
         LWtwMgpYide15lJ9iRlH0H5WGMF1yCNsXRyQfZaFL9nIZiNHgnG4CfuOh/iVLq19qD21
         0KZY33Ww5FtSZ3oirRQBijnsxHo2JZetcrlUIs2/aq3R2eQ1H12gwHjRbCkV3hV8g/oX
         puu3AzKhFTDy4Xyot/086jKfyMf+UWFrCgtz/dut2v6+jgmbENq6FftCQ1joDyE99oiD
         UEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=xPQe3mAJAqIOBNafRoq+xaJrp5nS3FabT69MWAxiV8c=;
        b=tJY9GqbyceMaHlZJN4RnikCINJeAeQDcu/oIYdfXctF5riIYXq56u9pergp9LxM8+2
         Vqx7QQO5U0aIb7VuSjzE2R6uCwNLemOAncRHomnq7ECXTD4dcMVqaxb0aFnyU3yiklwp
         zD6lZGkDxaQtBwW1UqWbUsxBEDakG5oY/PRuYW9039a/e3JqDE/BR1zRPv1EDaWSRAwd
         Rj28YCNOILXz1S42Cjrv6ybhVEXA7NKRziUUtbPFUscOafYpvLO7kWEEIJYG/DGucxe7
         P5/O8lUuOmJMRME+4pGDQvZW3Gu8nmsBLvwzNZob8eitsVxQhjyREo0ODGMDFV7wE+KZ
         lUiw==
X-Gm-Message-State: APjAAAWv2+RSzE/ggSqvieUKVRCNnKs4VAUBdnlAf8DbNgX+DbS5Drvc
        rzf+9uf1107jMUH6WxI2HayMMT+++Bs=
X-Google-Smtp-Source: APXvYqxRnqQMSA/wZZ8sbdVP+U2C1rSfv6P4WTWixr2vJuuPitvQFIgkS8jpLF7ew/3nRhWfVAbiiQ==
X-Received: by 2002:a92:4016:: with SMTP id n22mr159989ila.13.1580937560425;
        Wed, 05 Feb 2020 13:19:20 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s2sm208576ioo.77.2020.02.05.13.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 13:19:19 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata changes for 5.6-rc1
Message-ID: <dac0d422-4a49-b50c-7096-2a092ee845ad@kernel.dk>
Date:   Wed, 5 Feb 2020 14:19:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A few minor changes for libata that should go into this merge window.
This pull request contains:

- Adding a Sandisk CF card to supported pata_pcmcia list (Christian)

- Move pata_arasan_cf away from legacy API (Peter)

- Ensure ahci DMA/ints are shut down on shutdown (Prabhakar)

Please pull!


  git://git.kernel.dk/linux-block.git tags/libata-5.6-2020-02-05


----------------------------------------------------------------
Christian Zigotzky (1):
      pata_pcmia: add SanDisk High (>8G) CF card to supported list

Peter Ujfalusi (1):
      ata: pata_arasan_cf: Use dma_request_chan() instead dma_request_slave_channel()

Prabhakar Kushwaha (1):
      ata: ahci: Add shutdown to freeze hardware resources of ahci

 drivers/ata/ahci.c           |  7 +++++++
 drivers/ata/libata-core.c    | 21 +++++++++++++++++++++
 drivers/ata/pata_arasan_cf.c |  6 ++++--
 drivers/ata/pata_pcmcia.c    |  1 +
 include/linux/libata.h       |  1 +
 5 files changed, 34 insertions(+), 2 deletions(-)

-- 
Jens Axboe

