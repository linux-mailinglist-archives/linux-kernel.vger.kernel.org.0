Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56944AF0B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 19:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437214AbfIJRuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 13:50:07 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:2144 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732449AbfIJRuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1568137806; x=1599673806;
  h=from:to:subject:date:message-id;
  bh=Wd9BZT5mhRC+sg3kUmT7XieFg+66hTOzR6acJxYycRM=;
  b=fpvMXxNxROPiuqHc6OaNsC6r80Q2gQVCulklEOs4Zk4b6P6UtIaKuMHL
   lubrGH+2QCx13K+85PRMuuvkonA5mnNRQLleHH8EzR4DNYfftoHRqd/qI
   L3EVOUTfX3aDW3l2C3WEBYDQeiuyuKepmFl/Z8Sz4w8eDeLi8WpwjNQiR
   I=;
X-IronPort-AV: E=Sophos;i="5.64,490,1559520000"; 
   d="scan'208";a="701858127"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 10 Sep 2019 17:49:38 +0000
Received: from uf8b156e456a5587c9af4.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (Postfix) with ESMTPS id B5062A24F8;
        Tue, 10 Sep 2019 17:49:35 +0000 (UTC)
Received: from uf8b156e456a5587c9af4.ant.amazon.com (localhost [127.0.0.1])
        by uf8b156e456a5587c9af4.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x8AHnXLb023806;
        Tue, 10 Sep 2019 19:49:33 +0200
Received: (from sironi@localhost)
        by uf8b156e456a5587c9af4.ant.amazon.com (8.15.2/8.15.2/Submit) id x8AHnXi2023801;
        Tue, 10 Sep 2019 19:49:33 +0200
From:   Filippo Sironi <sironi@amazon.de>
To:     sironi@amazon.de, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: iommu/amd: Flushing and locking fixes
Date:   Tue, 10 Sep 2019 19:49:20 +0200
Message-Id: <1568137765-20278-1-git-send-email-sironi@amazon.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduce patches to take the domain lock whenever we call
functions that end up calling __domain_flush_pages.  Holding the domain lock is
necessary since __domain_flush_pages traverses the device list, which is
protected by the domain lock.

The first patch in the series adds a completion right after an IOTLB flush in
attach_device.

