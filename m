Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7B87C851
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 18:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfGaQOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 12:14:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725209AbfGaQOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:14:35 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52302206A3;
        Wed, 31 Jul 2019 16:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564589674;
        bh=3nZlk0eBNHY1d+Gv/KlEoYiujgMy0mBOFWsNo7lFoJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fDBHHkW4nKT2VAx0DNHkH8Hu2aD50O8ZDB/g6v8dRFMQTbrFVS01l4qNhb0mSpgqJ
         JWlcTZnp07CGG1OS8mBPtuPoXwAjpIxAt5VkSwVrSye89pX9hulUjwTCDjkf6VxV7m
         Eg9WZ2BtHA6tCR/KM5LISOtTlXNjUqsNP6jdPWRY=
Date:   Wed, 31 Jul 2019 17:14:30 +0100
From:   Will Deacon <will@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Drewry <wad@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com
Subject: Re: [PATCH] arm64: Move TIF_* documentation to individual definitions
Message-ID: <20190731161430.e4v5ag3ff5p2i6q6@willie-the-truck>
References: <20190731133520.17939-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731133520.17939-1-geert+renesas@glider.be>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 03:35:20PM +0200, Geert Uytterhoeven wrote:
> Some TIF_* flags are documented in the comment block at the top, some
> next to their definitions, some in both places.
> 
> Move all documentation to the individual definitions for consistency,
> and for easy lookup.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> The alternative is to move all of them to the comment block, and using
> linuxdoc style.
> 
>  arch/arm64/include/asm/thread_info.h | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)

Queued for 5.4, with Mark's Ack.

Will
