Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E18DD19AC16
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 14:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbgDAMxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 08:53:21 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38087 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732579AbgDAMxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:53:14 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48smMW2J9cz9sTB; Wed,  1 Apr 2020 23:53:11 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 32377bd2cbb62e23ac0a1aaaf0048957c5fd9f02
In-Reply-To: <1574776274-22355-1-git-send-email-ego@linux.vnet.ibm.com>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat11@gmail.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] powernv/opal-sensor-groups: Add documentation for the sysfs interfaces
Message-Id: <48smMW2J9cz9sTB@ozlabs.org>
Date:   Wed,  1 Apr 2020 23:53:10 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-26 at 13:51:14 UTC, "Gautham R. Shenoy" wrote:
> From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> 
> Commit bf9571550f52 ("powerpc/powernv: Add support to clear sensor
> groups data") added a mechanism to clear sensor-group data via a sysfs
> interface. However, the ABI for that interface has not been
> documented.
> 
> This patch documents the ABI for the sysfs interface for sensor-groups
> and clearing the sensor-groups.
> 
> This patch was originally sent by Shilpasri G Bhat on the mailing list:
> https://lkml.org/lkml/2018/8/1/85
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/32377bd2cbb62e23ac0a1aaaf0048957c5fd9f02

cheers
