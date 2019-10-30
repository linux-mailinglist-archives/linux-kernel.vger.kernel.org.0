Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20F5FEA44A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 20:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfJ3Td0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 15:33:26 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44882 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfJ3TdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 15:33:25 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DF7F314B7A80D;
        Wed, 30 Oct 2019 12:33:24 -0700 (PDT)
Date:   Wed, 30 Oct 2019 12:33:24 -0700 (PDT)
Message-Id: <20191030.123324.2200344682917452634.davem@davemloft.net>
To:     qais.yousef@arm.com
Cc:     tglx@linutronix.de, gregkh@linuxfoundation.org,
        bhelgaas@google.com, rafael.j.wysocki@intel.com,
        sakari.ailus@linux.intel.com, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] sparc: Replace cpu_up/down with
 device_online/offline
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191030153837.18107-6-qais.yousef@arm.com>
References: <20191030153837.18107-1-qais.yousef@arm.com>
        <20191030153837.18107-6-qais.yousef@arm.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 30 Oct 2019 12:33:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qais Yousef <qais.yousef@arm.com>
Date: Wed, 30 Oct 2019 15:38:30 +0000

> The core device API performs extra housekeeping bits that are missing
> from directly calling cpu_up/down.
> 
> See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
> serialization during LPM") for an example description of what might go
> wrong.
> 
> This also prepares to make cpu_up/down a private interface for anything
> but the cpu subsystem.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>

Acked-by: David S. Miller <davem@davemloft.net>
