Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1450BECFE8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2019 18:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfKBRRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Nov 2019 13:17:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfKBRRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 13:17:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A05521726;
        Sat,  2 Nov 2019 17:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572715066;
        bh=T85nNlBMcQ7FaKrFdoHDwU8ykleL6ryvf/pPxvfUhvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ovukNW3GhHPk5Es7HY1dqIbbqat6KBLRxIKajaxhqh4dBa4XrTMNua+cZJbCPqQwO
         P9SHlRVfpeErpVspM9r28sPtDtLcM9yxzn93XyECMeDfS3XAG51N1M3aJdXt6VG0zK
         ufkVIjEN1F7/66SIhjAwzjf11B+G5h89rwH0zK9Y=
Date:   Sat, 2 Nov 2019 18:17:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] driver: base: cpu: export device_online/offline
Message-ID: <20191102171744.GA537494@kroah.com>
References: <20191030153837.18107-1-qais.yousef@arm.com>
 <20191030153837.18107-8-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030153837.18107-8-qais.yousef@arm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 03:38:32PM +0000, Qais Yousef wrote:
> And the {lock,unlock}_device_hotplug so that they can be used from
> modules.
> 
> This is in preparation to replace cpu_up/down with
> device_online/offline; which kernel/torture.c will require to be
> exported to be built as a module.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: "Rafael J. Wysocki" <rafael@kernel.org>
> CC: linux-kernel@vger.kernel.org
> ---
>  drivers/base/core.c | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
