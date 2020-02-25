Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D51816BE9A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 11:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbgBYKZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 05:25:07 -0500
Received: from ms.lwn.net ([45.79.88.28]:53148 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730139AbgBYKZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:25:06 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 739F66D9;
        Tue, 25 Feb 2020 10:25:05 +0000 (UTC)
Date:   Tue, 25 Feb 2020 03:25:00 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] efi/libstub: add libstub/mem.c to documentation
 tree
Message-ID: <20200225032500.5b6be465@lwn.net>
In-Reply-To: <20200221035832.144960-1-xypron.glpk@gmx.de>
References: <20200221035832.144960-1-xypron.glpk@gmx.de>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 04:58:32 +0100
Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

> Let the description of the efi/libstub/mem.c functions appear in the Kernel
> API documentation in chapter
> 
>     The Linux driver implementer’s API guide
>         Linux Firmware API
>             UEFI Support
>                 UEFI stub library functions
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
> The corresponding source patches are still in efi/next.
> 
> https://lkml.org/lkml/2020/2/20/115
> https://lkml.org/lkml/2020/2/18/37
> https://lkml.org/lkml/2020/2/16/154

Given that this patch depends on work in the efi tree, I'm assuming that
the docs changes will go in via that path as well.

Thanks,

jon
