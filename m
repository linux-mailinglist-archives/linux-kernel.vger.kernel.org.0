Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91F8D1597EB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 19:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgBKSPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 13:15:24 -0500
Received: from foss.arm.com ([217.140.110.172]:51698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbgBKSPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 13:15:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC4F61FB;
        Tue, 11 Feb 2020 10:15:23 -0800 (PST)
Received: from dell3630.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 724303F68E;
        Tue, 11 Feb 2020 10:15:22 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 0/2] drivers base/arch_topology:  Remove 'struct sched_domain' forward declaration & reformat function names
Date:   Tue, 11 Feb 2020 19:15:13 +0100
Message-Id: <20200211181515.32570-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set contains the requested split of
https://lore.kernel.org/r/20200210152420.10608-1-dietmar.eggemann@arm.com

Dietmar Eggemann (2):
  drivers base/arch_topology: Remove 'struct sched_domain' forward
    declaration
  drivers base/arch_topology: Reformat topology_get_[cpu/freq]_scale()
    function name

 include/linux/arch_topology.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

-- 
2.17.1

