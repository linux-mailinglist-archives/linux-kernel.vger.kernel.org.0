Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE0A18F461
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 13:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbgCWMVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 08:21:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34054 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbgCWMVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:21:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id 23so7437015pfj.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 05:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gEw/nSefyCMGwymf796eA6LCS/Qx6eIdV2KX90/pK+Y=;
        b=dXBiRNVhRhSOEP8GtY2NMp2ZmTXCJVeLjrW1YMQXHXl8S53U8r0BJsZl2RWs/ihkWT
         JmUCoIDWFWtC7nLk8uuxVxwghPovhx4u5h4vaDnw9X1gciFdt0n/R+GMKjuYDND3d4O2
         0uYWv75tvfYYFLxmLbwmI1m0AKLvBqV9un4r4yqshw1FmW+0mg+zj98J3iJx1BPzwSIj
         Uf6xamUTPIYqC6XjtT5fcgwz9ZDazXLzE+GoDwHSuVxF3F1hHA/J4hIfb21XHQBIeuhw
         AK5tWCbt+6CtF+yqJo5wLAyYjReWAs+Qs/gRsdReQR/9vfTOzfnj2YGv5ScVFlwxInaZ
         Lpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gEw/nSefyCMGwymf796eA6LCS/Qx6eIdV2KX90/pK+Y=;
        b=Ihwt+W4q0lAX0rCp3Duwi9S3lHY00JFHIapbQisktIcoMhOFvlGfZNhyTBSAVI5UlB
         I1+YEud/am5+N/270JsfP0bjTTji69tG256NPBJawipYe8WwMNa0VxkYmGtE7ANIErS3
         VPQ9kf8yrqnd0vPqRIirnEGUig2CY2TGpxLt9v6LKAXe4QUn5mBwoDf9FihpCeFsO9v7
         BUasPfSqW/WxLh4LmqChqgoVnKfryeRR4ChZqk8Tj2mpQAbvxjaAn2GiGzejX4V5KQoP
         mmnUdZY2SZQNLu4ZfArrMFP1wW7oU52eojYblynnvz/iSL1+BxSUqvwgjpCUS8Pev44v
         cPOQ==
X-Gm-Message-State: ANhLgQ2t6HjDFRmq1cQ4KsnvKjlBRb4ZNUAozPMXmznUuuU8Xw3Pun9x
        M3ENAPQ5RszmVRdtZ/hdsGHdBPSn6yqS
X-Google-Smtp-Source: ADFU+vs5QnsxLOQ/T0W9HoxmoGd85kCVzMDizkszaeWiCyty3QoiiJbBovN4W5+a5y1qhybHOGG27A==
X-Received: by 2002:a63:a505:: with SMTP id n5mr15105493pgf.242.1584966078497;
        Mon, 23 Mar 2020 05:21:18 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id w27sm13351438pfq.211.2020.03.23.05.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 05:21:16 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, davem@davemloft.net
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/7] Improvements to MHI Bus
Date:   Mon, 23 Mar 2020 17:51:01 +0530
Message-Id: <20200323122108.12851-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here is the patchset for improving the MHI bus support. One of the patch
is suggested by you for adding the driver owner field and rest are additional
improvements and some fixes.

I've also included the remaining networking patches from previous patch series
which needs review from Dave. Dave could you please look into those 2 patches
which falls under net subsystem? Greg can take those 2 if an Ack is provided.

Thanks,
Mani

Manivannan Sadhasivam (7):
  bus: mhi: core: Pass module owner during client driver registration
  bus: mhi: core: Add support for reading MHI info from device
  bus: mhi: core: Initialize bhie field in mhi_cntrl for RDDM capture
  bus: mhi: core: Drop the references to mhi_dev in mhi_destroy_device()
  bus: mhi: core: Add support for MHI suspend and resume
  net: qrtr: Add MHI transport layer
  net: qrtr: Do not depend on ARCH_QCOM

 drivers/bus/mhi/core/init.c     |  39 +++++-
 drivers/bus/mhi/core/internal.h |  10 ++
 drivers/bus/mhi/core/main.c     |  16 ++-
 drivers/bus/mhi/core/pm.c       | 143 ++++++++++++++++++++++
 include/linux/mhi.h             |  46 ++++++-
 net/qrtr/Kconfig                |   8 +-
 net/qrtr/Makefile               |   2 +
 net/qrtr/mhi.c                  | 208 ++++++++++++++++++++++++++++++++
 8 files changed, 464 insertions(+), 8 deletions(-)
 create mode 100644 net/qrtr/mhi.c

-- 
2.17.1

