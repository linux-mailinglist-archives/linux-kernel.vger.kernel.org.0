Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3D3192181
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 08:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgCYHDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 03:03:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42381 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgCYHDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 03:03:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id h8so701416pgs.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 00:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zectWcNtEHLyfgTx3MqEvfVsHuSppDOUvlE/pNSxGo=;
        b=eDH9ZcoDABpzKQNT0W42ZM9EZTxmNCn8VtZHqGhC4DgNYBaIK4lYcelsJYUzDFvL3O
         SFBcP8ZgJpAwzl7F83Mg140MZtjEsYFktuvzhl/RrkmDRywgy1pvkJbztd5rzmjQu7Ko
         25CKRpOyUNpcdgjcKCQ8svfd06vdDShg7GQvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zectWcNtEHLyfgTx3MqEvfVsHuSppDOUvlE/pNSxGo=;
        b=OulkxkjgvtMblAPVVRIv8fe/8YFm6uJFr7sp2TniaTGdVSE6NS85HPxKDFwlfqTs5F
         IbgO/GTNrCnNb9T77VrAiTPomaXYgZHDLN8Dy7iRuvA4/6selph8eHTnPnI3+E5sSEgl
         erWATuO89xCdig1MxKLkrRuzdgao4Rso4z9cWhcj6cxQeD7ZGHDR2vpl6xQ1gv2iAW8b
         zLX+d2RddILzhGkg5UfRXKK4FEUme/e5i1jR895VJSpcY3jwK9Px18gzbrTS8qvXBS1B
         JrkbOEkjxulOcspT+zFrlG1v37wNwEkQxarTHixkTpOF/zUOdrjgO13Y/Qd8RfC4YWal
         cB/Q==
X-Gm-Message-State: ANhLgQ1eFt/L3WWZuPqwojNAqsI79lZ+TnOli+mM6UvgxikBuQKSsDhz
        12UaWetk1PvI6PybAuCgg9NkgA==
X-Google-Smtp-Source: ADFU+vs2i23A8PQwyTj/QbXxX6iqtgCkNFZDCp31M6+qiIky3n7aCBt1nI8B0kuo1z2jbOQoc6JmQA==
X-Received: by 2002:a65:53c5:: with SMTP id z5mr1872714pgr.0.1585119820635;
        Wed, 25 Mar 2020 00:03:40 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id i34sm566240pgm.83.2020.03.25.00.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 00:03:39 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 0/2] btusb: Introduce the use of vendor extension(s)
Date:   Wed, 25 Mar 2020 00:03:34 -0700
Message-Id: <20200325070336.1097-1-mcchou@chromium.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel and Luiz,

The standard HCI does not provide commands/events regarding to
advertisement monitoring with content filter while there are few vendors
providing this feature. Chrome OS BT would like to introduce the use of
vendor specific features where Microsoft vendor extension is targeted at
this moment.

Chrome OS BT would like to utilize Microsoft vendor extension's
advertisement monitoring feature which is not yet a part of standard
Bluetooth specification. This series introduces the driver information for
Microsoft vendor extension, and this was verified with kernel 4.4 on Atlas
Chromebook.

Thanks
Miao

Changes in v2:
- Define struct msft_vnd_ext and add a field of this type to struct
hci_dev to facilitate the support of Microsoft vendor extension.
- Issue a HCI_VS_MSFT_Read_Supported_Features command with
__hci_cmd_sync() instead of constructing a request.

Miao-chen Chou (2):
  Bluetooth: btusb: Indicate Microsoft vendor extension for Intel
    9460/9560 and 9160/9260
  Bluetooth: btusb: Read the supported features of Microsoft vendor
    extension

 drivers/bluetooth/btusb.c          | 17 ++++++-
 include/net/bluetooth/hci_core.h   | 10 ++++
 include/net/bluetooth/vendor_hci.h | 51 +++++++++++++++++++
 net/bluetooth/hci_core.c           | 78 ++++++++++++++++++++++++++++++
 4 files changed, 154 insertions(+), 2 deletions(-)
 create mode 100644 include/net/bluetooth/vendor_hci.h

-- 
2.24.1

