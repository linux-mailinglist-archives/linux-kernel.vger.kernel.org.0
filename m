Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21084174CE0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 12:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgCALHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Mar 2020 06:07:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44757 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCALHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 06:07:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id n7so938137wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 03:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=WPAuORwrbkB4ejqORHMLpJA5vMlqpdPB+AhAgsDflXM=;
        b=mOPUQqK3AJgJkNEBSHMEPCV+82fgXZn7GNDRI84trMiZwscU05XfVijhJgF9eEJD54
         4x6hste7UN5zFJaydxIWO1fOuk8UHeqF9h6695Bjv/Fg7IdOK4aIb/ikR7bjs7FMfwj3
         JSGy0wVUxewR1R5Dgxwcclq1c7HC2JVtl5bDKn/M58HSoEDNUwJf6p2+jST3poZeMTSd
         1WyQb9wfKQiucR0rMxTbX2ch06W9HlP8037jqdPSQTb4ddfp8aghVMXbpaffLdkUZHaE
         7H3Jzda+5XfaVT6UambplyYg475JWJ5O7tSEj/0VkrMQIhWW7A2OV8HCYp1iYr0TQgGY
         A5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WPAuORwrbkB4ejqORHMLpJA5vMlqpdPB+AhAgsDflXM=;
        b=SUxHFogGyDIuPsLuaUZf/RwSYD2uCSUzaEbXseBjl0qC6o0ejH7Y/wcU6aRozMr2M+
         Ovh7McBv4CLHXsn+Jl1u6eCPMHYzZjz2J7Xa5cEqPAupfZAAGK8pB7kCLQJZq+CVCveg
         C5U3myQ+pCbWaK9fCImgg84kM0E9TxErtIfvigr2e3Wfwg7l/Emw9VsW9kKlCdIpNtdj
         aFT5OX+vZ2CV4D4gZnOPCFd2ORg/iEtj9D2dItc7tsRbIO3xhQdt0mKQ3ArbDnL69UkJ
         Oa/uFlq8/LS9XmUCh4FQ2uCp0eVCAr7HvqiezR5vd98fuqox8nZZ+5ICGv6tZNltHFSg
         u1Qg==
X-Gm-Message-State: ANhLgQ04uCkHIjGfX3UbohblC6TnZ62Idet7t1XpDac+aS3DyuXDVrbB
        DUNU3dKJJfvG8SndUQAFMRk1kA==
X-Google-Smtp-Source: ADFU+vuGmYD6phCdUsHfqPvdvdZy5eRRSacLOTZDAtctxiazbLCY/FK9XrjT4LgWQXZdWp4k0GZpoQ==
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr4755176wrw.177.1583060860630;
        Sun, 01 Mar 2020 03:07:40 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net. [79.177.42.131])
        by smtp.gmail.com with ESMTPSA id i7sm11563243wma.32.2020.03.01.03.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Mar 2020 03:07:39 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     yan@daynix.com
Subject: [PATCH v2 0/3] virtio-net: introduce features defined in the spec
Date:   Sun,  1 Mar 2020 13:07:30 +0200
Message-Id: <20200301110733.20197-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduce virtio-net features VIRTIO_NET_F_RSC_EXT,
VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT.

Changes from v1:
__virtio -> __le
maximal -> maximum
minor style fixes

Yuri Benditovich (3):
  virtio-net: Introduce extended RSC feature
  virtio-net: Introduce RSS receive steering feature
  virtio-net: Introduce hash report feature

 include/uapi/linux/virtio_net.h | 90 +++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 4 deletions(-)

-- 
2.17.1

