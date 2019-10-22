Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 525B7E0674
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 16:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731157AbfJVOcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 10:32:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34537 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfJVOcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:32:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19so17472833lja.1;
        Tue, 22 Oct 2019 07:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ytI4V5/h/mkHhHhfCvRJcsGminoY70wuig0aVFQsUiA=;
        b=nx5vrhmiZ+pPfV8tgfB/EK0szh5cs4kP+RIFZmVqkzmkgVbL8eTvdhDaIhFbV88l2L
         b4oa9QavPpKQmoWc/SEiSuOt2o3iwZ3BCvVB/30pIphtFY/8iDqaxmOOsyqzMa3UniEj
         6fDbc7r9uJwtSdLIN65/0CDX70OlsewUevj3igEBsXX7hBcM8Rt0mzTeHbLKFwsNeQH2
         +yJ6uGjzF3fRSDZaZcW0u0ZO2CchL5euHPHYIOtVXZgVPq5ylHnhVVc+j0H8yw2PfNUz
         Wlt1O02ESfDvw5U/0fa/wjbtM6k6AdNmNhDS3UA6BElz8WykA83GWV7I4h52dWEeOZYY
         xApg==
X-Gm-Message-State: APjAAAUO7/pUEgaBO1CMds0OGdiHl1+KwLlZlcTSllJlRkji6otc41bp
        osz5cSX+iOI3QNtPY9yZXuM=
X-Google-Smtp-Source: APXvYqyoFr4Ta+0u7x44vpIpAo4O1i07QKfyppklspOiYCsbo0/o17uvcKPeq30HATv/qyHyHWmaPQ==
X-Received: by 2002:a2e:a0ca:: with SMTP id f10mr18258642ljm.83.1571754721150;
        Tue, 22 Oct 2019 07:32:01 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id b6sm9774020lfi.72.2019.10.22.07.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 07:31:59 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@xi.terra>)
        id 1iMvCn-0001Nb-OW; Tue, 22 Oct 2019 16:32:13 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] USB: ldusb: fix ring-buffer locking
Date:   Tue, 22 Oct 2019 16:32:01 +0200
Message-Id: <20191022143203.5260-1-johan@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a fix for ring-buffer locking issue that was previously posted
as an RFC (1/2), and a new related format specifier clean up.

Johan


Changes since RFC
 - drop the head barrier bits which were not needed and update the
   commit message (1/2)
 - clean up the format specifiers (2/2, new)


Johan Hovold (2):
  USB: ldusb: fix ring-buffer locking
  USB: ldusb: use unsigned size format specifiers

 drivers/usb/misc/ldusb.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
2.23.0

