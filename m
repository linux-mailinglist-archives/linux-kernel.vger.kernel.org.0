Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C108AA4640
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 22:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfHaUpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Aug 2019 16:45:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46508 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbfHaUpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 16:45:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id m3so5237148pgv.13
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 13:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Y+AmtBomDnWC/ZAcDYZsWdiJ2eoR1cTsyz9phCUc0P4=;
        b=JgSeGcUBitfm92KGJ9u5xtRpypW+5MGZZuajaKrAkpIuNmFa8pCsIGqdhtQpnpKljf
         TXUJm8BX81fHv3ykVhjGtu4hOwHuWRVM0ujm9PXeS3K9qlWcY0PqkmeYwTDMxJ9bx708
         oIWpuRZSSMs6g1y99ThTwDCWV0+Nbo4+3lXiXIucIha6PfJHJ3rZVBfHsWjdycp6Vf9p
         vYCBZvDBZM6+wBGkB0LY/EQeS6bLORjKKpX0ux4Uy//LZR/IsIB9RKlqijtGMVDulfIa
         3gPwyNYz7ZTewIa8iEYC7PxdWSCE7BqEdhW6iWfU2OyawVksceOP2IMjZnb3k5fq3Z/R
         ClxA==
X-Gm-Message-State: APjAAAWusZ1KSTMnu39yfPsLnI0ZXQDJqY48bpnLajCjsElAKDgySbBS
        aXmKXR+foTCm5Y56qREctN64CA==
X-Google-Smtp-Source: APXvYqxtbR2t0QvkjD60vJ6+OgDU8PeSTlzkmqARJSsvDYH5NigQpRxtN+iK+gBH4bygl7xj9LN9lA==
X-Received: by 2002:a63:10a:: with SMTP id 10mr18787046pgb.281.1567284330418;
        Sat, 31 Aug 2019 13:45:30 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id y8sm11984604pfe.146.2019.08.31.13.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 13:45:29 -0700 (PDT)
Date:   Sat, 31 Aug 2019 13:45:28 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [GIT PULL] Please pull FPGA Manager changes for 5.4
Message-ID: <20190831204528.GA23936@archbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2949dc443116a66fd1a92d9ef107be16cdd197cd:

  dt-bindings: fpga: Consolidate bridge properties (2019-07-24 14:19:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ tags/fpga-cvp-for-5.4

for you to fetch changes up to e58915179f3f4a839ea3b9aeae1c1e13e98e33b1:

  fpga: altera-cvp: Add Stratix10 (V2) Support (2019-08-24 11:38:29 -0700)

----------------------------------------------------------------
FPGA Manager changes for 5.4-rc1

Here is the second set of changes for the 5.4 merge window.

This patchset adds support for the v2 revision of Intel (Altera)'s CVP
parts including the Stratix 10.

All of this patches have been reviewed and been in the last few
linux-next releases without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Thor Thayer (3):
      fpga: altera-cvp: Discover Vendor Specific offset
      fpga: altera-cvp: Preparation for V2 parts.
      fpga: altera-cvp: Add Stratix10 (V2) Support

 drivers/fpga/Kconfig      |   6 +-
 drivers/fpga/altera-cvp.c | 339 ++++++++++++++++++++++++++++++++++++----------
 2 files changed, 271 insertions(+), 74 deletions(-)
