Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8CD7D0D17
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 12:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbfJIKtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 06:49:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39443 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfJIKtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:49:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id 72so1279907lfh.6;
        Wed, 09 Oct 2019 03:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=91+TSRKJghsxG22RU/266qtsCLX3btiIv7LB4QXaP0o=;
        b=Vh/jbl/nE/Em2wCszjDlLF1lupRr8Ot7h6ejW/TV4x/NbdT4So6UJIRhmX3ATj3QmL
         tt7ySgH8gAHffBrPw7dYvXBoM70ZKYKQz1xi8XH6AqvpwkXXAlze3vYM7b4uuC79dw1/
         jmu2MFBtUKxY2kwUIqCdaGcnt2aVrxxCXsk2SHPqCUmNpC89681axrHaDzHPK37FedO0
         IY0hKeOz9+i+qX+IY4CIMuhmCOsDYW2TuHyqKUQz//oJOdootsgR72uMJeAkO8YmOBxv
         Gfkm0ZgwXYtAbK5zLI3tjJpXbIZf+3Dn0XxOkWbR0voBbg67gt9j966b6pXMMzmzntQW
         slnQ==
X-Gm-Message-State: APjAAAXBf5igZ/qzKUBB1LvXkfXMj47aOx+lpfQeNJnn7VpGmyFmQWyw
        M18Em+AmgADqRuu2qkUkjP8=
X-Google-Smtp-Source: APXvYqwGtYNicm/aWG0i+juqqfFgyIPgydUr49mNBX55/fmOZw2d70MkxGcnBcd+q8q4m9gwjFVs0g==
X-Received: by 2002:ac2:4d1b:: with SMTP id r27mr1606804lfi.133.1570618139048;
        Wed, 09 Oct 2019 03:48:59 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id g3sm358175ljj.59.2019.10.09.03.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 03:48:57 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@xi.terra>)
        id 1iI9Wk-0001Ye-1Q; Wed, 09 Oct 2019 12:49:06 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/6] USB: iowarrior: disconnect fixes and locking cleanups
Date:   Wed,  9 Oct 2019 12:48:40 +0200
Message-Id: <20191009104846.5925-1-johan@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a use-after-free bug introduced by a recent
disconnect-deadlock fix that was reported by syzbot. Turns out there was
already a related bug in the driver, and the first patch addresses both
issues.

While looking at the code I found two more use-after-free bugs, which
the next two patches fix.

The next two clean up the driver by dropping two redundant locks.

Tested using a mockup device.

Johan


Johan Hovold (6):
  USB: iowarrior: fix use-after-free on disconnect
  USB: iowarrior: fix use-after-free on release
  USB: iowarrior: fix use-after-free after driver unbind
  USB: iowarrior: drop redundant disconnect mutex
  USB: iowarrior: drop redundant iowarrior mutex
  USB: iowarrior: use pr_err()

 drivers/usb/misc/iowarrior.c | 48 +++++++++++-------------------------
 1 file changed, 15 insertions(+), 33 deletions(-)

-- 
2.23.0

