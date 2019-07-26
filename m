Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 631D3774E0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 01:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfGZXRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 19:17:43 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44594 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfGZXRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:17:43 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id BD748200768F;
        Fri, 26 Jul 2019 16:17:42 -0700 (PDT)
From:   Nuno Das Neves <nudasnev@microsoft.com>
To:     nudasnev@microsoft.com, gregkh@linuxfoundation.org,
        sthemmin@microsoft.com, Alexander.Levin@microsoft.com,
        haiyangz@microsoft.com, kys@microsoft.com, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] Basic /sys/hypervisor information for Hyper-V
Date:   Fri, 26 Jul 2019 16:17:24 -0700
Message-Id: <1564183046-128211-1-git-send-email-nudasnev@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches populate /sys/hypervisor with some basic information when running
on Hyper-V. The first patch just introduces /sys/hypervisor/type which contains
"Hyper-V", and the second introduces /sys/hypervisor/version/ which contains a
file for each piece of hypervisor version information.

Nuno Das Neves (2):
  sys-hypervisor: /sys/hypervisor/type for Hyper-V
  sys-hypervisor: version information for Hyper-V

 .../ABI/stable/sysfs-hypervisor-hyperv        |  61 ++++++++
 drivers/hv/Kconfig                            |  10 ++
 drivers/hv/Makefile                           |   7 +-
 drivers/hv/sys-hypervisor.c                   | 143 ++++++++++++++++++
 4 files changed, 218 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-hypervisor-hyperv
 create mode 100644 drivers/hv/sys-hypervisor.c

-- 
2.17.1

