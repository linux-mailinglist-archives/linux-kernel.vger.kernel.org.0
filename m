Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2276E3F50
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 00:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbfJXWW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 18:22:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42709 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbfJXWW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:22:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id i185so24132oif.9;
        Thu, 24 Oct 2019 15:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HByluYOBZiU98i5lq8f4TYRGZTWms/btKlO2WGzYdh4=;
        b=ss70mQKDwEGmsaJUS+9a+zgsjZMDCjK7jXbr61Y1dQWSpzkn6EpGK05JgQUDKFhaKR
         Aoj5PTpEEMr57TFY6KtR0c+DSFDLLyracahnb534a0hcw2AXQrHDHJ5QOOb1u7I1348s
         pfbyvbwX+ZvbQfSJQPiIxov2l9KVEMm44Hj3IhcsAl6ZETl+JK6aoHyVMQWZguFjGfcS
         li7KIJ8W5EC1qz6ndzo7zJaf+0g/Oa6/F+6B6QTxdEL8gCP5h//Su+nFHZjORb30MmHP
         PC/gzsYMqhtpjUKFz5XO1bl+ikaLhj7gTe3lR+fn+6Ap5QEvsC7IBD6TgyLNQBEIG6DD
         IU3w==
X-Gm-Message-State: APjAAAUK+khrE+KJ+1fyQ/2KoAHfmvsWYAn3ePDlf4UUrjY5veGzQgBy
        TmF18XTVo8sYcuG7nkmdk/EW8Qw=
X-Google-Smtp-Source: APXvYqx6kkm92ig5g9Ejjz9e1DBH2d9WzlX1XrrwKzBxFN04HxzuNd0JzeMBXYlT+pWzcDelYzUc1Q==
X-Received: by 2002:aca:4142:: with SMTP id o63mr314301oia.81.1571955777098;
        Thu, 24 Oct 2019 15:22:57 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c21sm113802otp.15.2019.10.24.15.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:22:56 -0700 (PDT)
Date:   Thu, 24 Oct 2019 17:22:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for v5.4, round 2
Message-ID: <20191024222255.GA25776@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull a couple more DT fixes for 5.4.

Rob


The following changes since commit f437ade3296bacaddb6d7882ba0515940f01daf4:

  dt-bindings: phy: lantiq: Fix Property Name (2019-10-02 14:14:58 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.4-2

for you to fetch changes up to 5dba51754b04a941a1064f584e7a7f607df3f9bc:

  of: reserved_mem: add missing of_node_put() for proper ref-counting (2019-10-23 15:15:05 -0500)

----------------------------------------------------------------
Devicetree fixes for 5.4:

Fix a ref count, memory leak, and Risc-V cpu schema warnings.

----------------------------------------------------------------
Chris Goldsworthy (1):
      of: reserved_mem: add missing of_node_put() for proper ref-counting

Navid Emamdoost (1):
      of: unittest: fix memory leak in unittest_data_add

Rob Herring (1):
      dt-bindings: riscv: Fix CPU schema errors

 Documentation/devicetree/bindings/riscv/cpus.yaml | 29 ++++++++++-------------
 drivers/of/of_reserved_mem.c                      |  4 +++-
 drivers/of/unittest.c                             |  1 +
 3 files changed, 17 insertions(+), 17 deletions(-)
