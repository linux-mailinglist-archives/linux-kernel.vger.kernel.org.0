Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5A2170639
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 18:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgBZRhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 12:37:36 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55394 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgBZRhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:37:36 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id BD4F0260C2B;
        Wed, 26 Feb 2020 17:37:34 +0000 (GMT)
Date:   Wed, 26 Feb 2020 18:37:28 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        =?UTF-8?B?UHJ6ZW15c8WCYXc=?= Gaj <pgaj@cadence.com>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        linux-i3c@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] i3c: Address i3c_device_id related issues
Message-ID: <20200226183728.74df26f5@collabora.com>
In-Reply-To: <20200222102711.1352006-1-boris.brezillon@collabora.com>
References: <20200222102711.1352006-1-boris.brezillon@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2020 11:27:08 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> Hello,
> 
> When the I3C subsystem was introduced part of the modalias generation
> logic was missing (modalias generation based on i3c_device_id tables).
> This patch series addresses that limitation and simplifies our match
> function along the way.
> 
> Regards,
> 
> Boris
> 
> Boris Brezillon (3):
>   i3c: Fix MODALIAS uevents

We also lack a modalias sysfs attribute.

>   i3c: Generate aliases for i3c modules
>   i3c: Simplify i3c_device_match_id()
> 
>  drivers/i3c/device.c              | 50 ++++++++++++++-----------------
>  drivers/i3c/master.c              |  2 +-
>  scripts/mod/devicetable-offsets.c |  7 +++++
>  scripts/mod/file2alias.c          | 19 ++++++++++++
>  4 files changed, 49 insertions(+), 29 deletions(-)
> 

